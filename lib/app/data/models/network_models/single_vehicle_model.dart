class SingleVehicleModel {
  SingleVehicleModel(
      {this.vehicleId,
      this.tourId,
      this.vehicleName,
      this.vehicleCategory,
      this.pickupPrice,
      this.dropoffPrice,
      this.categoryName,
      this.daytourPrice,
      this.catId,
      this.addonPrice});
  String? vehicleId;
  String? tourId;
  String? vehicleName;
  String? vehicleCategory;
  String? pickupPrice;
  String? dropoffPrice;
  String? daytourPrice;
  String? addonPrice;
  String? categoryName;
  String? catId;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'vehicle_id': vehicleId,
        'tour_id': tourId,
        'vehicle_name': vehicleName,
        'vehicle_category': vehicleCategory,
        'cat_id': catId,
        'cat_name': categoryName
      };

  static SingleVehicleModel fromJson(Map<String, dynamic> json) =>
      SingleVehicleModel(
        vehicleId: json['vehicle_id'] as String,
        tourId: json['tour_id'] as String,
        vehicleName: json['vehicle_name'] as String,
        vehicleCategory: json['vehicle_category'] as String,
        categoryName: json['cat_name'] as String,
        catId: json['cat_id'] as String,
      );
}
