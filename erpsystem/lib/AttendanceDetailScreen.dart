import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'Services/AttendanceService .dart';

class AttendanceDetailScreen extends StatefulWidget {
  @override
  _AttendanceDetailScreenState createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  final AttendanceService _attendanceService = AttendanceService();

  Future<List<Map<String, dynamic>>> _fetchAttendanceRecords() async {
    return await _attendanceService.fetchAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance Details')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchAttendanceRecords(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var records = snapshot.data!;
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              var record = records[index];
              return ListTile(
                title: Text(record['workerName']),
                subtitle: Text('Check-In: ${record['checkInTime']}, Check-Out: ${record['checkOutTime']}'),
                trailing: FutureBuilder<String>(
                  future: _getAddress(record['latitude'], record['longitude']),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return Text(snapshot.data!);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<String> _getAddress(double latitude, double longitude) async {
    var placemarks = await placemarkFromCoordinates(latitude, longitude);
    var place = placemarks[0];
    return '${place.locality}, ${place.country}';
  }
}