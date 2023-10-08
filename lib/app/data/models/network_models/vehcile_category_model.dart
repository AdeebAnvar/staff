class VehcileCategoryModel {
  VehcileCategoryModel({this.catId, this.catName});
  String? catId;
  String? catName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cat_id': catId,
        'cat_name': catName,
      };
  static VehcileCategoryModel fromJson(Map<String, dynamic> json) =>
      VehcileCategoryModel(
        catId: json['cat_id'] as String,
        catName: json['cat_name'] as String,
      );
}
