import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> downloadImage(String imageUrl) async {
  final Dio dio = Dio();
  try {
    final Response<List<int>> response = await dio.get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String downloadPath = '${appDocDir.path}/image.png';
      final File file = File(downloadPath);
      log(downloadPath);
      log('image : $imageUrl');
      await file.writeAsBytes(
          response.data!); // Write the actual response data as bytes
      log('Image downloaded successfully');
      return downloadPath;
    } else {
      log('Error downloading image: Response code ${response.statusCode}');
      return null;
    }
  } catch (error) {
    log('Error downloading image: $error');
    return null;
  }
}
