import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:excel/excel.dart';

Future<List<Map<String, dynamic>>> readExcelData(String filePath) async {
  var bytes = File(filePath).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  // Assuming the data is in the first sheet
  var sheet = excel.tables.values.first;
  var _shopData = <Map<String, dynamic>>[];

  // Assuming the data starts from the second row (row index 1)
  for (var i = 1; i < sheet.rows.length; i++) {
    var row = sheet.rows[i];
    var shopId = row[0]?.value;
    var latLong = row[1]?.value.split(", ");
    var latitude = latLong[0];
    var longitude = latLong[1];

    _shopData.add({
      'shopId': shopId,
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  return _shopData;
}
