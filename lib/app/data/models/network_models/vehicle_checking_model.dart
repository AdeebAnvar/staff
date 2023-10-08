class VehicleCheckingModel {
  VehicleCheckingModel(
      {this.vehicleId,
      this.tourId,
      this.vehicleName,
      this.vehicleCategory,
      this.pickupPrice,
      this.dropoffPrice,
      this.daytourPrice,
      this.addonPrice});
  String? vehicleId;
  String? tourId;
  String? vehicleName;
  List<String>? vehicleCategory;
  String? pickupPrice;
  String? dropoffPrice;
  String? daytourPrice;
  String? addonPrice;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tour_id': tourId,
        'vehicle_category': vehicleCategory,
      };

  static VehicleCheckingModel fromJson(Map<String, dynamic> json) =>
      VehicleCheckingModel(
        vehicleId: json['vehicle_id'] as String,
        tourId: json['tour_id'] as String,
        vehicleName: json['vehicle_name'] as String,
        vehicleCategory: json['vehicle_category'] as List<String>,
        pickupPrice: json['pickup_price'] as String,
        dropoffPrice: json['dropoff_price'] as String,
        daytourPrice: json['daytour_price'] as String,
        addonPrice: json['addon_price'] as String,
      );
}
