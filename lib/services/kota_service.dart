class KotaService {
  static const Map<String, String> kotaMap = {
    'Jakarta': '1301',
    'Bandung': '1219',
    'Bekasi': '1309',
    'Depok': '1321',
    'Bogor': '1204',
    'Surabaya': '1638',
    'Semarang': '1533',
    'Yogyakarta': '1434',
    'Medan': '0901',
    'Palembang': '1609',
    'Makassar': '1901',
  };

  static String getKotaId(String cityName) {
    for (final entry in kotaMap.entries) {
      if (cityName.contains(entry.key)) {
        return entry.value;
      }
    }
    return '1301'; // default Jakarta
  }
}
