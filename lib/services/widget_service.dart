import 'package:home_widget/home_widget.dart';

class WidgetService {
  static Future<void> update({
    required String nextPrayer,
    required String time,
  }) async {
    await HomeWidget.saveWidgetData('next_prayer', nextPrayer);
    await HomeWidget.saveWidgetData('prayer_time', time);
    await HomeWidget.updateWidget(
      androidName: 'PrayerWidgetProvider',
    );
  }
}
