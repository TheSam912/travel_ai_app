import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_ai_app/models/ai_model.dart';
import 'package:travel_ai_app/services/hotel_request.dart';
import 'package:travel_ai_app/services/openAi_request.dart';
import 'package:travel_ai_app/services/unsplash_request.dart';

class TravelRecommendations extends StatefulWidget {
  @override
  _TravelRecommendationsState createState() => _TravelRecommendationsState();
}

class _TravelRecommendationsState extends State<TravelRecommendations> {
  var citySuggestions = [];
  String imageUrl = "";
  var object;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await fetchRecommendations();
    setState(() {
      citySuggestions.add(SomeRootEntity(cities: res.cities));
    });
  }

  // fetchImageForItem() async {
  //   var image = await fetchImage();
  //   setState(() {
  //     imageUrl = image;
  //   });
  // }

  fetchSearchByDestination() async {
    String destination = await SearchHotelService().searchDestination();
    if (destination != "") {
      List listHotels = await SearchHotelService().searchHotels(destination);
      for (var hotel in listHotels) {
        var property = hotel['property'];
      }
    }
  }

  readFromJson() async {
    final String response = await rootBundle.loadString('assets/data/search_destination.json');
    final jsonResponse = await json.decode(response);
    String destination = jsonResponse['data'][0]['dest_id'];
    object = jsonResponse['data'][0];
    imageUrl = jsonResponse['data'][0]['image_url'];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(imageUrl);
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('AI Travel Recommendations'),
    //   ),
    //   body: citySuggestions.isEmpty
    //       // ? const Center(child: CircularProgressIndicator())
    //       ? Center(
    //           child: imageUrl != ""
    //               ? Image.network(
    //                   imageUrl,
    //                   fit: BoxFit.cover,
    //                 )
    //               : const CircularProgressIndicator(),
    //         )
    //       : ListView.builder(
    //           itemCount: citySuggestions[0].cities.length,
    //           itemBuilder: (context, index) {
    //             SomeRootEntityCities city = citySuggestions[0].cities[index];
    //             return Card(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Text(
    //                       city.name ?? "",
    //                       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Text(city.description ?? ""),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Text('Flight cost: ${city.averageFlightCostFromIstanbul}'),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Text('Accommodation cost: ${city.averageAccommodationCostPerNight}'),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: 300,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.fill)),
      ),
    );
  }
}
