import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseAuthProvider = Provider((_) => FirebaseAuth.instance);
final authStateProvider = StreamProvider<User?>((ref) => ref.watch(firebaseAuthProvider).authStateChanges());
final authServiceProvider = Provider((ref) => AuthService(ref.watch(firebaseAuthProvider)));

class AuthService {
  AuthService(this._auth);
  final FirebaseAuth _auth;

  Future<UserCredential> signInWithGoogle() async {
    final account = await GoogleSignIn(scopes: ['email']).signIn();
    if (account == null) throw FirebaseAuthException(code: 'cancelled', message: 'Google sign-in was cancelled.');
    final tokens = await account.authentication;
    return _auth.signInWithCredential(GoogleAuthProvider.credential(accessToken: tokens.accessToken, idToken: tokens.idToken));
  }

  Future<UserCredential> registerWithEmail(String email, String password) => _auth.createUserWithEmailAndPassword(email: email, password: password);
  Future<UserCredential> signInWithEmail(String email, String password) => _auth.signInWithEmailAndPassword(email: email, password: password);
  Future<void> signOut() => _auth.signOut();
}
