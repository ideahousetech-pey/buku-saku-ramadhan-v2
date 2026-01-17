import 'package:flutter/material.dart';

import '../models/siswa.dart';
import '../pages/checklist_siswa_page.dart';
import '../services/checklist_storage_service.dart';

class LoginPageSiswa extends StatefulWidget {
  const LoginPageSiswa({super.key});

  @override
  State<LoginPageSiswa> createState() => _LoginPageSiswaState();
}

class _LoginPageSiswaState extends State<LoginPageSiswa> {
  final TextEditingController _namaController = TextEditingController();
  String _kelas = '1';
  bool _loading = false;

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final nama = _namaController.text.trim();

    if (nama.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama siswa wajib diisi')),
      );
      return;
    }

    setState(() => _loading = true);

    // ✅ simpan siswa untuk keperluan rekap guru
    await ChecklistStorageService.saveSiswa(nama, _kelas);

    setState(() => _loading = false);

    // ✅ pindah ke halaman checklist siswa
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChecklistSiswaPage(
          siswa: Siswa(
            nama: nama,
            kelas: _kelas,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Siswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // INPUT NAMA SISWA
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Siswa',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // PILIH KELAS
            DropdownButtonFormField<String>(
              value: _kelas,
              decoration: const InputDecoration(
                labelText: 'Kelas',
                border: OutlineInputBorder(),
              ),
              items: List.generate(6, (index) {
                final kelas = '${index + 1}';
                return DropdownMenuItem(
                  value: kelas,
                  child: Text('Kelas $kelas'),
                );
              }),
              onChanged: (value) {
                setState(() {
                  _kelas = value ?? '1';
                });
              },
            ),

            const SizedBox(height: 24),

            // TOMBOL MASUK
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _login,
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Masuk'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
