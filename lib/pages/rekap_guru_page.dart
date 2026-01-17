import 'package:flutter/material.dart';
import '../services/rekap_guru_service.dart';

class RekapGuruPage extends StatefulWidget {
  const RekapGuruPage({super.key});

  @override
  State<RekapGuruPage> createState() => _RekapGuruPageState();
}

class _RekapGuruPageState extends State<RekapGuruPage> {
  String _kelas = '1';
  List<Map<String, dynamic>> _rekap = [];
  bool _loading = false;

  Future<void> _loadRekap() async {
    setState(() => _loading = true);

    final data = await RekapGuruService.getRekapByKelas(_kelas);

    setState(() {
      _rekap = data;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRekap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rekap Guru')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: DropdownButtonFormField<String>(
              initialValue: _kelas,
              items: List.generate(6, (i) {
                final k = '${i + 1}';
                return DropdownMenuItem(
                  value: k,
                  child: Text('Kelas $k'),
                );
              }),
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  _kelas = v;
                });
                _loadRekap();
              },
              decoration: const InputDecoration(
                labelText: 'Pilih Kelas',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _rekap.length,
                    itemBuilder: (context, index) {
                      final siswa = _rekap[index];
                      final checklist =
                          (siswa['checklist'] as Map<String, bool>);

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(siswa['nama']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: checklist.entries.map((e) {
                              return Text(
                                '${e.key}: ${e.value ? "✓" : "✗"}',
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
