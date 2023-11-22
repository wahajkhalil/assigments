import 'dart:convert';
import 'package:http/http.dart' as http;

class DataUsaApi {
  static const String baseUrl = 'https://datausa.io/api/data';
  static const String defaultDrilldowns = 'Nation';
  static const String defaultMeasures = 'Population';

  Future<Map<String, dynamic>> getPopulationData() async {
    final response = await http.get(
      Uri.parse('$baseUrl?drilldowns=$defaultDrilldowns&measures=$defaultMeasures'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load population data');
    }
  }
}
