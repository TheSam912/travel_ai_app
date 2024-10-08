import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding if needed.
import 'package:http/http.dart' as http;

class SearchHotelService {
  String baseUrl = 'https://booking-com15.p.rapidapi.com/api/v1/hotels';

  final Map<String, String> baseHeaders = {
    'X-Rapidapi-Key': 'f3260778e6msh405b93cd113252bp1f2b3ejsn4e51ecee2f0e',
    'X-Rapidapi-Host': 'booking-com15.p.rapidapi.com',
    'Host': 'booking-com15.p.rapidapi.com',
  };

  Future<String> searchDestination() async {
    final Map<String, String> queryParams = {
      'query': 'padova', // The search query (e.g., "man" for Manchester, Manhattan, etc.)
    };

    final Uri uri = Uri.parse('$baseUrl/searchDestination').replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri, headers: baseHeaders);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String destination = jsonResponse['data'][0]['dest_id'];
        return destination;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return "";
  }

  Future<List> searchHotels(destinationId) async {
    final Map<String, String> queryParams = {
      'dest_id': '$destinationId',
      'search_type': 'CITY',
      'arrival_date': '2024-10-05',
      'departure_date': '2024-10-14',
      'adults': '1',
      'children_age': '0,17',
      'room_qty': '1',
      'page_number': '1',
      'units': 'metric',
      'temperature_unit': 'c',
      'languagecode': 'en-us',
      'currency_code': 'AED'
    };
    final Uri uri = Uri.parse('$baseUrl/searchHotels').replace(queryParameters: queryParams);
    try {
      final response = await http.get(uri, headers: baseHeaders);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        var hotels = jsonResponse['data']['hotels'];
        String t = "";
        return hotels;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return [];
  }
}
