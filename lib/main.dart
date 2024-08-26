import 'package:flutter/material.dart';
import 'package:guliva_interview_task/pages/add_vehicle_screen.dart';
import 'package:guliva_interview_task/pages/login_screen.dart';
import 'package:guliva_interview_task/pages/signup_screen.dart';
import 'package:guliva_interview_task/pages/vehicle_details_screen.dart';
import 'package:guliva_interview_task/pages/vehicles_list_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        VehiclesScreen.id: (context) => VehiclesScreen(),
        VehicleDetailsScreen.id: (context) => VehicleDetailsScreen(),
        AddVehicleScreen.id: (context) => AddVehicleScreen(),
      },
      // onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
