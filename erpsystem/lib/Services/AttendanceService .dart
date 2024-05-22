import 'package:cloud_firestore/cloud_firestore.dart';
class AttendanceService {
  final CollectionReference attendanceCollection = FirebaseFirestore.instance.collection('attendance');

  Future<void> insertAttendance(Map<String, dynamic> attendance) async {
    await attendanceCollection.add(attendance);
  }

  Future<List<Map<String, dynamic>>> fetchAttendance() async {
    QuerySnapshot snapshot = await attendanceCollection.get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}