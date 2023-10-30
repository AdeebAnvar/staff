// // ignore_for_file: always_specify_types

// class SingleSnapShotModel {
//   SingleSnapShotModel({
//     this.shotId,
//     this.customerId,
//     this.startDate,
//     this.endDate,
//     this.day,
//     this.night,
//     this.adults,
//     this.kids,
//     this.infants,
//     this.data,
//     this.created,
//     this.tourId,
//   });
//   String? shotId;
//   String? customerId;
//   String? startDate;
//   String? endDate;
//   int? day;
//   int? night;
//   int? adults;
//   int? kids;
//   int? infants;
//   List<Datum>? data;
//   String? created;
//   List<String>? tourId;

//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'shot_id': shotId,
//         'customer_id': customerId,
//         'start_date': startDate,
//         'end_date': endDate,
//         'day': day,
//         'night': night,
//         'adults': adults,
//         'kids': kids,
//         'infants': infants,
//         'data': List<dynamic>.from(data!.map((Datum x) => x.toJson())),
//         'created': created,
//         'tour_id': List<dynamic>.from(tourId!.map((String x) => x)),
//       };

//   static SingleSnapShotModel fromJson(Map<String, dynamic> json) =>
//       SingleSnapShotModel(
//         shotId: json['shot_id'] == null ? '' : json['shot_id'] as String,
//         customerId:
//             json['customer_id'] == null ? '' : json['customer_id'] as String,
//         startDate:
//             json['start_date'] == null ? '' : json['start_date'] as String,
//         endDate: json['end_date'] == null ? '' : json['end_date'] as String,
//         day: json['day'] == null ? 0 : json['day'] as int,
//         night: json['night'] == null ? 0 : json['night'] as int,
//         adults: json['adults'] == null ? 0 : json['adults'] as int,
//         kids: json['kids'] == null ? 0 : json['kids'] as int,
//         infants: json['infants'] == null ? 0 : json['infants'] as int,
//         data: List<Datum>.from(json['data'].map((dynamic x) => Datum.fromJson(x))),
//         created: json['created'] == null ? '' : json['created'] as String,
//         tourId: List<String>.from(json['tour_id'].map((dynamic x) => x)),
//       );
// }

// class Datum {
//   Datum({
//     this.placeId,
//     this.addons,
//     this.activity,
//     this.vehicle,
//     this.room,
//     this.food,
//   });
//   List<String>? placeId;
//   List<String>? addons;
//   List<Activity>? activity;
//   List<Vehicle>? vehicle;
//   List<Room>? room;
//   List<Food>? food;

//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'place_id':
//             placeId == null ? [] : List<dynamic>.from(placeId!.map((dynamic x) => x)),
//         'addons':
//             addons == null ? [] : List<dynamic>.from(addons!.map((dynamic x) => x)),
//         'activity': activity == null
//             ? []
//             : List<dynamic>.from(activity!.map((dynamic x) => x.toJson())),
//         'vehicle': vehicle == null
//             ? []
//             : List<dynamic>.from(vehicle!.map((dynamic x) => x.toJson())),
//         'room': room == null
//             ? []
//             : List<dynamic>.from(room!.map((dynamic x) => x.toJson())),
//         'food': food == null
//             ? []
//             : List<dynamic>.from(food!.map((Food x) => x.toJson())),
//       };

//   static Datum fromJson(Map<String, dynamic> json) => Datum(
//         placeId: List<String>.from(json['place_id'].map((dynamic x) => x)),
//         addons: json['addons'] == null
//             ? []
//             : List<String>.from(json['addons'].map((dynamic x) => x)),
//         activity: json['activity'] == null
//             ? []
//             : List<Activity>.from(
//                 json['activity'].map((dynamic x) => Activity.fromJson(x))),
//         vehicle: json['vehicle'] == null
//             ? []
//             : List<Vehicle>.from(
//                 json['vehicle'].map((dynamic x) => Vehicle.fromJson(x))),
//         room: json['room'] == null
//             ? []
//             : List<Room>.from(json['room'].map((dynamic x) => Room.fromJson(x))),
//         food: json['food'] == null
//             ? []
//             : List<Food>.from(json['food'].map((dynamic x) => Food.fromJson(x))),
//       );
// }

// class Activity {
//   Activity({
//     this.activityId,
//     this.activityQty,
//   });
//   String? activityId;
//   String? activityQty;

//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'activity_id': activityId,
//         'activity_qty': activityQty,
//       };

//   static Activity fromJson(Map<String, dynamic> json) => Activity(
//         activityId: json['activity_id'] ?? '',
//         activityQty: json['activity_qty'] ?? '',
//       );
// }

// class Room {
//   Room({
//     this.roomId,
//     this.roomQty,
//   });
//   String? roomId;
//   String? roomQty;

//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'room_id': roomId,
//         'room_qty': roomQty,
//       };

//   static Room fromJson(Map<String, dynamic> json) => Room(
//         roomId: json['room_id'] ?? '',
//         roomQty: json['room_qty'] ?? '',
//       );
// }

// class Food {
//   Food({
//     this.foodId,
//     this.foodQty,
//   });
//   String? foodId;
//   String? foodQty;

//   static Room fromJson(Map<String, dynamic> json) => Room(
//         roomId: json['room_id'] ?? '',
//         roomQty: json['room_qty'] ?? '',
//       );
//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'food_id': foodId,
//         'food_qty': foodQty,
//       };
// }

// class Vehicle {
//   Vehicle({
//     this.vehicleId,
//     this.vehicleQty,
//   });

//   factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
//         vehicleId: json['vehicle_id'] ?? '',
//         vehicleQty: json['vehicle_qty'] ?? '',
//       );
//   String? vehicleId;
//   String? vehicleQty;

//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'vehicle_id': vehicleId,
//         'vehicle_qty': vehicleQty,
//       };
// }
import 'dart:convert';
import 'dart:developer';

SingleSnapShotModel singleSnapShotModelFromJson(String str) =>
    SingleSnapShotModel.fromJson(json.decode(str));

String singleSnapShotModelToJson(SingleSnapShotModel data) =>
    json.encode(data.toJson());

class SingleSnapShotModel {
  SingleSnapShotModel({
    this.result,
    this.success,
  });
  factory SingleSnapShotModel.fromJson(Map<String, dynamic> json) {
    log('kunununun${json['result']}');
    if (json['result'] is List) {
      return SingleSnapShotModel(
        result: List<Result>.from(
            json['result'].map((dynamic x) => Result.fromJson(x))),
        success: json['success'],
      );
    } else {
      return SingleSnapShotModel(result: <Result>[], success: false);
    }
  }

  List<Result>? result;
  bool? success;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': List<dynamic>.from(result!.map((Result x) => x.toJson())),
        'success': success,
      };
}

class Result {
  Result({
    this.shotId,
    this.customerId,
    this.startDate,
    this.endDate,
    this.day,
    this.night,
    this.adults,
    this.kids,
    this.infants,
    this.data,
    this.created,
    this.tourId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        shotId: json['shot_id'],
        customerId: json['customer_id'],
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
        day: json['day'],
        night: json['night'],
        adults: json['adults'],
        kids: json['kids'],
        infants: json['infants'],
        data: List<Datum>.from(
            json['data'].map((dynamic x) => Datum.fromJson(x))),
        created: DateTime.parse(json['created']),
        tourId: List<String>.from(json['tour_id'].map((dynamic x) => x)),
      );
  String? shotId;
  String? customerId;
  DateTime? startDate;
  DateTime? endDate;
  int? day;
  int? night;
  int? adults;
  int? kids;
  int? infants;
  List<Datum>? data;
  DateTime? created;
  List<String>? tourId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'shot_id': shotId,
        'customer_id': customerId,
        'start_date': startDate?.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'day': day,
        'night': night,
        'adults': adults,
        'kids': kids,
        'infants': infants,
        'data': List<dynamic>.from(data!.map((Datum x) => x.toJson())),
        'created': created?.toIso8601String(),
        'tour_id': List<dynamic>.from(tourId!.map((String x) => x)),
      };
}

class Datum {
  Datum({
    this.placeId,
    this.addons,
    this.activity,
    this.vehicle,
    this.room,
    this.food,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        placeId: json['place_id'] == null
            ? <String>[]
            : List<String>.from(json['place_id'].map((dynamic x) => x)),
        addons: json['addons'] == null
            ? <String>[]
            : List<String>.from(json['addons'].map((dynamic x) => x)),
        activity: json['activity'] == null
            ? <Activity>[]
            : List<Activity>.from(
                json['activity'].map((dynamic x) => Activity.fromJson(x))),
        vehicle: json['vehicle'] == null
            ? <Vehicle>[]
            : List<Vehicle>.from(
                json['vehicle'].map((dynamic x) => Vehicle.fromJson(x))),
        room: json['room'] == null
            ? <Room>[]
            : List<Room>.from(
                json['room'].map((dynamic x) => Room.fromJson(x))),
        food: json['food'] == null
            ? <Food>[]
            : List<Food>.from(
                json['food'].map((dynamic x) => Food.fromJson(x))),
      );
  List<String>? placeId;
  List<String>? addons;
  List<Activity>? activity;
  List<Vehicle>? vehicle;
  List<Room>? room;
  List<Food>? food;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'place_id': List<dynamic>.from(placeId!.map((String x) => x)),
        'addons': List<dynamic>.from(addons!.map((String x) => x)),
        'activity':
            List<dynamic>.from(activity!.map((Activity x) => x.toJson())),
        'vehicle': List<dynamic>.from(vehicle!.map((Vehicle x) => x.toJson())),
        'room': List<dynamic>.from(room!.map((Room x) => x.toJson())),
        'food': List<dynamic>.from(food!.map((Food x) => x.toJson())),
      };
}

class Activity {
  Activity({
    this.activityId,
    this.activityQty,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        activityId: json['activity_id'],
        activityQty: json['activity_qty'],
      );
  String? activityId;
  String? activityQty;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'activity_id': activityId,
        'activity_qty': activityQty,
      };
}

class Room {
  Room({
    this.roomId,
    this.roomQty,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomId: json['room_id'],
        roomQty: json['room_qty'],
      );
  String? roomId;
  String? roomQty;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'room_id': roomId,
        'room_qty': roomQty,
      };
}

class Food {
  Food({
    this.foodId,
    this.foodQty,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        foodId: json['room_id'],
        foodQty: json['room_qty'],
      );
  String? foodId;
  String? foodQty;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'food_id': foodId,
        'food_qty': foodQty,
      };
}

class Vehicle {
  Vehicle({
    this.vehicleId,
    this.vehicleQty,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        vehicleId: json['vehicle_id'],
        vehicleQty: json['vehicle_qty'],
      );
  String? vehicleId;
  String? vehicleQty;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'vehicle_id': vehicleId,
        'vehicle_qty': vehicleQty,
      };
}
