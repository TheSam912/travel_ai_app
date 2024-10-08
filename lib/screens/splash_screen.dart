import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_app/constant/colors.dart';
import 'package:travel_ai_app/routes/route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future.delayed(
      Duration(milliseconds: 2000),
      () => context.goNamed('travel'),
    );
    return Scaffold(
        backgroundColor: AppColor().lightGray,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 60, bottom: 50),
            color: Colors.black.withOpacity(0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CircularProgressIndicator(
                    color: AppColor().primaryColor,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
