import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase{
  Future<User?> getCurrentUser();
  Stream<User?> authStateChanges();
  Future<User?> signInWithEmail({required String email, required String password});
  Future<User?> signUpWithEmail({required String email, required String password});
  Future<void> logOut();

}
class Auth implements AuthBase{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  Future<User?> getCurrentUser() async {
    return await _auth.currentUser;
  }

  @override
  Future<User?> signInWithEmail({required String email, required String password}) async {
  final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
  return userCredential.user;
  }
  @override
  Future<void> logOut() async {
    await _auth.signOut();
  }
  @override
  Future<User?> signUpWithEmail({required String email, required String password}) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

}