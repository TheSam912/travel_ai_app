import 'package:flutter/material.dart';

import '../constant/colors.dart';

class SuggestionScreen extends StatelessWidget {
  const SuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().lightGray,
      appBar: PreferredSize(
          preferredSize: Size(0, 0),
          child: Container(
            color: Colors.grey.shade900,
          )),
    );
  }
}
