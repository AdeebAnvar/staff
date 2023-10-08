import 'package:dio/dio.dart';

import '../../../services/dio_client.dart';
import '../../models/network_models/followup_model.dart';
import '../../models/network_models/leads_model.dart';

class SearchRepository {
  Dio dio = Client().init();
  List<LeadsModel> leads = <LeadsModel>[];
  List<FollowUpModel> fleads = <FollowUpModel>[];
  Future<ApiResponse<List<LeadsModel>>> searchLeadinFreshLeadsByName(
      String name) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/fresh?name=$name'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        leads = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return LeadsModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<LeadsModel>>.completed(leads);
      } else {
        return ApiResponse<List<LeadsModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<LeadsModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<LeadsModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<LeadsModel>>> searchLeadinFreshLeadsById(
      String id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/fresh?id=$id'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        leads = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return LeadsModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<LeadsModel>>.completed(leads);
      } else {
        return ApiResponse<List<LeadsModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<LeadsModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<LeadsModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<FollowUpModel>>> searchLeadinOldLeadsByName(
      String name) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/old?name=$name'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        fleads = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return FollowUpModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<FollowUpModel>>.completed(fleads);
      } else {
        return ApiResponse<List<FollowUpModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<FollowUpModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<FollowUpModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<FollowUpModel>>> searchLeadinOldLeadsById(
      String id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/old?id=$id'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        fleads = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return FollowUpModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<FollowUpModel>>.completed(fleads);
      } else {
        return ApiResponse<List<FollowUpModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<FollowUpModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<FollowUpModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<FollowUpModel>>> searchLeadinFollowUpLeadsByName(
      String name) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/followup?name=$name'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        fleads = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return FollowUpModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<FollowUpModel>>.completed(fleads);
      } else {
        return ApiResponse<List<FollowUpModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<FollowUpModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<FollowUpModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<FollowUpModel>>> searchLeadinFollowUpLeadsById(
      String id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/followup?id=$id'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        fleads = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return FollowUpModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<FollowUpModel>>.completed(fleads);
      } else {
        return ApiResponse<List<FollowUpModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<FollowUpModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<FollowUpModel>>.error(e.toString());
    }
  }
}
