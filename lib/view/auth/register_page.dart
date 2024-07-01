import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:nekatkas/feature/controller/handle_registration.dart';
import 'package:nekatkas/widgets/modal/modal_category.dart';
import 'package:nekatkas/widgets/modal/modal_chooser.dart';
import 'package:nekatkas/widgets/modal/modal_pick_image.dart';
import 'package:nekatkas/widgets/snackbar/snackbar.dart';
// import 'package:nekatkas/widgets/snackbar/snackbar.dart';

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

  PhoneNumber number = PhoneNumber(isoCode: 'ID');
  late String phoneNumber;

  String? pin1, pin2, pin3, pin4, pin5, pin6;

  bool _obscureText1 = true;
  bool _obscureText2 = true;

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

  // -- On Image Selected -- //
  void _onImageSelected(File image) {
    setState(() {
      selectedImage = image;
      _image = image.readAsBytesSync();
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
      'foto': 'assets/img/vector/password.png',
      'judul': 'Masukkan kata sandi',
      'deskripsi': 'Kata sandi minimal 6 karakter dan 1 angka',
      'tombol': 'Lanjut',
    },
    // List teks dan foto halaman 3 (nomor telepon)
    {
      'foto': 'assets/img/vector/hape.png',
      'judul': 'Masukkan nomor telepon',
      'deskripsi': 'Kami akan mengirimkan kode verifikasi\nke telepon mu',
      'tombol': 'Lanjut',
    },
    // List teks dan foto halaman 4 (verifikasi)
    {
      'foto': 'assets/img/vector/hape.png',
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
      'judul': 'Tambah foto',
      'deskripsi': 'Tambahin foto untuk profil kamu',
      'tombol': 'Buat akun',
    }
  ];

  // -- Controller Register Page -- //
  void controllerRegister() async {
    // -- Page 1 (Username and Email) -- //
    if (_pageIndex == 0) {
      if (_step1FormKey.currentState!.validate()) {
        // -- Page Change -- //
        setState(() {
          _pageIndex = 1;
        });
      }
    }

    // -- Page 2 (Password) -- //
    else if (_pageIndex == 1) {
      if (_step2FormKey.currentState!.validate()) {
        _step2FormKey.currentState!.save();

        // -- Page Change -- //
        setState(() {
          _pageIndex = 2;
        });
      }
    }

    // -- Page 3 (Input Phone Number) -- //
    else if (_pageIndex == 2) {
      if (_step3FormKey.currentState!.validate()) {
        _step3FormKey.currentState!.save();
        // -- Page Change -- //
        setState(() {
          _pageIndex = 3;
        });
      }
    }

    // -- Page 4 (Phone Number Verification) -- //
    else if (_pageIndex == 3) {
      if (_step4FormKey.currentState!.validate()) {
        _step4FormKey.currentState!.save();

        // -- Phone Number Validation -- //
        if (pin1 != null && pin2 != null && pin3 != null && pin4 != null && pin5 != null && pin6 != null) {
          String enteredVerificationCode = '$pin1$pin2$pin3$pin4$pin5$pin6';
          if (enteredVerificationCode.isEmpty) {
            CustomSnackbar.show(
              context,
              Colors.orange,
              FeatherIcons.alertCircle,
              'Peringatan!',
              'Kode verifikasi belum diisi',
            );
            return setState(() {
              pin1 = null;
              pin2 = null;
              pin3 = null;
              pin4 = null;
              pin5 = null;
              pin6 = null;
            });
          }

          // -- Page Change -- //
          setState(() {
            _pageIndex = 4;
          });
        }
      }
    }

    // -- Page 5 (Shop Name and Shop Category) -- //
    else if (_pageIndex == 4) {
      if (_step5FormKey.currentState!.validate()) {
        _step5FormKey.currentState!.save();
        // -- Page Change -- //
        setState(() {
          _pageIndex = 5;
        });
      }
    }
    // -- Page 6 (Profile Image) -- //
    else if (_pageIndex == 5) {
      if (_image == null) {
        return showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          builder: (_) {
            return ModalChooser(
              titleText: 'Lanjut tanpa foto profil?',
              descriptionText: 'Kamu masih bisa atur foto profilnya di edit profil.',
              onPressedBtnLeft: () {
                Navigator.of(context).pop();
              },
              textBtnLeft: 'Batal',
              colorBtnLeft: GlobalColors.mainColor,
              onPressedBtnRight: () {
                handleRegistrationSubmit(context);
              },
              textBtnRight: 'Lanjut',
              colorBtnRight: GlobalColors.mainColor,
            );
          },
        );
      } else {
        handleRegistrationSubmit(context);
      }
    }
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama pengguna belum diisi';
              } else if (value.length < 5) {
                return 'Nama pengguna kurang dari 5 karakter';
              } else if (value.length > 15) {
                return 'Nama pengguna tidak boleh lebih dari 15 karakter';
              } else if (value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
                return 'Nama pengguna tidak boleh mengandung karakter khusus';
              }
              return null;
            },
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
            validator: (value) {
              // Variable
              final bool isValid = EmailValidator.validate(emailController.text.trim());
              // Validator
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              } else if (!isValid) {
                return 'Email tidak valid';
              }
              return null;
            },
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
            obscureText: _obscureText1,
            decoration: InputDecoration(
              icon: Icon(
                FeatherIcons.key,
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
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText1 ? FeatherIcons.eye : FeatherIcons.eyeOff,
                  size: 20,
                  color: GlobalColors.fourthColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText1 = !_obscureText1;
                  });
                },
              ),
            ),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: GlobalColors.textColor,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Kata sandi belum diisi';
              } else if (value.length < 8) {
                return 'Kata sandi minimal harus 8 karakter atau lebih';
              } else if (!value.contains(RegExp(r'[0-9]'))) {
                return 'Kata sandi minimal mengandung 1 angka';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController2,
            obscureText: _obscureText2,
            decoration: InputDecoration(
              icon: Icon(
                FeatherIcons.key,
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
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText2 ? FeatherIcons.eye : FeatherIcons.eyeOff,
                  size: 20,
                  color: GlobalColors.fourthColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText2 = !_obscureText2;
                  });
                },
              ),
            ),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: GlobalColors.textColor,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Kata sandi belum diisi';
              } else if (value != passwordController.text) {
                return 'Kata sandi tidak sama';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // -- Build Register 3 --//
  Widget buildRegister3() {
    return Form(
      key: _step3FormKey,
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          setState(() {
            phoneNumber = number.phoneNumber!;
          });
        },
        onInputValidated: (bool value) {
          print(value ? 'Valid' : 'Invalid');
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Nomor telepon belum diisi';
          }
          return null;
        },
        spaceBetweenSelectorAndTextField: 0,
        ignoreBlank: false,
        initialValue: number,
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
        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
      ),
    );
  }

  // -- Build Register 4 -- //
  Widget buildRegister4() {
    return Form(
      key: _step4FormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 60,
                width: 50,
                child: TextFormField(
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSaved: (value) {
                    if (pin1 == null) {
                      pin1 = value;
                    } else if (pin2 == null) {
                      pin2 = value;
                    } else if (pin3 == null) {
                      pin3 = value;
                    } else if (pin4 == null) {
                      pin4 = value;
                    } else if (pin5 == null) {
                      pin5 = value;
                    } else {
                      pin6 = value;
                    }
                  },
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.mainColor, width: 2.5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.garisColor, width: 2.5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 50,
                child: TextFormField(
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSaved: (value) {
                    if (pin1 == null) {
                      pin1 = value;
                    } else if (pin2 == null) {
                      pin2 = value;
                    } else if (pin3 == null) {
                      pin3 = value;
                    } else if (pin4 == null) {
                      pin4 = value;
                    } else if (pin5 == null) {
                      pin5 = value;
                    } else {
                      pin6 = value;
                    }
                  },
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.mainColor, width: 2.5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.garisColor, width: 2.5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 50,
                child: TextFormField(
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSaved: (value) {
                    if (pin1 == null) {
                      pin1 = value;
                    } else if (pin2 == null) {
                      pin2 = value;
                    } else if (pin3 == null) {
                      pin3 = value;
                    } else if (pin4 == null) {
                      pin4 = value;
                    } else if (pin5 == null) {
                      pin5 = value;
                    } else {
                      pin6 = value;
                    }
                  },
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.mainColor, width: 2.5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.garisColor, width: 2.5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 50,
                child: TextFormField(
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSaved: (value) {
                    if (pin1 == null) {
                      pin1 = value;
                    } else if (pin2 == null) {
                      pin2 = value;
                    } else if (pin3 == null) {
                      pin3 = value;
                    } else if (pin4 == null) {
                      pin4 = value;
                    } else if (pin5 == null) {
                      pin5 = value;
                    } else {
                      pin6 = value;
                    }
                  },
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.mainColor, width: 2.5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.garisColor, width: 2.5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 50,
                child: TextFormField(
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSaved: (value) {
                    if (pin1 == null) {
                      pin1 = value;
                    } else if (pin2 == null) {
                      pin2 = value;
                    } else if (pin3 == null) {
                      pin3 = value;
                    } else if (pin4 == null) {
                      pin4 = value;
                    } else if (pin5 == null) {
                      pin5 = value;
                    } else {
                      pin6 = value;
                    }
                  },
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.mainColor, width: 2.5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.garisColor, width: 2.5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 50,
                child: TextFormField(
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSaved: (value) {
                    if (pin1 == null) {
                      pin1 = value;
                    } else if (pin2 == null) {
                      pin2 = value;
                    } else if (pin3 == null) {
                      pin3 = value;
                    } else if (pin4 == null) {
                      pin4 = value;
                    } else if (pin5 == null) {
                      pin5 = value;
                    } else {
                      pin6 = value;
                    }
                  },
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.mainColor, width: 2.5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.garisColor, width: 2.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Belum terima kode? ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: GlobalColors.fourthColor,
                  ),
                ),
                if (countdown > 0)
                  TextSpan(
                    text: 'Tunggu $countdown detik',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: GlobalColors.mainColor,
                    ),
                  )
                else
                  TextSpan(
                    text: 'Kirim lagi',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: GlobalColors.mainColor,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Ingin ganti nomor telepon? ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: GlobalColors.fourthColor,
                  ),
                ),
                TextSpan(
                  text: 'Ganti nomor',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: GlobalColors.mainColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        _pageIndex = 2;
                      });
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -- Build Register 5 -- //
  Widget buildRegister5() {
    return Form(
      key: _step5FormKey,
      child: Column(
        children: [
          TextFormField(
            controller: shopNameController,
            decoration: InputDecoration(
              icon: Icon(
                FeatherIcons.shoppingBag,
                color: GlobalColors.fourthColor,
              ),
              labelText: 'Nama toko',
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama toko belum diisi';
              } else if (value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]+-=_{}'))) {
                return 'Nama toko tidak boleh mengandung karakter khusus';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: shopCategoryController,
            readOnly: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.category_outlined,
                color: GlobalColors.fourthColor,
              ),
              labelText: 'Kategori toko',
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
              suffixIcon: IconButton(
                icon: Icon(
                  FeatherIcons.chevronDown,
                  color: GlobalColors.fourthColor,
                ),
                onPressed: () {
                  _showModalCategory(context);
                },
              ),
            ),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: GlobalColors.textColor,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Kategori toko belum diisi';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // -- Build Register 6 -- //
  Widget buildRegister6() {
    return Form(
      key: _step6FormKey,
      child: Column(
        children: [
          const SizedBox(height: 70),
          Center(
            child: Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 90,
                        backgroundColor: GlobalColors.mainColor,
                        child: CircleAvatar(
                          radius: 87,
                          backgroundImage: MemoryImage(_image!),
                        ),
                      )
                    : CircleAvatar(
                        radius: 90,
                        backgroundColor: GlobalColors.mainColor,
                        child: const CircleAvatar(
                          radius: 87,
                          backgroundImage: AssetImage('assets/img/icon/user.jpg'),
                        ),
                      ),
                Positioned(
                  bottom: 0,
                  left: 135,
                  child: GestureDetector(
                    onTap: () async {
                      _showImagePickerOption(context);
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: GlobalColors.mainColor,
                      ),
                      child: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> forms = [
      buildRegister1(),
      buildRegister2(),
      buildRegister3(),
      buildRegister4(),
      buildRegister5(),
      buildRegister6(),
    ];
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
              if (_pageIndex != 5)
                Column(
                  children: [
                    Image.asset(
                      _step[_pageIndex]['foto'],
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
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
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: GlobalColors.fourthColor,
                ),
              ),
              const SizedBox(height: 50),
              // Index Page
              forms[_pageIndex],
              const SizedBox(height: 60),
              if (_pageIndex == 0)
                ElevatedButton(
                  onPressed: () => controllerRegister(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: HexColor('29B6F6'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    _step[_pageIndex]['tombol'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.outlined(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          ),
                          builder: (_) {
                            return ModalChooser(
                              titleText: 'Ulang lagi ke awal?',
                              descriptionText: 'Kamu mau ulang lagi registrasinya dari awal?',
                              onPressedBtnLeft: () {
                                Navigator.of(context).pop();
                              },
                              textBtnLeft: 'Batal',
                              colorBtnLeft: GlobalColors.mainColor,
                              onPressedBtnRight: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                                );
                              },
                              textBtnRight: 'Lanjut',
                              colorBtnRight: GlobalColors.mainColor,
                            );
                          },
                        );
                      },
                      style: IconButton.styleFrom(
                          minimumSize: const Size(55, 55),
                          side: BorderSide(
                            color: GlobalColors.garisColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      icon: Icon(
                        Icons.replay,
                        size: 20,
                        color: GlobalColors.fourthColor,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => controllerRegister(),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(280, 55),
                        backgroundColor: HexColor('29B6F6'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        _step[_pageIndex]['tombol'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 30),
              if (_pageIndex == 0)
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
                          fontSize: 13,
                          color: GlobalColors.mainColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModalCategory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) {
        return ModalCategory(controller: shopCategoryController);
      },
    );
  }

  void _showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) {
        return ModalPickImage(onImageSelected: _onImageSelected);
      },
    );
  }
}
