import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:nekatkas/widgets/snackbar/snackbar.dart';

import '../../utils/colors/global_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // -- Variable -- //
  int _pageIndex = 0;

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
  final TextEditingController passwordController2 = TextEditingController();
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
    // List teks dan foto halaman 1 (username dan email)
    {
      'foto': 'assets/img/vector/senyum.png',
      'judul': 'Buat akun',
      'deskripsi': 'Masukan nama dan email kamu',
      'tombol': 'Lanjut',
    },
    // List teks dan foto halaman 2 (password)
    {
      'foto': 'assets/img/vector/senyum.png',
      'judul': 'Masukkan kata sandi',
      'deskripsi': 'Kata sandi minimal 6 karakter dan 1 angka',
      'tombol': 'Lanjut',
    },
    // List teks dan foto halaman 3 (nomor telepon)
    {
      'foto': 'assets/img/vector/senyum.png',
      'judul': 'Masukkan nomor telepon',
      'deskripsi': 'Kami akan mengirimkan kode verifikasi\nke telepon mu',
      'tombol': 'Lanjut',
    },
    // List teks dan foto halaman 4 (verifikasi)
    {
      'foto': 'assets/img/vector/senyum.png',
      'judul': 'Masukkan kode verifikasi',
      'deskripsi': 'Coba cek kode verifikasi di pesan',
      'tombol': 'Lanjut',
    },
    // List teks dan foto halaman 5 (nama toko dan kategorinya)
    {
      'foto': 'assets/img/vector/senyum.png',
      'judul': 'Buat toko baru',
      'deskripsi': 'Masukan nama toko kamu dan kategorinya',
      'tombol': 'Lanjut',
    },
    // List teks dan foto halaman 6 (foto toko)
    {
      'foto': 'assets/img/vector/senyum.png',
      'judul': 'Tambah foto',
      'deskripsi': 'Tambahin foto untuk toko kamu',
      'tombol': 'Buat akun',
    }
  ];

  // -- Controller Register Page -- //
  void controllerRegister() async {
    // -- Variable -- //
    final bool isValid = EmailValidator.validate(emailController.text.trim());

    // -- Page 1 -- //
    if (_pageIndex == 0) {
      if (_step1FormKey.currentState!.validate()) {
        // -- Username Validation -- //

        // Jika username belum diisi
        if (usernameController.text.isEmpty) {
          CustomSnackbar.show(
            context,
            Colors.orange,
            FeatherIcons.alertCircle,
            'Peringatan!',
            'Nama pengguna belum diisi',
          );
          return;
        }
        // Jika username kurang dari 6 karakter
        if (usernameController.text.length < 6) {
          CustomSnackbar.show(
            context,
            Colors.orange,
            FeatherIcons.alertCircle,
            'Peringatan!',
            'Nama pengguna kurang dari 6 karakter',
          );
          return;
        }
        // Jika username lebih dari 15 karakter
        else if (usernameController.text.length > 15) {
          CustomSnackbar.show(
            context,
            Colors.orange,
            FeatherIcons.alertCircle,
            'Peringatan!',
            'Nama pengguna lebih dari 15 karakter',
          );
          return;
        }
        // Jika username mengandung karakter !, @, dan #
        else if (usernameController.text.contains('!') ||
            usernameController.text.contains('@') ||
            usernameController.text.contains('#')) {
          CustomSnackbar.show(
            context,
            Colors.orange,
            FeatherIcons.alertCircle,
            'Peringatan!',
            'Nama pengguna tidak boleh ada !, @, dan #',
          );
          return;
        }

        // -- Email Validation -- //

        // Jika email belum diisi
        if (emailController.text.isEmpty) {
          CustomSnackbar.show(
            context,
            Colors.orange,
            FeatherIcons.alertCircle,
            'Peringatan!',
            'Email belum diisi',
          );
          return;
        }
        // Jika email tidak valid
        if (!isValid) {
          CustomSnackbar.show(
            context,
            Colors.orange,
            FeatherIcons.alertCircle,
            'Peringatan!',
            'Email tidak valid',
          );
          return;
        }
      }

      // -- Page Change -- //
      setState(() {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: GlobalColors.garisColor,
                    color: GlobalColors.mainColor,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Tunggu sebentar',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        );
        _pageIndex = 1;
        Navigator.of(context).pop();
      });
    }

    // -- Page 2 -- //
    else if (_pageIndex == 1) {
      if (_step2FormKey.currentState!.validate()) {
        _step2FormKey.currentState!.save();

        // -- Password Validation -- //

        // If password < 8 or password does not contains 1 number
        if (passwordController.text.length < 8 || !passwordController.text.contains(RegExp(r'[0-9]'))) {
          return;
        }
        // If confirm password != password
        if (passwordController2.text != passwordController.text) {
          return;
        }
      }

      // -- Page Change -- //
      setState(() {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: GlobalColors.garisColor,
                    color: GlobalColors.mainColor,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Tunggu sebentar',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        );
        _pageIndex = 2;
        Navigator.of(context).pop();
      });
    }

    // -- Page 3 -- //
  }

  // -- Build Register 1 --//
  Widget buildRegister1() {
    return Form(
      key: _step1FormKey,
      child: Column(
        children: [
          TextFormField(
            controller: usernameController,
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
            controller: emailController,
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
        ],
      ),
    );
  }

  // -- Build Register 2 --//
  Widget buildRegister2() {
    return Form(
      key: _step2FormKey,
      child: Column(
        children: [
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                FeatherIcons.user,
                color: GlobalColors.fourthColor,
              ),
              labelText: 'Kata sandi',
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
            controller: passwordController2,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                FeatherIcons.mail,
                color: GlobalColors.fourthColor,
              ),
              labelText: 'Konfirmasi kata sandi',
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
        ],
      ),
    );
  }

  // -- Build Register 3 --//
  Widget buildRegister3() {
    return Form(
      key: _step3FormKey,
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            FeatherIcons.user,
            color: GlobalColors.fourthColor,
          ),
          labelText: 'Kata sandi',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    String number = '';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(
                _step[_pageIndex]['foto'],
                width: 200,
              ),
              const SizedBox(height: 40),
              Text(
                _step[_pageIndex]['judul'],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.textColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _step[_pageIndex]['deskripsi'],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: GlobalColors.fourthColor,
                ),
              ),
              const SizedBox(height: 50),
              InternationalPhoneNumberInput(
                onInputChanged: (value) {},
                spaceBetweenSelectorAndTextField: 0,
                textFieldController: telephoneController,
                countrySelectorScrollControlled: true,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  useBottomSheetSafeArea: true,
                ),
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: GlobalColors.textColor,
                ),
                cursorColor: GlobalColors.textColor,
                formatInput: false,
                selectorTextStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: GlobalColors.textColor,
                ),
                inputDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 14, top: 0),
                  hintText: 'Masukan nomor telepon',
                  hintStyle: TextStyle(
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
              ),
              const SizedBox(height: 60),
              Text(
                number,
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        number = telephoneController.text;
                        print(number);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      backgroundColor: HexColor('29B6F6'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
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
      ),
    );
  }
}
