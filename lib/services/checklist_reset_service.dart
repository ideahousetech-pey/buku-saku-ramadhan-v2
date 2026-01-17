import 'package:shared_preferences/shared_preferences.dart';

class ChecklistResetService {
  static const _lastDateKey = 'last_checklist_date';

  /// Return TRUE jika perlu reset hari ini
  static Future<bool> shouldResetToday() async {
    final prefs = await SharedPreferences.getInstance();

    final today = _todayString();
    final lastDate = prefs.getString(_lastDateKey);

    if (lastDate == null || lastDate != today) {
      await prefs.setString(_lastDateKey, today);
      return true;
    }
    return false;
  }

  static String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}
