import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login-----

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(e.message.toString(), "");
    } catch (e) {
      print(e);
    }
  }

  //Logout-------

  Future SignOut() async {
    await firebaseAuth.signOut();
  }
}
