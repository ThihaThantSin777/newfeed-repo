import 'dart:io';

abstract class FirebaseStorageStore{
  Future<String> uploadFileToFirebase(File image);
}