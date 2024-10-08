import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class ImageViewScreen extends StatelessWidget {
  ImageViewScreen({super.key, required this.imagesList, required this.imgIndex});

  List imagesList = [];
  int imgIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                color: Colors.black,
              ),
              CarouselSlider(
                options: CarouselOptions(
                    height: height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    initialPage: imgIndex
                    // autoPlay: false,
                    ),
                items: imagesList
                    .map(
                      (item) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                               Center(child: CircularProgressIndicator(color: AppColor().primaryColor)),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          imageUrl: item,
                        ),
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_left_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
