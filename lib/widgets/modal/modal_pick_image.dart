import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:nekatkas/widgets/snackbar/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/colors/global_colors.dart';
import '../../utils/image_picker/image_picker.dart';

class ModalPickImage extends StatelessWidget {
  const ModalPickImage({
    super.key,
    this.isTambah = true,
    required this.onImageSelected,
  });

  final bool isTambah;
  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
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
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        FeatherIcons.x,
                        size: 20,
                        color: GlobalColors.fourthColor,
                      ),
                    ),
                  ),
                  Text(
                    isTambah ? 'Tambah foto' : 'Ganti foto',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: GlobalColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Divider(
            color: GlobalColors.garisColor,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    Map<Permission, PermissionStatus> statuss = await [
                      Permission.camera,
                    ].request();
                    if (statuss[Permission.camera]!.isGranted) {
                      Navigator.of(context).pop();
                      ImagePickerUtil.pickImageFromCamera(onImageSelected);
                    } else {
                      Navigator.of(context).pop();
                      CustomSnackbar.show(
                        context,
                        Colors.orange,
                        FeatherIcons.alertCircle,
                        'Peringatan',
                        'Akses kamera ditolak',
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.camera,
                        size: 30,
                        color: GlobalColors.textColor,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Ambil dari kamera',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: GlobalColors.textColor,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    ImagePickerUtil.pickImageFromGallery(onImageSelected);
                  },
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.image,
                        size: 30,
                        color: GlobalColors.textColor,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Pilih dari galeri',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: GlobalColors.textColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
