import 'checklist_storage_service.dart';

class RekapGuruService {
  static Future<List<Map<String, dynamic>>> getRekapByKelas(String kelas) async {
    final siswaList = await ChecklistStorageService.getAllSiswa();
    final result = <Map<String, dynamic>>[];

    for (final siswa in siswaList) {
      if (siswa['kelas'] != kelas) continue;

      final data = await ChecklistStorageService.load(
        siswa['nama']!,
        siswa['kelas']!,
      );

      result.add({
        'nama': siswa['nama'],
        'kelas': siswa['kelas'],
        'checklist': data,
      });
    }

    return result;
  }
}
