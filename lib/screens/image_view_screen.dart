import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  ImageViewScreen({super.key});

  List<String> images = [
    'https://www.toureiffel.paris/themes/custom/tour_eiffel/build/images/home-discover-bg.jpg',
    'https://media.tacdn.com/media/attractions-splice-spp-674x446/12/2e/16/f8.jpg',
    'https://i.pinimg.com/474x/88/67/69/88676988bee6c1754cabbec7470fdc11.jpg',
    'https://i.pinimg.com/564x/b8/2e/33/b82e332473712b0f1b56b5b331970d5b.jpg',
    'https://i.pinimg.com/564x/b7/79/e4/b779e4b6e03f6c47da44ae57d3731e6a.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  // autoPlay: false,
                ),
                items: images
                    .map((item) => Center(
                            child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          height: height,
                        )))
                    .toList(),
              ),
              Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white.withOpacity(0.6)),
                      child: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        color: Colors.black,
                      ),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
