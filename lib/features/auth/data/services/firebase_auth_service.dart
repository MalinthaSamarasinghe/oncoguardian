import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Get the current authenticated user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Get user's authentication state stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Create a new user account with email and password
  Future<UserCredential> createUserWithEmailAndPassword({required String email, required String password, required String fullName}) async {
    try {
      // Create user with email and password
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Update user profile with full name
      await userCredential.user?.updateDisplayName(fullName.trim());
      await userCredential.user?.reload();

      debugPrint('User created successfully: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException in createUserWithEmailAndPassword: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Exception in createUserWithEmailAndPassword: $e');
      rethrow;
    }
  }

  /// Sign in user with email and password
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      debugPrint('User signed in successfully: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'FirebaseAuthException in signInWithEmailAndPassword: ${e.code} - ${e.message}',
      );
      rethrow;
    } catch (e) {
      debugPrint('Exception in signInWithEmailAndPassword: $e');
      rethrow;
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      debugPrint('User signed out successfully');
    } catch (e) {
      debugPrint('Exception in signOut: $e');
      rethrow;
    }
  }

  /// Get user's ID token
  Future<String> getIdToken() async {
    try {
      final idToken = await _firebaseAuth.currentUser?.getIdToken();
      return idToken ?? '';
    } catch (e) {
      debugPrint('Exception in getIdToken: $e');
      rethrow;
    }
  }

  /// Get Firebase Auth error message
  String getAuthErrorMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'invalid-credential':
        return 'The provided credential is invalid.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No user account found for this email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      default:
        return exception.message ?? 'An authentication error occurred.';
    }
  }
}
