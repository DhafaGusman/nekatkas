import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/colors/global_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // -- Variable -- //
  final int _pageIndex = 0;

  int countdown = 60;
  Timer? timer;
  StreamController<int> countdownStream = StreamController<int>();

  Uint8List? _image;
  File? selectedImage;

  // -- Form Key -- //
  final GlobalKey<FormState> _step1FormKey = GlobalKey();
  final GlobalKey<FormState> _step2FormKey = GlobalKey();
  final GlobalKey<FormState> _step3FormKey = GlobalKey();
  final GlobalKey<FormState> _step4FormKey = GlobalKey();
  final GlobalKey<FormState> _step5FormKey = GlobalKey();
  final GlobalKey<FormState> _step6FormKey = GlobalKey();

  // -- Controller -- //
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopCategoryController = TextEditingController();

  // -- Initial State -- //
  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  // -- Start Countdown -- //
  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  // -- Dispose -- //
  @override
  void dispose() {
    timer?.cancel();
    countdownStream.close();
    super.dispose();
  }

  // -- List Page for Title -- //
  final List<Map<String, dynamic>> _step = [
    {
      'judul': 'Buat akun',
      'deskripsi': 'Masukan nama dan email kamu',
      'Judul': 'Lanjut',
    },
    {
      'judul': 'Masukkan kata sandi',
      'deskripsi': 'Kata sandi minimal 6 karakter dan 1 angka',
      'Judul': 'Lanjut',
    },
    {
      'judul': 'Masukkan nomor telepon',
      'deskripsi': 'Kami akan mengirimkan kode verifikasi\nke telepon mu',
      'Judul': 'Lanjut',
    },
    {
      'judul': 'Masukkan kode verifikasi',
      'deskripsi': 'Coba cek kode verifikasi di pesan',
      'Judul': 'Lanjut',
    },
    {
      'judul': 'Buat toko baru',
      'deskripsi': 'Masukan nama toko kamu dan kategorinya',
      'Judul': 'Lanjut',
    },
    {
      'judul': 'Tambah foto',
      'deskripsi': 'Tambahin foto untuk toko kamu',
      'Judul': 'Buat akun',
    }
  ];

  // -- Controller Register Page -- //
  void controllerRegister() async {
    if (_pageIndex == 0) {
      if (_step1FormKey.currentState!.validate()) {
        // -- Validasi jika username kosong --/
        if (usernameController.text.isEmpty || emailController.text.isEmpty) {
          return;
        }
      }
    }
  }

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
            const SizedBox(height: 30),
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
            const SizedBox(height: 50),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  FeatherIcons.user,
                  color: GlobalColors.fourthColor,
                ),
                labelText: 'Nama pengguna',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: GlobalColors.fourthColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: GlobalColors.mainColor, width: 1.5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: GlobalColors.garisColor, width: 1.5),
                ),
              ),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: GlobalColors.textColor,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(
                  FeatherIcons.mail,
                  color: GlobalColors.fourthColor,
                ),
                labelText: 'Alamat email',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: GlobalColors.fourthColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: GlobalColors.mainColor, width: 1.5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: GlobalColors.garisColor, width: 1.5),
                ),
              ),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: GlobalColors.textColor,
              ),
            ),
            const SizedBox(height: 60),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: HexColor('29B6F6'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Lanjut',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Sudah punya akun? ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: GlobalColors.fourthColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Masuk',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: GlobalColors.mainColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
