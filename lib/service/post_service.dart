import 'dart:io';

import 'package:social_media/utils/firestore_database.dart';
import 'package:social_media/utils/service.dart';

class PostService extends Service {
  Future<String> getDownloadLink(File image) async {
    String link = await uploadImage(posts, image);
    return link;
  }
}
