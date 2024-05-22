import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FluroRouter router = FluroRouter();

  MyApp() {
    // Define your routes here
    router.define('/', handler: Handler(handlerFunc: (_, __) => GalleryPage()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery App',
      onGenerateRoute: router.generator,
    );
  }
}

class GalleryItem {
  final String id;
  final String name;
  final String uid;
  final int docType;
  final String url;

  GalleryItem({
    required this.id,
    required this.name,
    required this.uid,
    required this.docType,
    required this.url,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['_id'],
      name: json['_name'],
      uid: json['_uid'].toString(),
      docType: json['_docType'],
      url: json['_url'],
    );
  }
}

class ApiService {
  Future<Map<String, dynamic>> fetchData(String token) async {
    // Implement your API call here
    return {}; // Placeholder response
  }
}

class GalleryController extends GetxController {
  final ApiService _apiService = ApiService();
  final galleryItems = <GalleryItem>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading(true);
    final response = await _apiService.fetchData('YOUR_AUTH_TOKEN');
    if (response.containsKey('data')) {
      final List<dynamic> list = response['data']['list'];
      galleryItems.assignAll(list.map((item) => GalleryItem.fromJson(item)));
    }
    isLoading(false);
  }
}

class GalleryPage extends StatelessWidget {
  final GalleryController galleryController = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: Obx(() {
        if (galleryController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('UID')),
                DataColumn(label: Text('DocType')),
                DataColumn(label: Text('URL')),
              ],
              rows: galleryController.galleryItems.map((item) {
                return DataRow(cells: [
                  DataCell(Text(item.name)),
                  DataCell(Text(item.uid)),
                  DataCell(Text(item.docType.toString())),
                  DataCell(Text(item.url)),
                ]);
              }).toList(),
            ),
          );
        }
      }),
    );
  }
}
