import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nekatkas/utils/colors/global_colors.dart';
import 'package:nekatkas/view/home/home_page.dart';

// -- Register Loading -- //

class RegisterLoading extends StatefulWidget {
  const RegisterLoading({super.key});

  @override
  State<RegisterLoading> createState() => _RegisterLoadingState();
}

class _RegisterLoadingState extends State<RegisterLoading> with SingleTickerProviderStateMixin {
  late final AnimationController loadingController;

  @override
  void initState() {
    super.initState();
    loadingController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/animation-loading.json',
              controller: loadingController,
              onLoaded: (composition) {
                loadingController
                  ..duration = composition.duration
                  ..repeat();
              },
              width: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              'Data kamu lagi di proses...',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: GlobalColors.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// -- Register Success -- //

class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({super.key});

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/animation-success.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
              width: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Berhasil!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Akun kamu berhasil dibuat',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 55),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            'Selesai',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: GlobalColors.mainColor,
            ),
          ),
        ),
      ),
    );
  }
}

// -- Register Unsucessful -- //

class RegisterUnsuccessful extends StatefulWidget {
  const RegisterUnsuccessful({super.key});

  @override
  State<RegisterUnsuccessful> createState() => _RegisterUnsuccessfulState();
}

class _RegisterUnsuccessfulState extends State<RegisterUnsuccessful> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/animation-x.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
              width: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Gagal :(',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Akun gak berhasil dibuat',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 55),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            'Kembali',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: GlobalColors.mainColor,
            ),
          ),
        ),
      ),
    );
  }
}

void navigateToRegisterLoading(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterLoading()));
}

void navigateToRegisterSuccess(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const RegisterSuccess()));
}

void navigateToRegisterUnsuccessful(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const RegisterUnsuccessful()));
}

Future<void> handleRegistrationSubmit(BuildContext context) async {
  navigateToRegisterLoading(context);

  await Future.delayed(const Duration(seconds: 5));

  navigateToRegisterSuccess(context);
}
