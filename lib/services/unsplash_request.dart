import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> fetchImage(location) async {
  var url =
      "https://api.unsplash.com/search/photos?per_page=5&query=$location&client_id=f3QsRdtlMSS6rsFlLYd_SaTN-9ay4fFuGWstIyhSES8";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    var content = jsonResponse['results'];
    List images = [];
    for (int i = 0; i < content.length; i++) {
      images.add(content[i]['urls']['raw']);
    }
    return images;
  } else {
    print('Failed to fetch recommendations: ${response.statusCode}');
  }
  return [];
}
