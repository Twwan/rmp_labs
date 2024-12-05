import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getNasaData() async {
  final String apiUrl = dotenv.env['API_URL'] ?? '';
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  const String name = 'curiosity';
  const int sol = 110;

  Uri url = Uri.parse('$apiUrl/rovers/$name/photos?sol=$sol&api_key=$apiKey');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error ${response.reasonPhrase}');
  }
}
