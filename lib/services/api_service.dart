import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> fetchCountryData(String countryName) async {
    final url = Uri.parse('https://restcountries.com/v3.1/name/$countryName');
    
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('מדינה לא נמצאה');
      }
    } catch (e) {
      throw Exception('שגיאה בחיבור לשרת: $e');
    }
  }
}