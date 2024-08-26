import 'package:flutter/material.dart';
import 'package:guliva_interview_task/pages/signup_screen.dart';
import 'package:guliva_interview_task/pages/vehicles_list_screen.dart';
import 'package:guliva_interview_task/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('Please fill in all fields.');
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      _showSnackBar('Please enter a valid email address.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userData = await AuthService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // print("login ${userData.data!.token}");
      Navigator.pushNamed(context, VehiclesScreen.id, arguments: {
        "email": userData.data!.email,
        "token": userData.data!.token!,
      });
    } catch (e) {
      // print(e);
      _showSnackBar('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isValidEmail(String email) {
    // Basic email validation using regex
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegExp.hasMatch(email);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50.0),
            Image.asset(
              'assets/images/guliva_logo_1.png',
              height: 60.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.topLeft,
              child: const Text(
                "Log In",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text("LOG IN WITH..."),
            const SizedBox(height: 10.0),
            _buildSocialLoginButtons(),
            const SizedBox(height: 20.0),
            const Text("LOG IN WITH EMAIL"),
            const SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email address",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50.0),
                    ),
                    child: const Text("LOG IN"),
                  ),
            const SizedBox(height: 20.0),
            const Icon(Icons.fingerprint, size: 50.0),
            const Text("Touch / Face ID"),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.id);
              },
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton.icon(
          onPressed: () {
            // Handle Google login
          },
          icon: const Icon(Icons.g_mobiledata),
          label: const Text("GOOGLE"),
        ),
        OutlinedButton.icon(
          onPressed: () {
            // Handle Facebook login
          },
          icon: const Icon(Icons.facebook),
          label: const Text("FACEBOOK"),
        ),
      ],
    );
  }
}
