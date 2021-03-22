import 'package:http/http.dart' as http;
import 'dart:convert';
import 'NumberOutput.dart';

Future<NumberOutput> fetchNumberGenerator() async {
  final response = await http.get('https://csrng.net/csrng/csrng.php?min=1&max=1000');

  if (response.statusCode == 200) {

    return NumberOutput.fromJson(jsonDecode(response.body)[0]);
  } else {

    throw Exception('Failed to load album');
  }
}