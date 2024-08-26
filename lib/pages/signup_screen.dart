// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:guliva_interview_task/pages/login_screen.dart';
import 'package:guliva_interview_task/services/auth_service.dart';

import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  static String id = "sign_up_screen";

  const SignUpScreen({super.key});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;
  bool _isAgreed = false;
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  // Controllers to capture input
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
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
              const Text(
                "SIGN UP WITH EMAIL",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.calendar_today,
                    ),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your date of birth';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "I agree to the "),
                      TextSpan(
                        text: "Terms & Conditions",
                        style: TextStyle(color: Colors.orange),
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                value: _isAgreed,
                onChanged: (value) {
                  setState(() {
                    _isAgreed = value!;
                  });
                },
              ),
              const SizedBox(height: 10.0),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50.0),
                      ),
                      child: const Text("SIGN UP"),
                    ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.id);
                },
                child: const Text(
                  "Already have an account? Log In",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (!_isAgreed) {
        _showSnackBar("You must agree to the terms and conditions.");
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await AuthService.signUp(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phoneNo: _phoneController.text.trim(),
          email: _emailController.text.trim(),
          dob: _dobController.text.trim(),
          password: _passwordController.text.trim(),
          withEmail: true,
        );

        // Assuming `response` contains a success indication and relevant data
        if (response['success']) {
          _showSnackBar("Signup successful!");

          // Navigate to login screen after a short delay
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          });
        } else {
          _showSnackBar('Error: ${response['message']}');
        }
      } catch (e) {
        _showSnackBar('Error: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
