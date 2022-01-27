import 'dart:io';

class FileUtils {
  static String getFileExtension(File file) {
    List fileNameSplit = file.path.split(".");
    String extension = fileNameSplit.last;
    return extension;
  }
}
