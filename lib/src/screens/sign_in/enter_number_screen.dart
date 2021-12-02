import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:spaces/spaces.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PhoneNumber number = PhoneNumber(isoCode: 'PK');

  @override
  build(context) {
    return Consumer<AuthUserProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          key: auth.numberScaffoldKey,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: auth.isLoading
                  ? const CircularProgressIndicator()
                  : SpacedColumn.extraBig(
                      mainAxisSize: MainAxisSize.min,
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        Image.asset(
                          'assets/images/brand_logo.png',
                          fit: BoxFit.contain,
                        ),
                        InternationalPhoneNumberInput(
                          countries: const ['PK'],
                          hintText: '03XXXXXXXX',
                          initialValue: number,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          onInputChanged: (number) {
                            this.number = number;
                          },
                        )
                      ],
                    ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.arrow_forward),
            onPressed: () async {
              auth.verifyPhoneNumberAndSendCode(context, number.phoneNumber);
            },
          ),
        );
      },
    );
  }
}
