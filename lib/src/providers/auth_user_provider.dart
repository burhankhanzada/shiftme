import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shiftme/src/app.dart';
import 'package:shiftme/src/screens/home/home_screen.dart';
import 'package:shiftme/src/screens/setup_profile.dart';
import 'package:shiftme/src/screens/sign_in/enter_number_screen.dart';
import 'package:shiftme/src/screens/sign_in/enter_otp_screen.dart';
import 'package:shiftme/src/utils/firbase.dart';

class AuthUserProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  late User? firebaseUser = _auth.currentUser;

  final numberScaffoldKey = GlobalKey<ScaffoldState>();
  final otpScaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = false;

  late String _verificationId;

  bool isAuthenticated() => firebaseUser != null;

  Future<void> verifyPhoneNumberAndSendCode(context, phoneNumber) async {
    isLoading = true;
    notifyListeners();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (phonrAuthCredential) {
        signInWithCredential(context, phonrAuthCredential);
      },
      verificationFailed: (firebaseAuthException) {
        showSnackbar(firebaseAuthException.message!);
      },
      codeSent: (verificationId, resendToken) async {
        isLoading = false;

        _verificationId = verificationId;

        await Navigator.of(context).push(
          MaterialPageRoute(builder: (contex) => const OTPScreen()),
        );

        notifyListeners();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void showSnackbar(text) {
    isLoading = false;
    ScaffoldMessenger.of(numberScaffoldKey.currentContext!).showSnackBar(
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

  void signInWithCredential(
    BuildContext context,
    PhoneAuthCredential phonrAuthCredential,
  ) async {
    await _auth.signInWithCredential(phonrAuthCredential).then(
      (userCredential) {
        onAuthenticationSuccessful(context, userCredential);
      },
    ).catchError((error) {
      isLoading = false;

      ScaffoldMessenger.of(numberScaffoldKey.currentContext!).showSnackBar(
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

  void validateOtpAndLogin(context, smsCode) {
    isLoading = true;

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );

    signInWithCredential(context, credential);
  }

  Future<void> onAuthenticationSuccessful(
    BuildContext context,
    UserCredential userCredential,
  ) async {
    if (userCredential.user != null) {
      firebaseUser = userCredential.user;

      await usersRef.doc(firebaseUser!.uid).get().then((value) {
        isLoading = false;

        if (value.exists) {
          App.user = value.data()!;

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (contex) => const HomeScreen()),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (contex) => const SetupProfile()),
            (route) => false,
          );
        }
      });
    }

    notifyListeners();
  }

  Future<void> signOut(context) async {
    await _auth.signOut();
    firebaseUser = null;

    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (contex) => const LoginScreen()),
      (route) => false,
    );

    notifyListeners();
  }
}
