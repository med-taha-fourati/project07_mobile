import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Persistence {
  static const name = 'chat_personalization_data.json';
  Future<File> getJSONFileObject() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    return File('$path/$name');
  }

  Future<void> saveJSONFile(Map<String, String> data) async {
    final file = await getJSONFileObject();
    final JSONString = jsonEncode(data);

    await file.writeAsString(JSONString);
  }

  Future<Map<String, String>> getJSONFromFile() async {
    final file = await getJSONFileObject();

    if (await file.exists()) {
      final contents = await file.readAsString();

      // convert it because dart is stupid
      Map<dynamic, dynamic> lmfao = jsonDecode(contents);
      Map<String, String> converted = lmfao.map((k, v) => MapEntry(k.toString(), v.toString()));
      return converted;
    } else {
      return {};
    }
  }

  static void SaveData(String backgroundColor, String foregroundColor, String apiUrl) async {
    Persistence e = Persistence();
    await e.saveJSONFile({
      'backgroundColor': backgroundColor,
      'foregroundColor': foregroundColor,
      'apiUrl': apiUrl
    });
  }

  static Future<String?> LoadBackgroundColor() async {
    Persistence e = Persistence();
    final w = await e.getJSONFromFile();
    if (w['backgroundColor'] == null) return '';
    return w['backgroundColor'];
  }

  static Future<String?> LoadForegroundColor() async {
    Persistence e = Persistence();
    final w = await e.getJSONFromFile();
    if (w['foregroundColor'] == null) return '';
    return w['foregroundColor'];
  }

  static Future<String?> LoadApiUrl() async {
    Persistence e = Persistence();
    final w = await e.getJSONFromFile();
    if (w['apiUrl'] == null) return '';
    return w['apiUrl'];
  }
}