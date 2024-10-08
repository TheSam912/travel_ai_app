import 'package:flutter/material.dart';

import '../constant/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().lightGray,
      appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(
            color: Colors.grey.shade900,
          )),
    );
  }
}
