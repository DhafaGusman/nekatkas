import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

import 'package:nekatkas/utils/colors/global_colors.dart';
// import 'package:nekatkas/view/auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // // -- Local Variable -- //
  // String _sapaan = '';

  // // -- Initial State -- //
  // @override
  // void initState() {
  //   super.initState();
  //   // Tentukan sapaan berdasarkan waktu
  //   _sapaan = _getGreeting();
  // }

  // // -- Get Greeting -- //
  // String _getGreeting() {
  //   final hour = DateTime.now().hour;
  //   if (hour >= 5 && hour < 12) {
  //     return "Selamat pagi, ";
  //   } else if (hour >= 12 && hour < 15) {
  //     return "Selamat siang, ";
  //   } else if (hour >= 15 && hour < 18) {
  //     return "Selamat sore, ";
  //   } else {
  //     return "Selamat malam, ";
  //   }
  // }

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
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/img/vector/background.jpg',
                fit: BoxFit.contain,
              ),
              titlePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
              title: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/img/icon/user.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: GlobalColors.textColor.withOpacity(0.2),
                                spreadRadius: -1,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/img/logo/logo-nekatkas.png',
                      width: 60,
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: GlobalColors.mainColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: GlobalColors.textColor.withOpacity(0.2),
                                spreadRadius: -1,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: const Icon(
                            FeatherIcons.bell,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          buildHomePage(),
        ],
      ),
    );
  }

  Widget buildHomePage() {
    final List<String> items = List.generate(20, (index) => 'Item $index');
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Card(
            child: Center(
              child: Text(items[index], style: const TextStyle(fontSize: 20)),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
