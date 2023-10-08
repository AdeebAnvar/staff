import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../services/dio_client.dart';
import '../../models/network_models/tours_model.dart';

class ToursRepository {
  Dio dio = Client().init();
  List<TourModel> tour = <TourModel>[];
  Future<ApiResponse<List<TourModel>>> getAllToursInDepartment(
      String depID) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/?dep_id=$depID'),
          options: Options(headers: authHeader));
      log('Adeeb rep ${res.data}');
      log('Adeeb rep ${res.statusMessage}');
      if (res.statusCode == 200) {
        tour = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return TourModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<TourModel>>.completed(tour);
      } else {
        return ApiResponse<List<TourModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<TourModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<TourModel>>.error(e.toString());
    }
  }
}
