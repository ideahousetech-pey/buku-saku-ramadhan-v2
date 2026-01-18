import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../auth/login_siswa_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  final String _city = 'Jakarta';
  late String _timeNow;

  @override
  void initState() {
    super.initState();

    _timeNow = DateFormat('HH:mm').format(DateTime.now());

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌙 BACKGROUND GRADIENT RAMADHAN
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

          // 🌟 CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FadeTransition(
                opacity: _fade,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🕌 TITLE
                    Text(
                      'Buku Saku Ramadhan',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Kota: $_city',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ⏰ TIME CARD
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white.withAlpha((0.18 * 255).round()),
                        border: Border.all(
                          color: Colors.white.withAlpha((0.25 * 255).round()),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Waktu sekarang: $_timeNow',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 📋 MENU
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _menuCard(
                            icon: Icons.login,
                            title: 'Login Siswa',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginPageSiswa(),
                                ),
                              );
                            },
                          ),
                          _menuCard(
                            icon: Icons.check_circle_outline,
                            title: 'Checklist Ibadah',
                            onTap: () {},
                          ),
                          _menuCard(
                            icon: Icons.notifications_active_outlined,
                            title: 'Adzan',
                            onTap: () {},
                          ),
                          _menuCard(
                            icon: Icons.school_outlined,
                            title: 'Rekap Guru',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🧊 CARD MENU (GLASS STYLE)
  Widget _menuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withAlpha((0.18 * 255).round()),
          border: Border.all(
            color: Colors.white.withAlpha((0.25 * 255).round()),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
