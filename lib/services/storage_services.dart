import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService{
  final FirebaseStorage _storage = FirebaseStorage.instance;


  Future<String> uploadImage(Uint8List image, String childName, bool isPost) async {
         Reference ref = _storage.ref().child(childName);
         if(isPost){
           String id = const Uuid().v1();
           ref = ref.child(id);
         }

         UploadTask uploadTask = ref.putData(image);
         TaskSnapshot snap = await uploadTask;
         String downloadUrl = await snap.ref.getDownloadURL();
         return downloadUrl;

  }

}