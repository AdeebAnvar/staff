class CustomerSnapshotModel {
  CustomerSnapshotModel({this.created, this.tourIds, this.shotId});
  String? created;
  String? shotId;
  List<dynamic>? tourIds;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'created': created,
        'shot_id': shotId,
        'tour_id': tourIds,
      };

  static CustomerSnapshotModel fromJson(Map<String, dynamic> json) =>
      CustomerSnapshotModel(
        created: json['created'] as String,
        shotId: json['shot_id'] as String,
        tourIds: json['tour_id'] as List<dynamic>,
      );
}
