import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../services/dio_client.dart';
import '../../models/network_models/followup_model.dart';
import '../../models/network_models/lead_response_model.dart';
import '../../models/network_models/leads_model.dart';
import '../../models/network_models/single_leads_model.dart';

class LeadsRepository {
  Dio dio = Client().init();
  List<LeadsModel> leads = <LeadsModel>[];
  List<FollowUpModel> followups = <FollowUpModel>[];
  List<LeadResponseModel> resPonses = <LeadResponseModel>[];
  Future<ApiResponse<List<LeadsModel>>> getFreshLeads(int page) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/fresh?page=$page'),
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

  Future<ApiResponse<List<LeadResponseModel>>> getAllResponses(
      String customerID) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('audio/$customerID'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        resPonses = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return LeadResponseModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<LeadResponseModel>>.completed(resPonses);
      } else {
        return ApiResponse<List<LeadResponseModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<LeadResponseModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<LeadResponseModel>>.error(e.toString());
    }
  }

  // Future<ApiResponse<List<SingleLeadModel>>> getAllLeads(
  //     String? tourCode) async {
  //   try {
  //     final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
  //     final Response<Map<String, dynamic>> res = await dio.getUri(
  //         Uri.parse('leads/tour/?tour_code=$tourCode'),
  //         options: Options(headers: authHeader));
  //     if (res.statusCode == 200) {
  //       final List<SingleLeadModel> leadsData =
  //           (res.data!['result'] as List<dynamic>).map((dynamic e) {
  //         return SingleLeadModel.fromJson(e as Map<String, dynamic>);
  //       }).toList();
  //       return ApiResponse<List<SingleLeadModel>>.completed(leadsData);
  //     } else {
  //       return ApiResponse<List<SingleLeadModel>>.error(res.statusMessage);
  //     }
  //   } on DioException catch (de) {
  //     return ApiResponse<List<SingleLeadModel>>.error(de.error.toString());
  //   } catch (e) {
  //     return ApiResponse<List<SingleLeadModel>>.error(e.toString());
  //   }
  // }

  Future<ApiResponse<List<FollowUpModel>>> getAllFollowUpsLeads(
      int page) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/followup?page=$page'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        followups = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return FollowUpModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<FollowUpModel>>.completed(followups);
      } else {
        return ApiResponse<List<FollowUpModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<FollowUpModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<FollowUpModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<FollowUpModel>>> getAllOldLeads(int page) async {
    log('krr frvbr');
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/old?page=$page'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        followups = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return FollowUpModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<FollowUpModel>>.completed(followups);
      } else {
        return ApiResponse<List<FollowUpModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<FollowUpModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<FollowUpModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> updateCustomer(
      {String? customername,
      String? customerphone,
      String? customervehicle,
      String? customerwhatapp,
      String? customerprogress,
      int? customerpax,
      String? customersource,
      String? customeraddress,
      String? customercity,
      String? customerremarks,
      String? customercategory,
      int? customerID,
      String? customerCategory,
      String? remarks,
      String? depId,
      String? branchId,
      String? tour}) async {
    final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
    final Response<Map<String, dynamic>> res = await dio.putUri(
      Uri.parse('users'),
      options: Options(headers: authHeader),
      data: <String, dynamic>{
        'customer_id': customerID,
        'customer_name': customername,
        'customer_phone': customerphone,
        'customer_vehicle': customervehicle,
        'customer_whatapp': customerwhatapp,
        'customer_progress': customerprogress,
        'customer_pax': customerpax,
        'customer_source': customersource,
        'customer_address': customeraddress,
        'customer_city': customercity,
        'customer_remarks': remarks,
        'customer_category': customerCategory,
        'tour': tour,
        'dep_id': depId,
        'branch_id': branchId,
      },
    );
    try {
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

  Future<ApiResponse<Map<String, dynamic>>> addFollowUpResponseWithAudio({
    String? audioPath,
    String? audioName,
    String? responseText,
    String? followUpDate,
    String? customeID,
    String? leadID,
    String? customerProgress,
  }) async {
    final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'audio': await MultipartFile.fromFile(
        audioPath.toString(),
        contentType: MediaType('audio', 'mp3'),
      ),
      'response_text': responseText,
      'customer_id': customeID,
      'lead_id': leadID,
      'customer_progress': customerProgress,
      'follow_date': followUpDate,
    });
    final Response<Map<String, dynamic>> res = await dio.postUri(
      Uri.parse('audio/upload'),
      options: Options(headers: authHeader),
      data: formData,
    );
    try {
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

  Future<ApiResponse<Map<String, dynamic>>> addFollowUpResponseWithoutAudio({
    String? audioPath,
    String? audioName,
    String? responseText,
    String? followUpDate,
    String? customeID,
    String? leadID,
    String? customerProgress,
  }) async {
    final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'response_text': responseText,
      'customer_id': customeID,
      'lead_id': leadID,
      'customer_progress': customerProgress,
      'follow_date': followUpDate,
    });
    final Response<Map<String, dynamic>> res = await dio.postUri(
      Uri.parse('audio/upload'),
      options: Options(headers: authHeader),
      data: formData,
    );
    try {
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

  Future<ApiResponse<Map<String, dynamic>>> addNormalResponseWithAudio({
    String? audioPath,
    String? audioName,
    String? responseText,
    String? followUpDate,
    String? customeID,
    String? leadID,
    String? customerProgress,
  }) async {
    final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'audio': await MultipartFile.fromFile(
        audioPath.toString(),
        contentType: MediaType('audio', 'mp3'),
      ),
      'response_text': responseText,
      'customer_id': customeID,
      'lead_id': leadID,
      'customer_progress': customerProgress,
    });
    final Response<Map<String, dynamic>> res = await dio.postUri(
      Uri.parse('audio/upload'),
      options: Options(headers: authHeader),
      data: formData,
    );
    try {
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

  Future<ApiResponse<Map<String, dynamic>>> addNormalResponseWithoutAudio({
    String? audioPath,
    String? audioName,
    String? responseText,
    String? followUpDate,
    String? customeID,
    String? leadID,
    String? customerProgress,
  }) async {
    final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'response_text': responseText,
      'customer_id': customeID,
      'lead_id': leadID,
      'customer_progress': customerProgress,
    });
    final Response<Map<String, dynamic>> res = await dio.postUri(
      Uri.parse('audio/upload'),
      options: Options(headers: authHeader),
      data: formData,
    );
    try {
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

  Future<ApiResponse<List<SingleLeadModel>>> getSingleLead(String id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('leads/$id'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        final List<SingleLeadModel> leads =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return SingleLeadModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<SingleLeadModel>>.completed(leads);
      } else {
        return ApiResponse<List<SingleLeadModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<SingleLeadModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<SingleLeadModel>>.error(e.toString());
    }
  }
}
