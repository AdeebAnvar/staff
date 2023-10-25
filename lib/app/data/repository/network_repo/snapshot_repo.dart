import 'package:dio/dio.dart';

import '../../../services/dio_client.dart';
import '../../models/network_models/single_room_model.dart';
import '../../models/network_models/single_vehicle_model.dart';

class SnapShotRepo {
  Dio dio = Client().init();

  Future<ApiResponse<List<SingleRoomModel>>?> fetchRooms(
      List<String> roomIDs) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('rooms/get-room'),
          data: {'room_id': roomIDs},
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        return null;
      } else {
        return ApiResponse<List<SingleRoomModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<SingleRoomModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<SingleRoomModel>>.error(e.toString());
    }
  }
}
