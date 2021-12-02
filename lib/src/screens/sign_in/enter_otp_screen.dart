import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:spaces/spaces.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _pinPutController = TextEditingController();

  late String _otpCode;

  @override
  build(context) {
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

    return Consumer<AuthUserProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          key: auth.otpScaffoldKey,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: auth.isLoading
                  ? const CircularProgressIndicator()
                  : SpacedColumn.extraBig(
                      mainAxisSize: MainAxisSize.min,
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        Text("Enter OTP Code",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                        PinPut(
                          autofocus: true,
                          fieldsCount: 6,
                          eachFieldHeight: 48,
                          textStyle: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                          pinAnimationType: PinAnimationType.scale,
                          controller: _pinPutController,
                          onSubmit: (String pin) => _otpCode = pin,
                          fieldsAlignment: MainAxisAlignment.spaceAround,
                          selectedFieldDecoration: selectedDecoration,
                          followingFieldDecoration: defaultDecoration,
                          submittedFieldDecoration: defaultDecoration,
                        ),
                      ],
                    ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.arrow_forward),
            onPressed: () async {
              _otpCode = _pinPutController.text;

              print('onSetup click');

              auth.validateOtpAndLogin(context, _otpCode);
            },
          ),
        );
      },
    );
  }
}
