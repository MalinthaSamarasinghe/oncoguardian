import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oncoguardian/features/risk/models/prediction_response_model.dart';

class FirebaseFirestoreService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final Dio _dio;

  FirebaseFirestoreService({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    Dio? dio,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _dio = dio ?? Dio();

  static const String _backendUrl = 'https://api-kzk4353dja-uc.a.run.app/predict';
  static const String _predictionsCollection = 'predictions';

  /// Get current user ID
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  /// Send patient data to backend API and save prediction to Firestore
  Future<PredictionResponse?> savePrediction(Map<String, dynamic> patientData) async {
    try {
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }

      // Send data to backend API
      final response = await _dio.post(
        _backendUrl,
        data: patientData,
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        final predictionResponse = PredictionResponse.fromJson(response.data);

        // Save prediction to Firestore with user ID and timestamp
        await _firestore
            .collection(_predictionsCollection)
            .doc(currentUserId)
            .set({
              'userId': currentUserId,
              'prediction': predictionResponse.toJson(),
              'patientData': patientData,
              'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
            });

        return predictionResponse;
      } else {
        throw Exception('Failed to get prediction: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      throw Exception('Error saving prediction: $e');
    }
  }

  /// Stream predictions for real-time updates
  Stream<PredictionResponse?> getPredictionStream() {
    if (currentUserId == null) {
      return Stream.value(null);
    }

    return _firestore
        .collection(_predictionsCollection)
        .doc(currentUserId)
        .snapshots()
        .map((docSnapshot) {
          if (docSnapshot.exists) {
            final data = docSnapshot.data();
            if (data != null && data['prediction'] != null) {
              return PredictionResponse.fromJson(data['prediction']);
            }
          }
          return null;
        });
  }
}
