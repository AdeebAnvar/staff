class PlacesModel {
  PlacesModel({this.placeId, this.placeName, this.placeDes, this.tourId});
  String? placeId;
  String? placeName;
  String? placeDes;
  String? tourId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'place_id': placeId,
        'place_name': placeName,
        'place_des': placeDes,
        'tour_id': tourId,
      };

  static PlacesModel fromJson(Map<String, dynamic> json) => PlacesModel(
        placeId: json['place_id'] as String,
        placeName: json['place_name'] as String,
        placeDes: json['place_des'] as String,
        tourId: json['tour_id'] as String,
      );
}
