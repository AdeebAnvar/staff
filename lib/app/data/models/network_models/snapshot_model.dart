class SnapShotModel {
  SnapShotModel(
      {this.tourId,
      this.startDate,
      this.endDate,
      this.day,
      this.night,
      this.adult,
      this.customerId,
      this.kid,
      this.infant,
      this.shotId,
      this.created,
      this.data});
  List<String>? tourId;
  String? startDate;
  String? endDate;
  int? day;
  int? night;
  int? adult;
  int? customerId;
  int? kid;
  int? infant;
  List<ItinerarySnapshotsData>? data;
  String? shotId;
  String? created;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'tour_id': tourId,
        'start_date': startDate,
        'end_date': endDate,
        'day': day,
        'night': night,
        'adult': adult,
        'customer_id': customerId,
        'kid': kid,
        'infant': infant,
        'data': data!.map((ItinerarySnapshotsData v) => v.toJson()).toList(),
      };
  static SnapShotModel fromJson(Map<String, dynamic> json) => SnapShotModel(
        shotId: json['shot_id'] as String,
        startDate: json['start_date'] as String,
        endDate: json['end_date'] as String,
        day: json['day'] as int,
        night: json['night'] as int,
        adult: json['adult'] as int,
        customerId: json['customer_id'] as int,
        kid: json['kid'] as int,
        infant: json['infant'] as int,
        data: json['data'] != null
            ? (json['data'] as List<dynamic>)
                .map((dynamic e) =>
                    ItinerarySnapshotsData.fromJson(e as Map<String, dynamic>))
                .toList()
            : <ItinerarySnapshotsData>[],
        created: json['created'] as String,
        tourId: json['tour_id'] as List<String>,
      );
}

class ItinerarySnapshotsData {
  ItinerarySnapshotsData(
      {this.placeId,
      this.addons,
      this.activity,
      this.vehicle,
      this.room,
      this.food});
  String? placeId;
  List<int>? addons;
  List<int>? activity;
  List<int>? vehicle;
  List<int>? room;
  List<int>? food;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'place_id': placeId,
        'addons': addons,
        'activity': activity,
        'vehicle': vehicle,
        'room': room,
        'food': food,
      };
  static ItinerarySnapshotsData fromJson(Map<String, dynamic> json) =>
      ItinerarySnapshotsData(
        placeId: json['place_id'] as String,
        addons: json['addons'] as List<int>,
        activity: json['activity'] as List<int>,
        vehicle: json['vehicle'] as List<int>,
        room: json['room'] as List<int>,
        food: json['food'] as List<int>,
      );
}
