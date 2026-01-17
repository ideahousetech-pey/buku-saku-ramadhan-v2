import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'utils/timezone_helper.dart';
import 'services/adzan_notification_service.dart';
import 'services/daily_update_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await TimezoneHelper.init();
  await AdzanNotificationService.init();
  await DailyUpdateService.refreshIfNeeded();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buku Saku Ramadhan',
      home: const HomePage(),
    );
  }
}
