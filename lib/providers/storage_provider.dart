import 'dart:developer';
import 'dart:io';

import 'package:e_commerce/firebase/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageProvider extends ChangeNotifier {

  uploadImage() async {
      XFile? categoryImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      String url = await StorageHelper.storageHelper.uploadImage(File(categoryImage!.path));
      log(url);
  }

}