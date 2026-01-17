import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class PrayerService {
  static Future<Map<String, String>> getPrayerTimes() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location service disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied forever');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    final url = Uri.parse(
      'https://api.aladhan.com/v1/timings'
      '?latitude=${position.latitude}'
      '&longitude=${position.longitude}'
      '&method=11',
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    final timings = data['data']['timings'];

    return {
      'Imsak': timings['Imsak'],
      'Subuh': timings['Fajr'],
      'Dzuhur': timings['Dhuhr'],
      'Ashar': timings['Asr'],
      'Maghrib': timings['Maghrib'],
      'Isya': timings['Isha'],
    };
  }
}
