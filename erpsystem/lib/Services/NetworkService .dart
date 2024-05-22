// import 'dart:convert';
// class NetworkService {
//   final String apiUrl = 'https://your-api-url.com/attendance';

//   Future<void> uploadAttendance(Map<String, dynamic> attendance) async {
//     var response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(attendance),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to upload attendance');
//     }
//   }
// }