import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guliva_interview_task/models/vehicleData_model.dart';
import 'package:guliva_interview_task/pages/add_vehicle_screen.dart';
import 'package:guliva_interview_task/pages/vehicle_details_screen.dart';
import 'package:guliva_interview_task/utils/constants.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VehiclesScreen extends StatefulWidget {
  static String id = 'home_screen';

  const VehiclesScreen({super.key});

  @override
  _VehiclesScreenState createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _token;
  List<VehicleData> vehicleList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _token = args["token"];
      fetchUserData(token: _token);
    });
  }

  Future<void> fetchUserData({required String token}) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse("${Constants.baseURL}/vehicle/all?success=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['data'] != null && body['data'] is List) {
          List<dynamic> data = body['data'];
          setState(() {
            vehicleList =
                data.map((item) => VehicleData.fromJson(item)).toList();
          });
          // print('Number of vehicles: ${vehicleList.length}');
        } else {
          // print('No data available or data is not in expected format');
        }
      } else {
        throw "Failed to fetch data. Error: ${response.statusCode}";
      }
    } on SocketException catch (_) {
      throw "No Internet Connection Found";
    } on TimeoutException catch (_) {
      throw "Taking too long to respond";
    } catch (e) {
      throw "Error: $e";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _token = args["token"];

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.blue,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Vehicles"),
                    Tab(text: "Passengers"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: vehicleList.length,
                              itemBuilder: (context, index) {
                                final vehicle = vehicleList[index];
                                return Card(
                                  margin: EdgeInsets.all(10),
                                  elevation: 5,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 24,
                                      child: vehicle.frontView != null &&
                                              vehicle.frontView!.isNotEmpty
                                          ? ClipOval(
                                              child: Image.network(
                                                vehicle.frontView!,
                                                fit: BoxFit.cover,
                                                width: 48,
                                                height: 48,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  );
                                                },
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/images/guliva_header.png',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    title: Text(vehicle.name ?? 'No Name'),
                                    subtitle: Text(vehicle.model ?? 'No Model'),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        VehicleDetailsScreen.id,
                                        arguments:
                                            vehicle, // Pass the vehicle data
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Text('Passengers'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddVehicleScreen.id);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "ADD VEHICLE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
