import 'package:bianat_app/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  late GoogleSignIn googleSignIn;
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  RxBool isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() async {
    googleSignIn = GoogleSignIn();
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = await firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.goToHomeRoute(),
          arguments: firebaseAuth.currentUser);
    } else {
      Get.offAllNamed(AppRoutes.goToAuthRoute());
    }
  }

  Future signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);

      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signout() async {
    try {
      await googleSignIn.disconnect();
      await firebaseAuth.signOut();
      update();
      Get.offAllNamed(AppRoutes.goToAuthRoute());
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
