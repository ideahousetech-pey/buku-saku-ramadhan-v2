import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  String _city = 'Jakarta'; // fallback
  String _timeNow = '-';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await _loadTime();
      await _loadLocation(); // OPTIONAL
    } catch (e) {
      debugPrint('Home init error: $e');
    } finally {
      // 🔴 WAJIB → supaya UI muncul
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _loadTime() async {
    _timeNow = DateFormat('HH:mm').format(DateTime.now());
  }

  Future<void> _loadLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // ❗ GPS ditolak → pakai default
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      // nanti bisa reverse geocoding
      debugPrint('GPS OK: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      // ❗ Jangan lempar error ke UI
      debugPrint('GPS error (ignored): $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Saku Ramadhan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kota: $_city',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Waktu sekarang: $_timeNow',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // ke login siswa
              },
              child: const Text('Login Siswa'),
            ),
          ],
        ),
      ),
    );
  }
}
