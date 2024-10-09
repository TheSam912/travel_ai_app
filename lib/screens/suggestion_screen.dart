import 'dart:math';

import 'package:country_state_city/country_state_city.dart' as cityState;
import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:travel_ai_app/models/country_model.dart';

import '../constant/colors.dart';

class SuggestionScreen extends StatefulWidget {
  SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  TextEditingController controller = TextEditingController();
  String selectedCountry = "";
  String selectedCity = "";
  List cities = [];
  List<CountryModel> countries = [];
  List countriesFlag = [];
  List<CountryModel> searchResult = [];
  List searchResultCity = [];

  @override
  void initState() {
    super.initState();
    getListCountries();
  }

  getListCities(code) async {
    searchResult = [];
    controller.text = "";
    var allCities = await cityState.getCountryCities(code);
    for (var city in allCities) {
      setState(() {
        cities.add(city.name);
      });
    }
  }

  getListCountries() async {
    var allCountries = await cityState.getAllCountries();
    for (var country in allCountries) {
      setState(() {
        countries.add(CountryModel(country.name, country.flag, country.isoCode));
      });
    }
  }

  searchWidget(String hint, type) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 8)]),
      child: ListTile(
        leading: const Icon(Icons.search),
        trailing: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            controller.clear();
            type == "country" ? onSearchTextChangedCountry('') : onSearchTextChangedCity('');
          },
        ),
        title: TextField(
          controller: controller,
          onChanged: (value) => type == "country"
              ? onSearchTextChangedCountry(value)
              : onSearchTextChangedCity(value),
          decoration: InputDecoration(hintText: hint, border: InputBorder.none),
        ),
      ),
    );
  }

  buildNormal(list, type) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: type == "country" ? 2 : 3),
      shrinkWrap: true,
      itemCount: list.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCountry = list[index].isoCode;
              getListCities(selectedCountry);
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor().lightGray,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300, blurRadius: 1, offset: const Offset(0, 5))
                  ]),
              margin: const EdgeInsets.all(8),
              child: type == "country"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          list[index].flag,
                          style: const TextStyle(fontSize: 45),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            list[index].name,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        list[index],
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
        );
      },
    );
  }

  buildSearch(list, type) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: type == "country" ? 2 : 3),
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCountry = list[index].isoCode;
              getListCities(selectedCountry);
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor().lightGray,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300, blurRadius: 1, offset: const Offset(0, 5))
                  ]),
              margin: const EdgeInsets.all(8),
              child: type == "country"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          list[index].flag,
                          style: const TextStyle(fontSize: 45),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            list[index].name,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        list[index],
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
        );
      },
    );
  }

  onSearchTextChangedCountry(text) async {
    searchResult.clear();
    if (controller.text.isEmpty) {
      setState(() {});
      return;
    }
    for (var country in countries) {
      if (country.name.toLowerCase().contains(text)) {
        setState(() {
          searchResult.add(country);
        });
      }
    }
    setState(() {});
  }

  onSearchTextChangedCity(text) async {
    searchResult.clear();
    if (controller.text.isEmpty) {
      setState(() {});
      return;
    }
    for (var city in cities) {
      if (city.toLowerCase().contains(text)) {
        setState(() {
          searchResultCity.add(city);
        });
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(
            color: Colors.grey.shade900,
          )),
      body: countries.isNotEmpty
          ? selectedCountry.isEmpty
              ? ListView(
                  shrinkWrap: true,
                  children: [
                    searchWidget("Search country", "country"),
                    searchResult.isNotEmpty || controller.text.isNotEmpty
                        ? buildSearch(searchResult, "country")
                        : buildNormal(countries, "country")
                  ],
                )
              : cities.isNotEmpty
                  ? ListView(
                      shrinkWrap: true,
                      children: [
                        searchWidget("Search city", "city"),
                        searchResultCity.isNotEmpty || controller.text.isNotEmpty
                            ? buildSearch(searchResultCity, "city")
                            : buildNormal(cities, "city")
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: AppColor().primaryColor,
                      ),
                    )
          : Center(
              child: CircularProgressIndicator(
                color: AppColor().primaryColor,
              ),
            ),
    );
  }
}
