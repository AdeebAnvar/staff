import 'package:dio/dio.dart';

import '../../../services/dio_client.dart';

class FieldStaffBookingsRepository {
  Dio dio = Client().init();

  Future<ApiResponse<Map<String, dynamic>>> completedTask(
      {required String taskId}) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.putUri(
          Uri.parse('bookings/staff/tasks'),
          data: <String, String>{'task_id': taskId, 'status': 'completed'},
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        return ApiResponse<Map<String, dynamic>>.completed(res.data);
      } else {
        return ApiResponse<Map<String, dynamic>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<Map<String, dynamic>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<Map<String, dynamic>>.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> inCompletedTask(
      {required String taskId, required String reason}) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.putUri(
          Uri.parse('bookings/staff/tasks'),
          data: <String, String>{
            'task_id': taskId,
            'status': 'In complete',
            'reason': reason
          },
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        return ApiResponse<Map<String, dynamic>>.completed(res.data);
      } else {
        return ApiResponse<Map<String, dynamic>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<Map<String, dynamic>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<Map<String, dynamic>>.error(e.toString());
    }
  }
}
