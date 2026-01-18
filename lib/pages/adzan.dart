import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';

class AdzanPage extends StatefulWidget {
  const AdzanPage({super.key});

  @override
  State<AdzanPage> createState() => _AdzanPageState();
}

class _AdzanPageState extends State<AdzanPage> {
  Map<String, String> prayerTimes = {};
  final AudioPlayer audioPlayer = AudioPlayer();

  // API config
  final String apiKey = "YOUR_ISLAMICAPI_KEY"; // ganti dengan API Key Anda
  final double latitude = -6.914744;   // contoh koordinat Jakarta
  final double longitude = 107.609810; // contoh koordinat Jawa Barat

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    final url = Uri.parse(
      "https://islamicapi.com/api/v1/prayer-time/?lat=$latitude&lon=$longitude&method=20&api_key=$apiKey"
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          prayerTimes = {
            "Fajr": data["data"]["times"]["Fajr"],
            "Dhuhr": data["data"]["times"]["Dhuhr"],
            "Asr": data["data"]["times"]["Asr"],
            "Maghrib": data["data"]["times"]["Maghrib"],
            "Isha": data["data"]["times"]["Isha"],
          };
        });
      } else {
        debugPrint("Error fetching prayer times: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Fetch error: $e");
    }
  }

  void playAdzan() async {
    await audioPlayer.play(AssetSource('audio/adzan.mp3'));
  }

  String getCurrentTime() {
    return DateFormat.Hm().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jadwal Adzan"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Waktu sekarang: ${getCurrentTime()}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: prayerTimes.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      children: prayerTimes.entries.map((entry) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.access_time),
                            title: Text(entry.key),
                            subtitle: Text(entry.value),
                            trailing: IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: playAdzan,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
