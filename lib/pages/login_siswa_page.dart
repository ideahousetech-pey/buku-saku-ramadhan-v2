import 'package:flutter/material.dart';

class LoginSiswaPage extends StatelessWidget {
  const LoginSiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Siswa')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nama Siswa',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Kelas',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['1', '2', '3', '4', '5', '6']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text('Kelas $e'),
                      ))
                  .toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Masuk'),
            ),
          ],
        ),
      ),
    );
  }
}
