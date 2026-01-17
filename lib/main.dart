import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'pages/home_page.dart';
import 'services/timezone_helper.dart';
import 'services/adzan_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 🔴 INI WAJIB
    await initializeDateFormatting('id_ID', null);

    await TimezoneHelper.init();
    await AdzanNotificationService.init();
  } catch (e, s) {
    debugPrint('INIT ERROR: $e');
    debugPrint('$s');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buku Saku Ramadhan',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}
