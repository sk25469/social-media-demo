import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media/utils/file_utils.dart';
import 'package:uuid/uuid.dart';

abstract class Service {
  String id = const Uuid().v4();
  Future<String> uploadImage(Reference ref, File file) async {
    String ext = FileUtils.getFileExtension(file);
    Reference storageReference = ref.child("$id.$ext");
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => null);
    String fileUrl = await storageReference.getDownloadURL();
    return fileUrl;
  }
}
