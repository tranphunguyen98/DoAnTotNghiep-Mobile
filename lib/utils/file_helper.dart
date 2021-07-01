import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:totodo/utils/util.dart';

Future<String> saveImageFromGallery(
    String imagePath, String id, String fileName) async {
// getting a directory path for saving
  final imageFile = File(imagePath);
  final String rootPath = (await getApplicationDocumentsDirectory()).path;
  final String savingPath = '$rootPath/images';
  await createDir(savingPath);
  final String idPath = '$savingPath/$id';
  await createDir(idPath);
// copy the file to a new path
  final File newImage = await imageFile.copy('$idPath/$fileName');
  return newImage.path;
}

Future<String> saveImageFromUrl(String url, String fileName) async {
  final dio = Dio();
  final String rootPath = (await getApplicationDocumentsDirectory()).path;
  final String savingPath = '$rootPath/images';
  await createDir(savingPath);
  var isSuccess = false;
  await dio
      .download(url, '$savingPath/$fileName',
          options: Options(receiveTimeout: 3000))
      .timeout(
    Duration(seconds: 3),
    onTimeout: () {
      log('testAsync', 'timeOut $url $fileName');
      return null;
    },
  ).then((value) {
    if (value != null) {
      isSuccess = true;
    }
  }).onError((error, stackTrace) {
    log('testAsync', stackTrace);
    return null;
  });
  if (isSuccess) {
    return '$savingPath/$fileName';
  }
  return null;
}

String getExtensionFromPath(String fileName) {
  final int i = fileName.lastIndexOf('.');
  if (i > 0) {
    return fileName.substring(i);
  }
  return null;
}

Future<void> clearImages() async {
  final String rootPath = (await getApplicationDocumentsDirectory()).path;
  final String savingPath = '$rootPath/images';
  final dir = Directory(savingPath);

  if (dir.existsSync()) {
    dir.listSync().forEach((eDir) {
      if (eDir is File) {
        eDir.deleteSync();
      } else if (eDir is Directory) {
        eDir.listSync().forEach((element) {
          if (element is File) {
            element.deleteSync();
          }
        });
        eDir.deleteSync();
      }
    });
    log('testAsync', 'deleteSuccess${dir.listSync().length}');
    dir.deleteSync(recursive: true);
  }
}

Future<void> createDir(String dirPath) async {
  final dir = Directory(dirPath);
  final bool dirExists = await dir.exists();
  if (!dirExists) {
    dir.create();
  }
}
