
import 'package:connectivity_plus/connectivity_plus.dart';
import 'AttendanceService .dart';

class SyncService {
  final AttendanceService _attendanceService = AttendanceService();

  Future<void> syncData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      List<Map<String, dynamic>> records = await _attendanceService.fetchAttendance();
      for (var record in records) {
        await _attendanceService.insertAttendance(record);
      }
      // Clear local database if using SQLite
    }
  }
}