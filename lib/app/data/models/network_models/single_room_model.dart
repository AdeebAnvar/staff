class SingleRoomModel {
  SingleRoomModel(
      {this.roomId,
      this.tourId,
      this.roomNumber,
      this.roomBuilding,
      this.roomPrice,
      this.roomType,
      this.categoryName,
      this.roomCategory});
  String? roomId;
  String? tourId;
  int? roomNumber;
  String? roomBuilding;
  String? roomPrice;
  String? roomCategory;
  String? roomType;
  String? categoryName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'room_id': roomId,
        'tour_id': tourId,
        'cat_name': categoryName,
        'room_number': roomNumber,
        'room_building': roomBuilding,
        'room_price': roomPrice,
        'room_category': roomCategory,
        'room_type': roomType,
      };
  static SingleRoomModel fromJson(Map<String, dynamic> json) => SingleRoomModel(
        roomId: json['room_id'] as String,
        tourId: json['tour_id'] as String,
        categoryName: json['cat_name'] as String,
        roomNumber: json['room_number'] as int,
        roomBuilding: json['room_building'] as String,
        roomPrice: json['room_price'] as String,
        roomCategory: json['room_category'] as String,
        roomType: json['room_type'] as String,
      );
}

class RoomTypesModel {
  RoomTypesModel({this.tourIds, this.catIds, this.roomTypes});
  List<String>? tourIds;
  List<String>? catIds;
  List<String>? roomTypes;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'tour': tourIds,
        'cat': catIds,
      };
}
