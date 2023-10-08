import 'package:dio/dio.dart';

import '../../../services/dio_client.dart';
import '../../models/network_models/itinerary_model.dart';

class ItineraryRepository {
  Dio dio = Client().init();
  List<ItineraryModel> fixedItinerary = <ItineraryModel>[];
  Future<ApiResponse<List<ItineraryModel>>> getFixedItinerary(
      String tourCode) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/itinerary/?tour_code=$tourCode'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        fixedItinerary =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return ItineraryModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<ItineraryModel>>.completed(fixedItinerary);
      } else {
        return ApiResponse<List<ItineraryModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<ItineraryModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<ItineraryModel>>.error(e.toString());
    }
  }
}
