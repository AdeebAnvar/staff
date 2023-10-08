class AddonsModel {
  AddonsModel({this.addonId, this.addonName, this.addonDes, this.placeId});
  String? addonId;
  String? addonName;
  String? addonDes;
  String? placeId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'addon_id': addonId,
        'addon_name': addonName,
        'addon_des': addonDes,
        'place_id': placeId,
      };
  static AddonsModel fromJson(Map<String, dynamic> json) => AddonsModel(
        addonId: json['addon_id'] as String,
        addonName: json['addon_name'] as String,
        addonDes: json['addon_des'] as String,
        placeId: json['place_id'] as String,
      );
}
