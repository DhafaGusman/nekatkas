import 'package:dots_indicator/dots_indicator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:nekatkas/utils/colors/global_colors.dart';
import 'package:nekatkas/view/auth/register_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // -- Page Index -- //
  int _pageIndex = 0;

  // -- Global Key -- //
  final GlobalKey _landing1 = GlobalKey();
  final GlobalKey _landing2 = GlobalKey();
  final GlobalKey _landing3 = GlobalKey();
  final GlobalKey _landing4 = GlobalKey();

  // -- Controller Page -- //
  void controllerPage() async {
    if (_pageIndex == 0) {
      setState(() {
        _pageIndex = 1;
      });
    } else if (_pageIndex == 1) {
      setState(() {
        _pageIndex = 2;
      });
    } else if (_pageIndex == 2) {
      setState(() {
        _pageIndex = 3;
      });
    }
  }

  // -- Build Landing Page 1 -- //
  Widget buildLanding1() {
    return Center(
      key: _landing1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/vector/kendali.png',
            width: 200,
          ),
          const SizedBox(height: 50),
          const Text(
            'Kendalikan keuanganmu\ndengan mudah',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Kamu bisa mengelola keuangan\nusaha kamu dengan mudah\ndan praktis.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Colors.white,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 50),
          DotsIndicator(
            dotsCount: 4,
            position: _pageIndex,
            decorator: DotsDecorator(
              spacing: const EdgeInsets.all(3),
              color: Colors.white.withOpacity(0.5),
              size: const Size.square(7),
              activeColor: Colors.white,
              activeSize: const Size(20, 7),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }

  // -- Build Landing Page 2 -- //
  Widget buildLanding2() {
    return Center(
      key: _landing2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/vector/nabung.png',
            width: 200,
          ),
          const SizedBox(height: 50),
          const Text(
            'Atur pemasukan dan\npengeluaran kamu',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Catat pemasukan dan kelola\npengeluaran usaha kamu.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Colors.white,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 50),
          DotsIndicator(
            dotsCount: 4,
            position: _pageIndex,
            decorator: DotsDecorator(
              spacing: const EdgeInsets.all(3),
              color: Colors.white.withOpacity(0.5),
              size: const Size.square(7),
              activeColor: Colors.white,
              activeSize: const Size(20, 7),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }

  // -- Build Landing Page 3 -- //
  Widget buildLanding3() {
    return Center(
      key: _landing3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/vector/statistik.png',
            width: 200,
          ),
          const SizedBox(height: 50),
          const Text(
            'Lihat statistik usaha kamu\ndari masa ke masa',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Kamu juga bisa melihat statistik\nusaha kamu dengan\nsekali klik.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Colors.white,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 50),
          DotsIndicator(
            dotsCount: 4,
            position: _pageIndex,
            decorator: DotsDecorator(
              spacing: const EdgeInsets.all(3),
              color: Colors.white.withOpacity(0.5),
              size: const Size.square(7),
              activeColor: Colors.white,
              activeSize: const Size(20, 7),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }

  // -- Build Landing Page 4 -- //
  Widget buildLanding4() {
    return Center(
      key: _landing4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/vector/tagih.png',
            width: 200,
          ),
          const SizedBox(height: 50),
          const Text(
            'Rekap tagihan usahamu',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Catat dan kelola usaha piutang\npelanggan usaha kamu.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Colors.white,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 50),
          DotsIndicator(
            dotsCount: 4,
            position: _pageIndex,
            decorator: DotsDecorator(
              spacing: const EdgeInsets.all(3),
              color: Colors.white.withOpacity(0.5),
              size: const Size.square(7),
              activeColor: Colors.white,
              activeSize: const Size(20, 7),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }

  // -- Landing Page -- //
  @override
  Widget build(BuildContext context) {
    List<Widget> landing = [
      buildLanding1(),
      buildLanding2(),
      buildLanding3(),
      buildLanding4(),
    ];
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Image.asset(
            'assets/img/logo/logo-nekatkas.png',
            width: 90,
          ),
        ),
        backgroundColor: GlobalColors.mainColor,
        surfaceTintColor: GlobalColors.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: landing[_pageIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30),
        child: _pageIndex != 3
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_pageIndex != 3) {
                        setState(() {
                          _pageIndex = 3;
                        });
                      }
                    },
                    child: const Text(
                      'Lewati',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controllerPage(),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.01),
                            spreadRadius: -1,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Icon(
                        FeatherIcons.arrowRight,
                        size: 25,
                        color: GlobalColors.mainColor,
                      ),
                    ),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const RegisterPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Mulai',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: GlobalColors.mainColor,
                  ),
                ),
              ),
      ),
    );
  }
}
