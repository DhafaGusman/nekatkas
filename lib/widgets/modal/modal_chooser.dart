import 'package:flutter/material.dart';

import '../../utils/colors/global_colors.dart';

class ModalChooser extends StatelessWidget {
  const ModalChooser({
    super.key,
    required this.titleText,
    required this.descriptionText,
    required this.onPressedBtnLeft,
    required this.textBtnLeft,
    this.colorBtnLeft = Colors.black,
    required this.onPressedBtnRight,
    required this.textBtnRight,
    this.colorBtnRight = Colors.black,
  });

  final String titleText;
  final String descriptionText;
  final VoidCallback onPressedBtnLeft;
  final String textBtnLeft;
  final Color colorBtnLeft;
  final VoidCallback onPressedBtnRight;
  final String textBtnRight;
  final Color colorBtnRight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: GlobalColors.garisColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Center(
              child: Text(
                titleText,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: GlobalColors.textColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Divider(
            color: GlobalColors.garisColor,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  descriptionText,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: GlobalColors.textColor,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: onPressedBtnLeft,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(170, 55),
                        backgroundColor: colorBtnLeft,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        textBtnLeft,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: onPressedBtnRight,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(170, 55),
                        side: BorderSide(
                          color: colorBtnRight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        textBtnRight,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colorBtnRight,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
