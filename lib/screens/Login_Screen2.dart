import 'dart:developer';

import 'package:flutter/material.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  @override
  Widget build(BuildContext context) {
    log(MediaQuery.of(context).size.toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Messenger',
              style: TextStyle(
                  fontSize: 36, fontFamily: AutofillHints.addressState),
            ),
            const SizedBox(height: 20),
            //Review TextFormField
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Login')),
            ),
            const SizedBox(height: 10),
            TextButton(onPressed: () {}, child: const Text('Forgot Password')),
            const SizedBox(height: 10),
            TextButton(onPressed: () {}, child: const Text('Create Account'))
          ],
        ),
      ),
    );
  }
}
