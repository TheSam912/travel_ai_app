import 'dart:math';

import 'package:country_state_city/country_state_city.dart' as cityState;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:travel_ai_app/models/country_model.dart';

import '../constant/colors.dart';
import '../constant/data.dart';

class SuggestionScreen extends StatefulWidget {
  SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  TextEditingController controller = TextEditingController();
  String selectedCountry = "";
  List<CountryModel> countries = [];
  List countriesFlag = [];
  List<CountryModel> searchResult = [];

  @override
  void initState() {
    super.initState();
    getListCountries();
  }

  getListCountries() async {
    var allCountries = await cityState.getAllCountries();
    for (var country in allCountries) {
      setState(() {
        countries.add(CountryModel(country.name, country.flag, country.isoCode));
      });
    }
  }

  searchWidget() {
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
            onSearchTextChangedCountry('');
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        title: TextField(
          controller: controller,
          onChanged: (value) => onSearchTextChangedCountry(value),
          decoration: const InputDecoration(hintText: "Search country", border: InputBorder.none),
        ),
      ),
    );
  }

  buildNormal(list) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.8),
      shrinkWrap: true,
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              FocusManager.instance.primaryFocus?.unfocus();
              selectedCountry = list[index].isoCode;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    list[index].flag,
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    child: Text(
                      list[index].name,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 12),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  buildSearch(list) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.8),
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              FocusManager.instance.primaryFocus?.unfocus();
              selectedCountry = list[index].isoCode;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    list[index].flag,
                    style: const TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      list[index].name,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 12),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
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
          ? ListView(
              shrinkWrap: true,
              children: [
                searchWidget(),
                searchResult.isNotEmpty || controller.text.isNotEmpty
                    ? buildSearch(searchResult)
                    : buildNormal(dummyCountry)
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                color: AppColor().primaryColor,
              ),
            ),
    );
  }
}
