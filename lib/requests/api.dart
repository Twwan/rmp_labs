import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getNasaData() async {
  const String apiUrl = 'https://api.nasa.gov/mars-photos/api/v1';
  const String apiKey = 'eQnprvXukgfNomTanZiHT1DqLApcABzFjI350dyZ';
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
