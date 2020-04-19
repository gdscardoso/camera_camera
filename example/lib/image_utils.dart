import 'dart:io';

import 'package:image/image.dart';

Future<File> parseImage(File file) async {
  var newFile = File(file.path.replaceAll('.jpg', '') + "new.jpg");
  var image = decodeJpg(file.readAsBytesSync());
  Image newImage = flip(image, Flip.horizontal);
  newImage = copyRotate(newImage, 270);

  return newFile..writeAsBytesSync(encodePng(newImage));
}
