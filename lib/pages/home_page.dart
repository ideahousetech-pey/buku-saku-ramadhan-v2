import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../auth/login_siswa_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  late DateTime _now;

  // ✅ _city sekarang dipakai di UI
  final String _city = 'Jakarta';

  final List<Map<String, String>> _prayerTimes = [
    {'name': 'Subuh', 'time': '04:36'},
    {'name': 'Dzuhur', 'time': '12:01'},
    {'name': 'Ashar', 'time': '15:25'},
    {'name': 'Maghrib', 'time': '18:07'},
    {'name': 'Isya', 'time': '19:18'},
  ];

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _currentPrayer() {
    for (final prayer in _prayerTimes) {
      final time = DateFormat('HH:mm').parse(prayer['time']!);
      final prayerTime = DateTime(
        _now.year,
        _now.month,
        _now.day,
        time.hour,
        time.minute,
      );

      if (_now.isBefore(prayerTime)) {
        return prayer['name']!;
      }
    }
    return 'Isya';
  }

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('HH:mm:ss').format(_now);
    final nextPrayer = _currentPrayer();

    return Scaffold(
      body: Stack(
        children: [
          // 🌙 BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    'Buku Saku Ramadhan',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  // ✅ Tampilkan kota
                  Text(
                    _city,
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 20),

                  // ⏰ REALTIME CLOCK
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: _glass(),
                    child: Column(
                      children: [
                        Text(
                          timeString,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Menuju $nextPrayer',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 🕌 JADWAL SHOLAT
                  Text(
                    'Jadwal Sholat',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),

                  Column(
                    children: _prayerTimes.map((prayer) {
                      final isNext = prayer['name'] == nextPrayer;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: _glass(
                          highlight: isNext,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prayer['name']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight:
                                    isNext ? FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                            Text(
                              prayer['time']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight:
                                    isNext ? FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  // LOGIN
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.login),
                      label: const Text('Login Siswa'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginPageSiswa(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _glass({bool highlight = false}) {
    return BoxDecoration(
      color: highlight
          ? Colors.white.withAlpha((0.28 * 255).round())
          : Colors.white.withAlpha((0.18 * 255).round()),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: Colors.white.withAlpha((0.25 * 255).round()),
      ),
    );
  }
}
