import 'package:flutter/material.dart';

import 'package:nekatkas/utils/colors/global_colors.dart';
// import 'package:nekatkas/view/auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: GlobalColors.mainColor,
            expandedHeight: 200,
            floating: true,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(),
          ),
        ],
      ),
    );
  }
}
