import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChecklistStorageService {

  static String _key(String nama, String kelas) {
    return 'checklist_${nama}_$kelas';
  }

  static Future<void> save(
    String nama,
    String kelas,
    Map<String, bool> data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key(nama, kelas), jsonEncode(data));
  }

  static Future<Map<String, bool>> load(
    String nama,
    String kelas,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key(nama, kelas));

    if (jsonString == null) return {};

    final Map<String, dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((key, value) => MapEntry(key, value as bool));
  }

  static Future<void> clear(
    String nama,
    String kelas,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key(nama, kelas));
  }

  static const _siswaListKey = 'siswa_list';

static Future<void> saveSiswa(String nama, String kelas) async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList(_siswaListKey) ?? [];

  final key = '$nama|$kelas';
  if (!list.contains(key)) {
    list.add(key);
    await prefs.setStringList(_siswaListKey, list);
  }
}

static Future<List<Map<String, String>>> getAllSiswa() async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList(_siswaListKey) ?? [];

  return list.map((e) {
    final parts = e.split('|');
    return {
      'nama': parts[0],
      'kelas': parts[1],
    };
  }).toList();
}

}
