import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shiftme/src/screens/home/home_screen.dart';
import 'package:shiftme/src/screens/login_screen.dart';

enum LoginView {
  enterNumber,
  enterOTP,
}

class AuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  late User? firebaseUser = _auth.currentUser;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var currentView = LoginView.enterNumber;

  var isLoading = false;

  late String _verificationId;

  bool isAuthenticated() => firebaseUser != null;

  verifyPhoneNumberAndSendCode(
    BuildContext context,
    String phoneNumber,
  ) async {
    isLoading = true;
    notifyListeners();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (phonrAuthCredential) {
        signInWithCredential(context, phonrAuthCredential);
      },
      verificationFailed: (firebaseAuthException) {
        currentView = LoginView.enterNumber;

        showSnackbar(firebaseAuthException.message!);
      },
      codeSent: (verificationId, resendToken) {
        isLoading = false;
        currentView = LoginView.enterOTP;
        _verificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  showSnackbar(String text) {
    isLoading = false;
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
    notifyListeners();
  }

  signInWithCredential(
    BuildContext context,
    PhoneAuthCredential phonrAuthCredential,
  ) async {
    await _auth.signInWithCredential(phonrAuthCredential).then(
      (userCredential) {
        onAuthenticationSuccessful(context, userCredential);
      },
    ).catchError((error) {
      isLoading = false;
      currentView = LoginView.enterNumber;

      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(
            error.message!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

      notifyListeners();
    });
  }

  validateOtpAndLogin(BuildContext context, String smsCode) {
    isLoading = true;

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );

    signInWithCredential(context, credential);
  }

  onAuthenticationSuccessful(
    BuildContext context,
    UserCredential userCredential,
  ) async {
    isLoading = false;

    if (userCredential.user != null) {
      firebaseUser = userCredential.user;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    }

    notifyListeners();
  }

  signOut(BuildContext context) async {
    currentView = LoginView.enterNumber;

    await _auth.signOut();
    firebaseUser = null;

    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );

    notifyListeners();
  }
}
