import 'dart:convert';

import 'package:get/get.dart';
import 'package:si_lelang/database/api.dart';
import 'package:http/http.dart' as http;
import 'package:si_lelang/model/barang.dart';

class BarangController extends GetxController {
  var barangList = <Barang>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    var response = await http.get(Uri.parse(Api.urlgetbarang));
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body.toString());
      
      List<Barang> fetchedBarangList = [];

      for (int i = 0; i < json.length; i++) {
        Barang barang = Barang.fromJson(json[i]);
        fetchedBarangList.add(barang);
      }

      barangList.assignAll(fetchedBarangList);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
