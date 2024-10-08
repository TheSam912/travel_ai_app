import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:travel_ai_app/constant/colors.dart';
import 'package:travel_ai_app/constant/data.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_ai_app/models/item_home.dart';
import 'package:travel_ai_app/screens/image_view_screen.dart';
import 'package:travel_ai_app/services/map_luncher.dart';
import 'package:travel_ai_app/services/unsplash_request.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.item});

  HomeItem item;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _current = 0;
  bool loading = true;
  final CarouselSliderController _controller = CarouselSliderController();
  List images = [];

  @override
  void initState() {
    super.initState();
    getImages();
  }

  getImages() async {
    var response = await fetchImage(widget.item.title);
    images.add(widget.item.image);
    for (int i = 0; i < response.length; i++) {
      images.add(response[i]);
    }
    if (images.isNotEmpty) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().lightGray,
      appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(
            color: Colors.black,
          )),
      body: loading == false
          ? ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        child: CarouselSlider(
                          carouselController: _controller,
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            height: MediaQuery.of(context).size.height / 2,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                          items: images
                              .map((item) => Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    // child: Image(
                                    //   image: NetworkImage(item),
                                    //   fit: BoxFit.cover,
                                    // )
                                    child: CachedNetworkImage(
                                      imageUrl: item,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Positioned(
                        left: 140,
                        right: 140,
                        bottom: 50,
                        child: Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 140),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: images.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor()
                                          .primaryColor
                                          .withOpacity(_current == entry.key ? 1 : 0.3)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                          width: 40,
                          height: 40,
                          child: Center(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_left_rounded,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Container(
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                          width: 40,
                          height: 40,
                          child: Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  widget.item.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: widget.item.isFavorite
                                      ? AppColor().primaryColor
                                      : Colors.black,
                                )),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColor().lightGray,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                        ),
                      ),
                      Positioned(
                        bottom: 18,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 175),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                        ),
                      )
                    ],
                  ),
                ),
                text_section(widget.item.title, widget.item.location),
                mapView(widget.item.title, widget.item.coords),
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

mapView(name, coords) {
  openMap(Coords location, String title) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(coords: location, title: title);
  }

  return Container(
    height: 300,
    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    child: Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(48.8584, 2.2945),
            initialZoom: 10,
            maxZoom: 20,
            onLongPress: (tapPosition, point) {
              //MapsLauncher.launchCoordinates(48.8584, 2.2945, "address");
              openMap(coords, name);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 45,
            color: AppColor().primaryColor.withOpacity(0.75),
            alignment: Alignment.center,
            child: Text(
              "Long press to open",
              style: GoogleFonts.montserrat(color: Colors.black54, fontWeight: FontWeight.w700),
            ),
          ),
        )
      ],
    ),
  );
}

text_section(name, location) {
  openMap(Coords location, String title) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(coords: location, title: title);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.montserrat(
                  color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                Icon(
                  Icons.star_border,
                  color: Colors.grey.shade700,
                  size: 20,
                ),
                Text(
                  "4.5 / 5",
                  style: GoogleFonts.montserrat(
                      color: Colors.grey.shade700, fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ],
            )
          ],
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                Text(
                  location,
                  style: GoogleFonts.montserrat(
                      color: Colors.grey.shade700, fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => openMap(Coords(48.8584, 2.2945), "Eiffel Tower"),
              child: Text(
                "Map direction",
                style: GoogleFonts.montserrat(
                    color: AppColor().primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor().primaryColor),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 1,
        color: Colors.grey.shade400,
        margin: const EdgeInsets.all(18),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor().lightGray,
                    boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 2)]),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/hotel.png",
                      color: Colors.grey.shade600,
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Avg: 150€",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor().lightGray,
                    boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 2)]),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/flight.png",
                      color: Colors.grey.shade600,
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Avg: 50€",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Text(
          loremIpsum,
          textAlign: TextAlign.justify,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
