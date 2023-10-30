import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> downloadImage(String imageUrl, String depName) async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String downloadPath = '${appDocDir.path}/$depName Logo.png';
  final File localFile = File(downloadPath);

  if (localFile.existsSync()) {
    // The image is already downloaded; return the local file path.
    return downloadPath;
  }

  final Dio dio = Dio();

  try {
    final Response<List<int>> response = await dio.get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      await localFile.writeAsBytes(
          response.data!); // Write the downloaded image to local storage
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
