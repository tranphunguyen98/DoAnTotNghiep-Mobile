import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> saveImage(String imagePath, String fileName) async {
// getting a directory path for saving
  final imageFile = File(imagePath);
  final String rootPath = (await getApplicationDocumentsDirectory()).path;
  final String savingPath = '$rootPath/images';
  await createDir(savingPath);
// copy the file to a new path
  final File newImage = await imageFile.copy('$savingPath/$fileName');
  return newImage.path;
}

String getExtensionFromPath(String fileName) {
  final int i = fileName.lastIndexOf('.');
  if (i > 0) {
    return fileName.substring(i);
  }
  return null;
}

Future<void> createDir(String dirPath) async {
  final dir = Directory(dirPath);
  final bool dirExists = await dir.exists();
  if (!dirExists) {
    dir.create();
  }
}
