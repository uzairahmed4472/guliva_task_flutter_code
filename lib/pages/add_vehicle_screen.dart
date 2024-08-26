import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddVehicleScreen extends StatefulWidget {
  static String id = "add_vehicle_screen";

  const AddVehicleScreen({super.key});

  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();

  // Define variables to hold form data
  String? _typeOfVehicle;
  String? _nameOfVehicle;
  String? _model;
  String? _color;
  String? _year;
  String? _valueOfVehicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/images/guliva_logo_1.png',
          height: 40,
          color: Colors.blue,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Vehicle',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                _buildDropdownFormField(
                  label: 'Type of vehicle',
                  items: [
                    'Car',
                    'Truck',
                    'Motorcycle',
                  ],
                  value: _typeOfVehicle,
                  onChanged: (value) => setState(() => _typeOfVehicle = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a vehicle type'
                      : null,
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  label: 'Name of vehicle',
                  hintText: 'e.g. Benz AL340',
                  value: _nameOfVehicle,
                  onChanged: (value) => setState(() => _nameOfVehicle = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the name of the vehicle'
                      : null,
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  label: 'Model',
                  hintText: 'e.g. AL340',
                  value: _model,
                  onChanged: (value) => setState(() => _model = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the model'
                      : null,
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  label: 'Color',
                  hintText: 'e.g. black',
                  value: _color,
                  onChanged: (value) => setState(() => _color = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the color'
                      : null,
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  label: 'Year',
                  keyboardType: TextInputType.number,
                  value: _year,
                  onChanged: (value) => setState(() => _year = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the year'
                      : null,
                ),
                SizedBox(height: 16),
                _buildTextFormField(
                  label: 'Value of Vehicle',
                  keyboardType: TextInputType.number,
                  value: _valueOfVehicle,
                  onChanged: (value) => setState(() => _valueOfVehicle = value),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the value of the vehicle'
                      : null,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveVehicle();
                    }
                  },
                  child: Text('Add Vehicle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownFormField({
    required String label,
    required List<String> items,
    required String? value,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      value: value,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildTextFormField({
    required String label,
    String? hintText,
    TextInputType? keyboardType,
    required String? value,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
    );
  }

  void _saveVehicle() async {
    // Assuming you have a user token or some authentication mechanism
    const token = 'your_auth_token_here'; // Replace with actual token

    final vehicleData = {
      'typeOfVehicle': _typeOfVehicle,
      'nameOfVehicle': _nameOfVehicle,
      'model': _model,
      'color': _color,
      'year': _year,
      'valueOfVehicle': _valueOfVehicle,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://your-api-url.com/vehicles'), // Replace with your API URL
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(vehicleData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vehicle added successfully!')),
        );
        Navigator.pop(
            context); // Optionally, navigate back or clear the form here
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to add vehicle: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add vehicle: $e')),
      );
    }
  }
}
