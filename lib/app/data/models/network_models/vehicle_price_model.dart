class VehiclePriceModel {
  VehiclePriceModel(
      {this.priceId,
      this.placeId,
      this.vehicleId,
      this.price,
      this.vehicleIds});
  String? priceId;
  String? placeId;
  String? vehicleId;
  List<String>? vehicleIds;
  num? price;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'place_id': placeId,
        'vehicle_id': vehicleIds,
      };
  static VehiclePriceModel fromJson(Map<String, dynamic> json) =>
      VehiclePriceModel(
        priceId: json['price_id'] as String,
        placeId: json['place_id'] as String,
        vehicleId: json['vehicle_id'] as String,
        price: json['price'] as num,
      );
}
