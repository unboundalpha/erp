import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Services/AttendanceService .dart';
import 'Services/LocationService .dart';
import 'Services/SyncService .dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceService _attendanceService = AttendanceService();
  final LocationService _locationService = LocationService();
  final SyncService _syncService = SyncService();
  final TextEditingController _workerNameController = TextEditingController();

  Future<void> _recordAttendance(bool isCheckIn) async {
    var position = await _locationService.getCurrentLocation();
    var now = DateTime.now();
    var formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    Map<String, dynamic> attendance = {
      'workerName': _workerNameController.text,
      'checkInTime': isCheckIn ? formattedTime : null,
      'checkOutTime': isCheckIn ? null : formattedTime,
      'latitude': position.latitude,
      'longitude': position.longitude,
    };

    await _attendanceService.insertAttendance(attendance);
    await _syncService.syncData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _workerNameController,
              decoration: InputDecoration(labelText: 'Worker Name'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _recordAttendance(true),
                  child: Text('Check In'),
                ),
                ElevatedButton(
                  onPressed: () => _recordAttendance(false),
                  child: Text('Check Out'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}