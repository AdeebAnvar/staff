class RoomCategoryModel {
  RoomCategoryModel({this.catId, this.catName});
  String? catId;
  String? catName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cat_id': catId,
        'cat_name': catName,
      };
  static RoomCategoryModel fromJson(Map<String, dynamic> json) =>
      RoomCategoryModel(
        catId: json['cat_id'] as String,
        catName: json['cat_name'] as String,
      );
}
