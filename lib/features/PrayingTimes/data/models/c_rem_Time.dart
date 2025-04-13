import 'dart:convert'; // For JSON encoding and decoding

class CRemTime {
  String remH;
  String remMIn;
  String prayTime;
  String prayName;
  String hijriDay;
  String hijriMonth;
  String hijriYear;

  // Constructor
  CRemTime({
    required this.prayName,
    required this.prayTime,
    required this.remH,
    required this.remMIn,
    required this.hijriDay,
    required this.hijriMonth,
    required this.hijriYear,
  });

  // Convert CRemTime object to a map (for saving to SharedPreferences)
  Map<String, String> toMap() {
    return {
      'prayName': prayName,
      'prayTime': prayTime,
      'remH': remH,
      'remMIn': remMIn,
      'hijriDay': hijriDay,
      'hijriMonth': hijriMonth,
      'hijriYear': hijriYear,
    };
  }

  // Create a CRemTime object from a map (for loading from SharedPreferences)
  factory CRemTime.fromMap(Map<String, String> map) {
    return CRemTime(
      prayName: map['prayName'] ?? '',
      prayTime: map['prayTime'] ?? '',
      remH: map['remH'] ?? '',
      remMIn: map['remMIn'] ?? '',
      hijriDay: map['hijriDay'] ?? '',
      hijriMonth: map['hijriMonth'] ?? '',
      hijriYear: map['hijriYear'] ?? '',
    );
  }

  // Convert CRemTime to a JSON string (for saving in SharedPreferences)
  String toJson() => jsonEncode(toMap());

  // Create CRemTime from JSON string (for loading from SharedPreferences)
  factory CRemTime.fromJson(String json) {
    final map = jsonDecode(json);
    return CRemTime.fromMap(map);
  }
}
