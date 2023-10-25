import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../services/dio_client.dart';
import '../../models/network_models/field_staff_model.dart';
import '../../models/network_models/field_staff_single_booking_model.dart';

class FieldStaffBookingRepo {
  Dio dio = Client().init();
  List<FieldStaffBookingModel> fieldStaffBookingModel =
      <FieldStaffBookingModel>[];
  List<FieldStaffSingleBookingModel> fieldStaffSingleBookingModel =
      <FieldStaffSingleBookingModel>[];
  Future<ApiResponse<List<FieldStaffBookingModel>>>
      getFieldStaffBookings() async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('bookings/staff/'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        fieldStaffBookingModel =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return FieldStaffBookingModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<FieldStaffBookingModel>>.completed(
            fieldStaffBookingModel);
      } else {
        return ApiResponse<List<FieldStaffBookingModel>>.error(
            res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<FieldStaffBookingModel>>.error(
          de.error.toString());
    } catch (e) {
      return ApiResponse<List<FieldStaffBookingModel>>.error(e.toString());
    }
  }

  Future<List<List<Result>>> getFieldStaffSingleBookings(
      String bookingId) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('bookings/staff/tasks?booking_id=$bookingId'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        final FieldStaffSingleBookingModel fieldStaffSingleBookingModel =
            FieldStaffSingleBookingModel.fromJson(res.data!);
        log('fbgbg ${fieldStaffSingleBookingModel.result}');
        return fieldStaffSingleBookingModel.result!;
      } else {
        log('grgr');
        return <List<Result>>[];
      }
    } on DioException catch (de) {
      log('grgr de  $de');
      log(de.toString());
      return <List<Result>>[];
    } catch (e) {
      log('grgr catch de  $e');
      return <List<Result>>[];
    }
  }
}
