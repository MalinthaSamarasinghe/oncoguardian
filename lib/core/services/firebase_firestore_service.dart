import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oncoguardian/features/risk/models/prediction_response_model.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio();

  static const String _predictionsCollection = 'predictions';
  static const String _backendUrl = 'https://api-kzk4353dja-uc.a.run.app/predict';

  /// Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

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

  /// Read prediction from Firestore for current user
  Future<PredictionResponse?> getPrediction() async {
    try {
      if (currentUserId == null) {
        return null;
      }

      final docSnapshot = await _firestore
          .collection(_predictionsCollection)
          .doc(currentUserId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data['prediction'] != null) {
          return PredictionResponse.fromJson(data['prediction']);
        }
      }

      return null;
    } catch (e) {
      throw Exception('Error reading prediction: $e');
    }
  }

  /// Check if prediction exists for current user
  Future<bool> hasPrediction() async {
    try {
      if (currentUserId == null) {
        return false;
      }

      final docSnapshot = await _firestore
          .collection(_predictionsCollection)
          .doc(currentUserId)
          .get();

      return docSnapshot.exists;
    } catch (e) {
      throw Exception('Error checking prediction: $e');
    }
  }

  /// Delete prediction for current user
  Future<void> deletePrediction() async {
    try {
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }

      await _firestore
          .collection(_predictionsCollection)
          .doc(currentUserId)
          .delete();
    } catch (e) {
      throw Exception('Error deleting prediction: $e');
    }
  }

  /// Get all user's predictions history
  Future<List<PredictionResponse>> getPredictionHistory() async {
    try {
      if (currentUserId == null) {
        return [];
      }

      final querySnapshot = await _firestore
          .collection(_predictionsCollection)
          .where('userId', isEqualTo: currentUserId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            if (data['prediction'] != null) {
              return PredictionResponse.fromJson(data['prediction']);
            }
            return null;
          })
          .whereType<PredictionResponse>()
          .toList();
    } catch (e) {
      throw Exception('Error reading prediction history: $e');
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
