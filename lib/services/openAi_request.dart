import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/ai_model.dart';

Future fetchRecommendations() async {
  String apiKey =
      "sk-gOZtX9mkGNmmSXCU4vyBj1J_-CbXPksrsdON9P5mdAT3BlbkFJndeJSo_uj8JvJRUNIwIpjkxRQOJIhuB9Pit0INmyEA";
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');

  final body = jsonEncode({
    "model": "gpt-3.5-turbo",
    "messages": [
      {
        "role": "system",
        "content": "You are a travel assistant helping users plan personalized trips."
            "Provide a list of at least 5 cities as recommendations for travel in JSON format."
            "Each city should include the name"
            "a paragraph description,a placeholder for a Google Map link, "
            "a list of 10 beautiful places in the city for tourists,"
            "the average flight cost from Istanbul in euros, "
            "and the average accommodation cost per night in euros."
            "Return only the JSON object with placeholders for map links."
      },
      {
        "role": "user",
        "content": "I am from Turkey and I want to visit beautiful cities in Italy for my vacation."
      }
    ],
    "max_tokens": 1500,
    "temperature": 0.7
  });

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final content = jsonResponse['choices'][0]['message']['content'];

    try {
      final cleanedContent = content.trim();
      final Map<String, dynamic> parsedJson = jsonDecode(cleanedContent);
      SomeRootEntity travelData = SomeRootEntity.fromJson(parsedJson);
      print(travelData.cities?[1].description);
      return travelData;
    } catch (e) {
      print('Failed to parse the response: $e');
    }
  } else {
    print('Failed to fetch recommendations: ${response.statusCode}');
  }
  return SomeRootEntity();
}


