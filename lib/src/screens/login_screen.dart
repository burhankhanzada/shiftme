import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/providers/auth_provider.dart';
import 'package:spaces/spaces.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _pinPutController = TextEditingController();

  late String _otpCode;

  PhoneNumber number = PhoneNumber(isoCode: 'PK');

  @override
  build(context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          key: auth.scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: auth.isLoading
                  ? const CircularProgressIndicator()
                  : SpacedColumn.extraBig(
                      mainAxisSize: MainAxisSize.min,
                      padding: const EdgeInsets.all(16.0),
                      children: auth.currentView == LoginView.enterOTP
                          ? enterOTPCode()
                          : enterPhoneNumberView(),
                    ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.arrow_forward),
            onPressed: () async {
              if (auth.currentView == LoginView.enterOTP) {
                _otpCode = _pinPutController.text;

                auth.validateOtpAndLogin(context, _otpCode);
              } else {
                auth.verifyPhoneNumberAndSendCode(context, number.phoneNumber);
              }
            },
          ),
        );
      },
    );
  }

  enterPhoneNumberView() {
    return [
      Image.asset(
        'assets/images/brand_logo.png',
        fit: BoxFit.contain,
      ),
      InternationalPhoneNumberInput(
        countries: const ['PK'],
        hintText: '03XXXXXXXX',
        initialValue: PhoneNumber(isoCode: 'PK'),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        onInputChanged: (number) {
          this.number = number;
        },
        onInputValidated: (value) {
          print(value);
        },
      )
    ];
  }

  enterOTPCode() {
    final selectedDecoration = BoxDecoration(
      // color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Theme.of(context).colorScheme.secondary,
        width: 2.5,
      ),
    );

    final defaultDecoration = BoxDecoration(
      // color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 2.5,
      ),
    );

    return [
      Text("Enter OTP Code",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Theme.of(context).colorScheme.primary)),
      PinPut(
        autofocus: true,
        fieldsCount: 6,
        eachFieldHeight: 48,
        textStyle: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: Theme.of(context).colorScheme.primary),
        pinAnimationType: PinAnimationType.scale,
        controller: _pinPutController,
        onSubmit: (String pin) => _otpCode = pin,
        fieldsAlignment: MainAxisAlignment.spaceAround,
        selectedFieldDecoration: selectedDecoration,
        followingFieldDecoration: defaultDecoration,
        submittedFieldDecoration: defaultDecoration,
      ),
    ];
  }
}
