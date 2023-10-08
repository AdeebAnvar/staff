import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../services/dio_client.dart';
import '../../models/network_models/leave_request_model.dart';
import '../../models/network_models/leave_status_model.dart';
import '../../models/network_models/telecaller_analytics_model.dart';
import '../../models/network_models/telecaller_model.dart';

class TelecallerRepository {
  Dio dio = Client().init();
  List<TeleCallerModel> teleCaller = <TeleCallerModel>[];
  TeleCallerAnalytics teleCallerAnalytics = TeleCallerAnalytics();
  Future<ApiResponse<List<TeleCallerModel>>> getTelecallerDetails() async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio
          .getUri(Uri.parse('auth'), options: Options(headers: authHeader));
      log('Adeeb rep ${res.data!['result']}');
      log('Adeeb rep ${res.statusMessage}');
      if (res.statusCode == 200) {
        teleCaller = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return TeleCallerModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<TeleCallerModel>>.completed(teleCaller);
      } else {
        return ApiResponse<List<TeleCallerModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<TeleCallerModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<TeleCallerModel>>.error(e.toString());
    }
  }
//00:07:95

  Future<ApiResponse<TeleCallerAnalytics>>
      getTelecallerAnalyticsDetails() async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/getanalytics'),
          options: Options(headers: authHeader));
      log('Adeeb rep ${res.data}');
      log('Adeeb rep ${res.statusMessage}');
      if (res.statusCode == 200) {
        teleCallerAnalytics = TeleCallerAnalytics.fromJson(
            res.data!['result'] as Map<String, dynamic>);

        return ApiResponse<TeleCallerAnalytics>.completed(teleCallerAnalytics);
      } else {
        return ApiResponse<TeleCallerAnalytics>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<TeleCallerAnalytics>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<TeleCallerAnalytics>.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> requestLeave(
      LeaveRequestModel leaveRequestModel) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res =
          await dio.postUri(Uri.parse('leaves'),
              options: Options(
                headers: authHeader,
              ),
              data: leaveRequestModel.toJson());
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

  Future<ApiResponse<List<LeaveStatusModel>>> getLeaveStatus() async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leaves/mystatus'),
          options: Options(headers: authHeader));
      log('Adeeb rep ${res.data}');
      log('Adeeb rep ${res.statusMessage}');
      if (res.statusCode == 200) {
        final List<LeaveStatusModel> leaveStatusModel =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return LeaveStatusModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<LeaveStatusModel>>.completed(leaveStatusModel);
      } else {
        return ApiResponse<List<LeaveStatusModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<LeaveStatusModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<LeaveStatusModel>>.error(e.toString());
    }
  }
}
