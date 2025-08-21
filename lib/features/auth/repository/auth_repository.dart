import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    final userCred = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCred.user;
  }

  Future<User?> signupUser({
    required String email,
    required String password,
    required String name,
  }) async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    if (user != null) {
      await firestore.collection("admins").doc(user.uid).set({
        "uid": user.uid,
        "name": name,
        "email": email,
        "role": "admin",
        "createdAt": Timestamp.now().millisecondsSinceEpoch,
      });
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();
}
