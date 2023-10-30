import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  initializeDateFormatting('en_IN', '').then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade50,
        ),
        title: 'Application',
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

  // Future<void> postSnapshots() async {
  //   final String tourid = tours
  //       .firstWhere((TourModel element) =>
  //           element.tourName == selectedTourWithoutTransit.value)
  //       .tourId
  //       .toString();
  //   final List<String> tourIds = <String>[];
  //   tourIds.add(tourid);
  //   CustomBookingRepo().postSnapshots(
  //       adult: adults.value.toString(),
  //       cid: customerId.toString(),
  //       data: itinerarySnapshots.values.toList(),
  //       day: days.value.toString(),
  //       infant: infants.value.toString(),
  //       kid: kids.value.toString(),
  //       night: nights.value.toString(),
  //       tourEndingDate: tourEndingDateTime.toString(),
  //       tourStartingDate: tourStartingDateTime.toString(),
  //       tourIds: tourIds);
  // }
  
