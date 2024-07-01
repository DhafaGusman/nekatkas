import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../colors/global_colors.dart';

class ImagePickerUtil {
  static Future<void> pickImageFromGallery(Function(File) onImageSelected) async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        _cropImage(File(value.path), onImageSelected);
      }
    });
  }

  static Future<void> pickImageFromCamera(Function(File) onImageSelected) async {
    await ImagePicker().pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        _cropImage(File(value.path), onImageSelected);
      }
    });
  }

  static Future<void> _cropImage(File imgFile, Function(File) onImageSelected) async {
    debugPrint("Starting image crop...");
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Pangkas gambar',
            toolbarColor: GlobalColors.mainColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Pangkas gambar'),
        ],
      );

      if (croppedFile != null) {
        debugPrint("Image cropped successfully.");
        imageCache.clear();
        onImageSelected(File(croppedFile.path));
      } else {
        debugPrint("Cropping cancelled or failed.");
      }
    } catch (e) {
      debugPrint("Error cropping image: $e");
    }
    debugPrint("Image crop process ended.");
  }
}
