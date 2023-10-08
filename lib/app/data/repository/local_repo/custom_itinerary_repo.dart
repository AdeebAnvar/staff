// import 'dart:convert';
// import 'dart:developer';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../../models/local_models/custom_itinerary_model.dart';

// class CustomItineraryRepoSitory {
//   static Future<void> saveData(List<CustomItineraryModel> models) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     // Convert the list of models to a list of maps
//     final List<Map<String, dynamic>> modelList =
//         models.map((CustomItineraryModel model) => model.toMap()).toList();

//     // Encode the list of maps as a JSON string and save it in SharedPreferences
//     final String modelJson = jsonEncode(modelList);
//     await prefs.setString('custom_itinerary', modelJson);
//   }

//   static Future<List<CustomItineraryModel>?> getData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? modelJson = prefs.getString('custom_itinerary');
//     if (modelJson != null) {
//       log('nukunuku u ${jsonDecode(modelJson)}');
//       final Map<String, dynamic> modelMap =
//           jsonDecode(modelJson) as Map<String, dynamic>;
//       log('kuukunu ${modelMap}');
//       final List<dynamic> modelList = modelMap['data'] as List<dynamic>;
//       if (modelList is List<Map<String, dynamic>>) {
//         return CustomItineraryModel.fromMapList(
//             modelList.cast<Map<String, dynamic>>());
//       }
//     }
//     return [];
//   }
// }
