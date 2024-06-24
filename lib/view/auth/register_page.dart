import 'package:flutter/material.dart';

import '../../utils/colors/global_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Image.asset(
            'assets/img/logo/logo-nekatkas.png',
            width: 90,
          ),
        ),
        backgroundColor: GlobalColors.mainColor,
        surfaceTintColor: GlobalColors.mainColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/img/vector/senyum.png',
              width: 200,
            ),
            const SizedBox(height: 40),
            Text(
              'Buat akun',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: GlobalColors.textColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Masukan nama dan email kamu',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: GlobalColors.fourthColor,
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(),
            const SizedBox(height: 15),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
