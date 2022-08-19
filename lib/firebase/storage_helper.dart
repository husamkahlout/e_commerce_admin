import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  static StorageHelper storageHelper = StorageHelper();
  FirebaseStorage firebaseStorageInstance = FirebaseStorage.instance;
  Future<String> uploadImage(File file) async {
    /*
    split the String to list of String 
    fileName example https://www.facebook.com/husamkahlout99/photos/husam.png
    fileName after split => [www.facebook.com,husamkahlout99,photos,husam.png]
    last of array is the name of the file => husam.png
    */
    String fileName = file.path.split('/').last;
    // the reference of the file , if not exits => create it
    Reference reference = firebaseStorageInstance.ref("images/categories/$fileName");
    //TaskSnapshot mean its the upload is complete
    // putFile => upload the file to the reference in storage 
    TaskSnapshot uploadTask = await reference.putFile(file);
    // get the link of the file from firebase storage
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
}
