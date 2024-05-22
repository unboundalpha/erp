import 'package:flutter/material.dart';

import 'Services/AuthService .dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String _verificationId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            ElevatedButton(
              onPressed: () {
                _authService.signInWithPhoneNumber(
                  _phoneController.text,
                  (verificationId) => setState(() {
                    _verificationId = verificationId;
                  }),
                );
              },
              child: Text('Send OTP'),
            ),
            if (_verificationId.isNotEmpty)
              TextField(
                controller: _otpController,
                decoration: InputDecoration(labelText: 'OTP'),
              ),
            if (_verificationId.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  _authService.verifyOTP(_verificationId, _otpController.text);
                },
                child: Text('Verify OTP'),
              ),
          ],
        ),
      ),
    );
  }
}