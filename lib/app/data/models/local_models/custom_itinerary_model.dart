class CustomItineraryModel {
  CustomItineraryModel(
      {this.tour,
      this.tourStartDateTime,
      this.tourEndingDateTime,
      this.totalDays,
      this.totalNights,
      this.adults,
      this.kids,
      this.infants,
      this.itineraryRooms,
      this.itineraryVehicles});
  String? tour;
  DateTime? tourStartDateTime;
  DateTime? tourEndingDateTime;
  String? totalDays;
  String? totalNights;
  String? adults;
  String? kids;
  String? infants;
  List<ItineraryRooms>? itineraryRooms;
  List<ItineraryVehicles>? itineraryVehicles;
}

class ItineraryRooms {
  ItineraryRooms({this.roomId, this.qty});
  List<String>? roomId;
  List<int>? qty;
}

class ItineraryVehicles {
  ItineraryVehicles({this.vehicleId, this.qty});
  List<String>? vehicleId;
  List<int>? qty;
}

class CustomRooms {
  CustomRooms({this.roomId, this.qty});
  String? roomId;
  String? qty;
}

class CustomVehicles {
  CustomVehicles({this.vehicleId, this.qty});
  String? vehicleId;
  String? qty;
}




/* 
 * tour
 * start date
 * end date
 * days
 * nights
 * adults
 * kids
 * infants
 * 
 */

/*
 *  List<roons> rooms
 * List<Vehicle> vehicle
 * 
*/
