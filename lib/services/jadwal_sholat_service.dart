import 'dart:convert';
import 'package:http/http.dart' as http;

class JadwalSholatService {
  static Future<Map<String, String>> fetchJadwal({
    required String kotaId,
  }) async {
    final today = DateTime.now();
    final url =
        'https://api.myquran.com/v2/sholat/jadwal/$kotaId/${today.year}/${today.month}/${today.day}';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    return Map<String, String>.from(
      data['data']['jadwal'],
    );
  }
}
