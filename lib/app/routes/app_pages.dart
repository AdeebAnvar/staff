import 'package:get/get.dart';

import '../modules/booking_screen/bindings/booking_screen_binding.dart';
import '../modules/booking_screen/views/booking_screen_view.dart';
import '../modules/calling_page/bindings/calling_page_binding.dart';
import '../modules/calling_page/views/calling_page_view.dart';
import '../modules/category_wise_leads/bindings/category_wise_leads_binding.dart';
import '../modules/category_wise_leads/views/category_wise_leads_view.dart';
import '../modules/custom_booking/bindings/custom_booking_binding.dart';
import '../modules/custom_booking/views/custom_booking_view.dart';
import '../modules/custom_itinerary/bindings/custom_itinerary_binding.dart';
import '../modules/custom_itinerary/views/custom_itinerary_view.dart';
import '../modules/custombookingcalculation/bindings/custombookingcalculation_binding.dart';
import '../modules/custombookingcalculation/views/custombookingcalculation_view.dart';
import '../modules/fixed_itineraries/bindings/fixed_itineraries_binding.dart';
import '../modules/fixed_itineraries/views/fixed_itineraries_view.dart';
import '../modules/follow_ups/bindings/follow_ups_binding.dart';
import '../modules/follow_ups/views/follow_ups_view.dart';
import '../modules/fresh_leads/bindings/fresh_leads_binding.dart';
import '../modules/fresh_leads/views/fresh_leads_view.dart';
import '../modules/full_leads/bindings/full_leads_binding.dart';
import '../modules/full_leads/views/full_leads_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leave_status_screen/bindings/leave_status_screen_binding.dart';
import '../modules/leave_status_screen/views/leave_status_screen_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/no_internet/bindings/no_internet_binding.dart';
import '../modules/no_internet/views/no_internet_view.dart';
import '../modules/old_leads/bindings/old_leads_binding.dart';
import '../modules/old_leads/views/old_leads_view.dart';
import '../modules/pdf/bindings/pdf_binding.dart';
import '../modules/pdf/views/pdf_view.dart';
import '../modules/pdf_viewer_page/bindings/pdf_viewer_page_binding.dart';
import '../modules/pdf_viewer_page/views/pdf_viewer_page_view.dart';
import '../modules/previous_bookings/bindings/previous_bookings_binding.dart';
import '../modules/previous_bookings/views/previous_bookings_view.dart';
import '../modules/responses_screen/bindings/responses_screen_binding.dart';
import '../modules/responses_screen/views/responses_screen_view.dart';
import '../modules/single_booking_details/bindings/single_booking_details_binding.dart';
import '../modules/single_booking_details/views/single_booking_details_view.dart';
import '../modules/single_lead/bindings/single_lead_binding.dart';
import '../modules/single_lead/views/single_lead_view.dart';
import '../modules/single_snapshot/bindings/single_snapshot_binding.dart';
import '../modules/single_snapshot/views/single_snapshot_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/telecaller_profile/bindings/telecaller_profile_binding.dart';
import '../modules/telecaller_profile/views/telecaller_profile_view.dart';

// ignore_for_file: always_specify_types

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: non_constant_identifier_names
  static String INITIAL = Routes.SPLASH_SCREEN;
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: _Paths.HOME,
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 600),
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.leftToRightWithFade,
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.leftToRightWithFade,
      name: _Paths.FOLLOW_UPS,
      page: () => const FollowUpsView(),
      binding: FollowUpsBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.FRESH_LEADS,
      page: () => const FreshLeadsView(),
      binding: FreshLeadsBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.CATEGORY_WISE_LEADS,
      page: () => const CategoryWiseLeadsView(),
      binding: CategoryWiseLeadsBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.SINGLE_LEAD,
      page: () => const SingleLeadView(),
      binding: SingleLeadBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.BOOKING_SCREEN,
      page: () => const BookingScreenView(),
      binding: BookingScreenBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.CUSTOM_BOOKING,
      page: () => const CustomBookingView(),
      binding: CustomBookingBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.TELECALLER_PROFILE,
      page: () => const TelecallerProfileView(),
      binding: TelecallerProfileBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.CALLING_PAGE,
      page: () => const CallingPageView(),
      binding: CallingPageBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE_STATUS_SCREEN,
      page: () => const LeaveStatusScreenView(),
      binding: LeaveStatusScreenBinding(),
    ),
    GetPage(
      name: _Paths.FULL_LEADS,
      page: () => const FullLeadsView(),
      binding: FullLeadsBinding(),
    ),
    GetPage(
      name: _Paths.RESPONSES_SCREEN,
      page: () => const ResponsesScreenView(),
      binding: ResponsesScreenBinding(),
    ),
    GetPage(
      name: _Paths.PDF_VIEWER_PAGE,
      page: () => const PdfViewerPageView(),
      binding: PdfViewerPageBinding(),
    ),
    GetPage(
      name: _Paths.SINGLE_BOOKING_DETAILS,
      page: () => const SingleBookingDetailsView(),
      binding: SingleBookingDetailsBinding(),
    ),
    GetPage(
      name: _Paths.NO_INTERNET,
      page: () => const NoInternetView(),
      binding: NoInternetBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMBOOKINGCALCULATION,
      page: () => const CustombookingcalculationView(),
      binding: CustombookingcalculationBinding(),
    ),
    GetPage(
      name: _Paths.PREVIOUS_BOOKINGS,
      page: () => const PreviousBookingsView(),
      binding: PreviousBookingsBinding(),
    ),
    GetPage(
      name: _Paths.FIXED_ITINERARIES,
      page: () => const FixedItinerariesView(),
      binding: FixedItinerariesBinding(),
    ),
    GetPage(
      name: _Paths.OLD_LEADS,
      page: () => const OldLeadsView(),
      binding: OldLeadsBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOM_ITINERARY,
      page: () => CustomItineraryView(),
      binding: CustomItineraryBinding(),
    ),
    GetPage(
      name: _Paths.SINGLE_SNAPSHOT,
      page: () => const SingleSnapshotView(),
      binding: SingleSnapshotBinding(),
    ),
    GetPage(
      name: _Paths.PDF,
      page: () => const PdfView(),
      binding: PdfBinding(),
    ),
  ];
}
