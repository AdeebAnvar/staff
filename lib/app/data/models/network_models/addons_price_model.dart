class AddonPriceModel {
  AddonPriceModel(
      {this.priceId,
      this.addonId,
      this.vehicleId,
      this.price,
      this.addonIds,
      this.vehicleIds});
  String? priceId;
  String? addonId;
  String? vehicleId;
  List<String>? vehicleIds;
  List<String>? addonIds;
  num? price;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'addon_id': addonIds,
        'vehicle_id': vehicleIds,
      };
  static AddonPriceModel fromJson(Map<String, dynamic> json) => AddonPriceModel(
        priceId: json['price_id'] as String,
        addonId: json['addon_id'] as String,
        vehicleId: json['vehicle_id'] as String,
        price: json['price'] as num,
      );
}
