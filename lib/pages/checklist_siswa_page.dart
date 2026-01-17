import 'package:flutter/material.dart';

import '../models/siswa.dart';
import '../models/checklist_item.dart';
import '../services/checklist_reset_service.dart';
import '../services/checklist_storage_service.dart';

class ChecklistSiswaPage extends StatefulWidget {
  final Siswa siswa;

  const ChecklistSiswaPage({
    super.key,
    required this.siswa,
  });

  @override
  State<ChecklistSiswaPage> createState() => _ChecklistSiswaPageState();
}

class _ChecklistSiswaPageState extends State<ChecklistSiswaPage> {

  final List<ChecklistItem> items = [
    ChecklistItem(title: 'Sholat Subuh'),
    ChecklistItem(title: 'Sholat Dzuhur'),
    ChecklistItem(title: 'Sholat Ashar'),
    ChecklistItem(title: 'Sholat Magrib'),
    ChecklistItem(title: 'Sholat Isya'),
    ChecklistItem(title: 'Sholat Tarawih'),
    ChecklistItem(title: 'Puasa'),
    ChecklistItem(title: 'Baca Al-Qur\'an'),
  ];

  @override
  void initState() {
    super.initState();
    _initChecklist();
  }

  Future<void> _initChecklist() async {
    // 1️⃣ Load data tersimpan
    final savedData = await ChecklistStorageService.load(
      widget.siswa.nama,
      widget.siswa.kelas,
    );

    // 2️⃣ Terapkan ke checklist
    for (final item in items) {
      if (savedData.containsKey(item.title)) {
        item.checked = savedData[item.title]!;
      }
    }

    // 3️⃣ Reset harian jika perlu
    final shouldReset = await ChecklistResetService.shouldResetToday();
    if (shouldReset) {
      for (final item in items) {
        item.checked = false;
      }
      await ChecklistStorageService.clear(
        widget.siswa.nama,
        widget.siswa.kelas,
      );
    }

    setState(() {});
  }

  Future<void> _saveChecklist() async {
    final data = {
      for (final item in items) item.title: item.checked,
    };

    await ChecklistStorageService.save(
      widget.siswa.nama,
      widget.siswa.kelas,
      data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.siswa.nama} - Kelas ${widget.siswa.kelas}',
        ),
      ),
      body: ListView(
        children: items.map((item) {
          return CheckboxListTile(
            title: Text(item.title),
            value: item.checked,
            onChanged: (value) async {
              setState(() {
                item.checked = value ?? false;
              });
              await _saveChecklist();
            },
          );
        }).toList(),
      ),
    );
  }
}
