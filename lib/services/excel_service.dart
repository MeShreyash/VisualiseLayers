import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

Future<List<List<dynamic>>> readExcelData(String assetPath) async {
  final ByteData data = await rootBundle.load(assetPath);
  final excel = Excel.decodeBytes(data.buffer.asUint8List());
  final table = excel.tables.values.first;
  return table.rows;
}
