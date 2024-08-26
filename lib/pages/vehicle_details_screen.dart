import 'package:flutter/material.dart';
import 'package:guliva_interview_task/models/trip_model.dart';
import 'package:guliva_interview_task/models/vehicleData_model.dart';

class VehicleDetailsScreen extends StatelessWidget {
  static String id = 'vehicleDetails_screen';

  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VehicleData vehicle =
        ModalRoute.of(context)!.settings.arguments as VehicleData;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/guliva_logo_1.png',
          height: 40,
          color: Colors.blue,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vehicle.name ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _VehicleTabBar(vehicle: vehicle),
          ],
        ),
      ),
    );
  }
}

class _VehicleTabBar extends StatelessWidget {
  final VehicleData vehicle;

  const _VehicleTabBar({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Trips'),
              Tab(text: 'Insurance'),
            ],
          ),
          SizedBox(
            height: 400, // Adjust as necessary
            child: TabBarView(
              children: [
                VehicleDetailsTab(vehicle: vehicle),
                TripTabView(trips: vehicle.trips!),
                Center(child: Text('Insurance')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VehicleDetailsTab extends StatelessWidget {
  final VehicleData vehicle;

  const VehicleDetailsTab({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow(label: 'Name of vehicle', value: vehicle.name ?? 'No Name'),
          DetailRow(label: 'Model', value: vehicle.model ?? 'No Model'),
          DetailRow(label: 'Color', value: vehicle.color ?? 'No Color'),
          DetailRow(label: 'Year', value: vehicle.year ?? 'No Year'),
          DetailRow(
              label: 'Primary Driver',
              value: vehicle.user?.firstName ?? 'No Driver'),
          SizedBox(height: 16),
          Text('Photo attached',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _buildVehicleImages(),
          SizedBox(height: 16),
          DetailRow(
              label: 'Total Distance Covered (km)',
              value: vehicle.distanceCovered?.toStringAsFixed(2) ?? '0'),
          DetailRow(
              label: 'Amount Billed',
              value: vehicle.amountBilled?.toStringAsFixed(2) ?? '0'),
        ],
      ),
    );
  }

  Widget _buildVehicleImages() {
    return Row(
      children: [
        Expanded(child: _buildImage(vehicle.frontView)),
        SizedBox(width: 8),
        Expanded(child: _buildImage(vehicle.backView)),
        SizedBox(width: 8),
        Expanded(child: _buildImage(vehicle.sideView)),
        SizedBox(width: 8),
        Expanded(child: _buildImage(vehicle.topView)),
      ],
    );
  }

  Widget _buildImage(String? imageUrl) {
    return Image.network(
      imageUrl ?? '',
      width: 60,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child; // Image is loaded
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(child: Icon(Icons.error, color: Colors.red));
      },
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class TripTabView extends StatelessWidget {
  final List<Trip> trips;

  const TripTabView({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    return trips.isEmpty
        ? Center(child: Text('No trips available'))
        : ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return TripCard(trip: trip);
            },
          );
  }
}

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('Trip from ${trip.origin} to ${trip.destination}'),
        subtitle: Text(
            'Distance: ${trip.distanceCovered?.toStringAsFixed(2)} km\nBilled: \$${trip.amountBilled?.toStringAsFixed(2)}'),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripDetailsScreen(trip: trip),
            ),
          );
        },
      ),
    );
  }
}

class TripDetailsScreen extends StatelessWidget {
  final Trip trip;

  const TripDetailsScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip from ${trip.origin} to ${trip.destination}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Start Date: ${trip.tripStartDate}'),
            Text('End Date: ${trip.tripEndDate}'),
            Text(
                'Distance Covered: ${trip.distanceCovered?.toStringAsFixed(2)} km'),
            Text('Amount Billed: \$${trip.amountBilled?.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
