// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/product_list_screen.dart';
import 'package:test_1/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Provider.of<AuthProvider>(context, listen: false)
                //     .login(_emailController.text, _passwordController.text)
                //     .then((_) {
                //   Navigator.pushReplacement(MaterialPageRoute(builder: (context) => const ProductListScreen()));

                // }).catchError((error) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text(error.toString()),
                //   ));
                // });
                Provider.of<AuthProvider>(context, listen: false)
                    .login(_emailController.text, _passwordController.text)
                    .then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProductScreen()),
                  );
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                });
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
