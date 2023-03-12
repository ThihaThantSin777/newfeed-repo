
import 'dart:io';

import 'package:simple_news_feed_app/constant/strings.dart';
import 'package:simple_news_feed_app/network/data_agent/firebase_storage_store.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageStoreImpl extends FirebaseStorageStore{
  final _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<String> uploadFileToFirebase(File image) => _firebaseStorage
      .ref(kFileUploadPath)
      .child('${DateTime.now().millisecondsSinceEpoch}')
      .putFile(image)
      .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());
  
}