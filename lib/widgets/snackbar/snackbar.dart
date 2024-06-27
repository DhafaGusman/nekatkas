import 'package:flutter/material.dart';

import '../../utils/colors/global_colors.dart';

class CustomSnackbar {
  static show(
    BuildContext context,
    Color color,
    IconData icon,
    String title,
    String message,
  ) {
    SnackBar snackBar = SnackBar(
      content: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: color.withAlpha(100),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: GlobalColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 250,
                      child: Expanded(
                        child: Text(
                          message,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: GlobalColors.textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      duration: const Duration(seconds: 3),
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
