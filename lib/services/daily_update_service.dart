import 'package:shared_preferences/shared_preferences.dart';

import 'location_service.dart';
import 'kota_service.dart';
import 'jadwal_sholat_service.dart';
import 'adzan_notification_service.dart';

class DailyUpdateService {
  static Future<void> refreshIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    if (prefs.getString('last_update') == today) return;

    String kotaId = prefs.getString('kota_id') ?? '';

    if (kotaId.isEmpty) {
      final cityName = await LocationService.getCityName();
      kotaId = KotaService.getKotaId(cityName ?? '');
      await prefs.setString('kota_id', kotaId);
    }

    final jadwal =
        await JadwalSholatService.fetchJadwal(kotaId: kotaId);

    final sholatMap = {
      'subuh': 1,
      'dzuhur': 2,
      'ashar': 3,
      'maghrib': 4,
      'isya': 5,
    };

    for (final entry in sholatMap.entries) {
      final enabled = prefs.getBool(entry.key) ?? true;

      if (enabled) {
        await AdzanNotificationService.schedule(
          id: entry.value,
          sholat: entry.key,
          time: jadwal[entry.key]!,
        );
      } else {
        await AdzanNotificationService.cancel(entry.value);
      }
    }

    await prefs.setString('last_update', today);
  }
}
