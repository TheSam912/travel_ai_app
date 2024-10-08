import 'package:flutter/material.dart';
import 'package:travel_ai_app/routes/route_lib.dart';
import 'package:travel_ai_app/screens/detail_screen.dart';
import 'package:travel_ai_app/screens/home_screen.dart';
import 'package:travel_ai_app/services/openAi_request.dart';
import 'package:travel_ai_app/screens/splash_screen.dart';

import 'recommendation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
