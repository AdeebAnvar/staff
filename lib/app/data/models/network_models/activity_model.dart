class ActivityModel {
  ActivityModel(
      {this.activityId,
      this.activityName,
      this.activityDes,
      this.placeId,
      this.activityPrice});
  String? activityId;
  String? activityName;
  String? activityDes;
  String? placeId;
  num? activityPrice;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'activity_id': activityId,
        'activity_name': activityName,
        'activity_des': activityDes,
        'place_id': placeId,
        'activity_price': activityPrice,
      };

  static ActivityModel fromJson(Map<String, dynamic> json) => ActivityModel(
        activityId: json['activity_id'] as String,
        activityName: json['activity_name'] as String,
        activityDes: json['activity_des'] as String,
        placeId: json['place_id'] as String,
        activityPrice: json['activity_price'] as num,
      );
}
