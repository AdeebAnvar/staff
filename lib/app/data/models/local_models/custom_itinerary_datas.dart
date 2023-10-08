import '../network_models/activity_model.dart';
import '../network_models/addons_model.dart';
import '../network_models/food_model.dart';
import '../network_models/places_model.dart';
import '../network_models/single_room_model.dart';
import '../network_models/single_vehicle_model.dart';

class CustomItineraryDatas {
  CustomItineraryDatas(
      {this.tour,
      this.tourStartingDateTime,
      this.tourEndingDateTime,
      this.days,
      this.nights,
      this.adults,
      this.kids,
      this.infants,
      this.rooms,
      this.vehicles,
      this.activitiesForSingleDayName,
      this.addonsForSingleDayName,
      this.placesForSingleDayName,
      this.paxCountForRoom,
      this.activitiesForSingleDay,
      this.addonsForSingleDay,
      this.foodForSingleDay,
      this.paxCountForVehicle,
      this.placesForSingleDay,
      this.roomsForSingleDay,
      this.vehiclesForSingleDay,
      this.roomNames,
      this.vehicleNames,
      this.roomCosts});
  String? tour;
  List<String>? roomNames;
  List<String>? vehicleNames;
  String? tourStartingDateTime;
  String? tourEndingDateTime;
  int? days;
  int? nights;
  int? adults;
  int? kids;
  int? infants;
  List<List<String>>? roomCosts;
  Map<int, String>? rooms;
  Map<int, String>? vehicles;
  Map<int, String>? paxCountForRoom;
  Map<int, String>? paxCountForVehicle;
  Map<String, List<PlacesModel>>? placesForSingleDay;
  Map<String, List<String>>? placesForSingleDayName;
  Map<String, List<SingleVehicleModel>>? vehiclesForSingleDay;
  Map<String, List<SingleRoomModel>>? roomsForSingleDay;
  Map<String, List<AddonsModel>>? addonsForSingleDay;
  Map<String, List<String>>? addonsForSingleDayName;
  Map<String, List<String>>? activitiesForSingleDayName;
  Map<String, List<ActivityModel>>? activitiesForSingleDay;
  Map<String, List<FoodModel>>? foodForSingleDay;
}
