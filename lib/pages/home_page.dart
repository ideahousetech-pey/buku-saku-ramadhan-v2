import 'package:flutter/material.dart';
import '../services/prayer_service.dart';
import '../widgets/menu_item.dart';
import '../widgets/star_background.dart';
import '../widgets/mountain_painter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String>? prayerTimes;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
  }

  Future<void> _loadPrayerTimes() async {
    try {
      final result = await PrayerService.getPrayerTimes();
      if (!mounted) return;
      setState(() {
        prayerTimes = result;
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const StarBackground(),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 180,
            child: CustomPaint(painter: MountainPainter()),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  const Icon(
                    Icons.brightness_2,
                    color: Colors.yellowAccent,
                    size: 64,
                  ),

                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade800,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Column(
                              children: [
                                const Text(
                                  'Imsak & Jadwal Sholat Hari Ini',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Imsak ${prayerTimes?['Imsak'] ?? '--:--'}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(color: Colors.white24),
                                _JadwalItem('Subuh', prayerTimes?['Subuh']),
                                _JadwalItem('Dzuhur', prayerTimes?['Dzuhur']),
                                _JadwalItem('Ashar', prayerTimes?['Ashar']),
                                _JadwalItem('Maghrib', prayerTimes?['Maghrib']),
                                _JadwalItem('Isya', prayerTimes?['Isya']),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MenuItem(icon: Icons.mosque, label: 'Sholat'),
                      MenuItem(icon: Icons.explore, label: 'Kiblat'),
                      MenuItem(icon: Icons.calendar_month, label: 'Jadwal'),
                      MenuItem(
                        icon: Icons.login,
                        label: 'Login Siswa',
                        onTap: () {
                          Navigator.pushNamed(context, '/login-siswa');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _JadwalItem extends StatelessWidget {
  final String name;
  final String? time;

  const _JadwalItem(this.name, this.time);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.white)),
          Text(time ?? '--:--', style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
