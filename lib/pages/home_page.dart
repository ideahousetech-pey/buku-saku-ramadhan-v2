import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/daily_update_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await DailyUpdateService.refreshIfNeeded();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final today =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HEADER
                    const Text(
                      'Buku Saku Ramadhan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      today,
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 24),

                    /// CARD WAKTU SHOLAT
                    _buildMainCard(),

                    const SizedBox(height: 20),

                    /// STATUS
                    _buildStatus(),

                    const Spacer(),

                    /// FOOTER
                    Center(
                      child: Text(
                        'Adzan & Jadwal otomatis aktif',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Waktu Sholat',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Adzan Berikutnya',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Notifikasi aktif',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatus() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 13),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.notifications_active, color: Colors.green),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Adzan otomatis aktif sesuai lokasi dan jadwal hari ini',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
