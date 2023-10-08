class RoomsCheckingModel {
  RoomsCheckingModel(
      {this.roomId,
      this.tourId,
      this.roomNumber,
      this.roomBuilding,
      this.roomPrice,
      this.roomCategory,
      this.roomCategories,
      this.roomTypes,
      this.roomType});
  String? roomId;
  String? tourId;
  int? roomNumber;
  String? roomBuilding;
  String? roomPrice;
  String? roomCategory;
  String? roomType;
  List<int>? roomCategories;
  List<String>? roomTypes;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tour_id': tourId,
        'room_category': roomCategories,
        'room_type': roomTypes,
      };

  static RoomsCheckingModel fromJson(Map<String, dynamic> json) =>
      RoomsCheckingModel(
        roomId: json['room_id'] as String,
        tourId: json['tour_id'] as String,
        roomNumber: json['room_number'] as int,
        roomBuilding: json['room_building'] as String,
        roomPrice: json['room_price'] as String,
        roomCategory: json['room_category'] as String,
        roomType: json['room_type'] as String,
      );
}
