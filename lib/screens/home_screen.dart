import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:travel_ai_app/constant/colors.dart';
import 'package:travel_ai_app/models/item_home.dart';
import 'package:travel_ai_app/screens/detail_screen.dart';

import '../constant/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().lightGray,
      appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(
            color: Colors.black,
          )),
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 40),
            child: Image(
              image: AssetImage("assets/images/splash_text1.png"),
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 20),
            child: Image(
              image: AssetImage("assets/images/splash_text.png"),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 75,
            margin: const EdgeInsets.only(left: 8, top: 20),
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10)]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          flags[index],
                          height: 30,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          countries[index],
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeItemList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DetailScreen(
                          item: homeItemList[index],
                        );
                      },
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor().primaryColor,
                        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 8)],
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(homeItemList[index].image),
                            fit: BoxFit.cover)),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white.withOpacity(0.7)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      homeItemList[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: AppColor().primaryColor,
                                        size: 16,
                                      ),
                                      Text(
                                        homeItemList[index].location,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white.withOpacity(0.7)),
                              child: Icon(
                                homeItemList[index].isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: AppColor().primaryColor,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
