class FieldStaffSingleBookingModel {
  FieldStaffSingleBookingModel({
    this.result,
    this.success,
  });
  List<List<Result>>? result;
  bool? success;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': List<dynamic>.from(result!.map((List<Result> x) =>
            List<dynamic>.from(x.map((Result x) => x.toJson())))),
        'success': success,
      };
  static FieldStaffSingleBookingModel fromJson(Map<String, dynamic> json) {
    final List<List<Result>> result =
        (json['result'] as List<dynamic>).map((dynamic x) {
      return (x as List<dynamic>).map((dynamic subResult) {
        return Result.fromJson(subResult as Map<String, dynamic>);
      }).toList();
    }).toList();

    return FieldStaffSingleBookingModel(
      result: result,
      success: json['success'] as bool,
    );
  }
}

class Result {
  Result({
    required this.taskId,
    required this.task,
    required this.status,
    required this.reason,
    required this.dayId,
    required this.imageKey,
  });
  String taskId;
  String task;
  String status;
  dynamic reason;
  String dayId;
  dynamic imageKey;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'task_id': taskId,
        'task': task,
        'status': status,
        'reason': reason,
        'day_id': dayId,
        'image_key': imageKey,
      };
  static Result fromJson(Map<String, dynamic> json) => Result(
        taskId: json['task_id'] == null ? '' : json['task_id'] as String,
        task: json['task'] == null ? '' : json['task'] as String,
        status: json['status'] == null ? '' : json['status'] as String,
        reason: json['reason'] == null ? '' : json['reason'] as String,
        dayId: json['day_id'] == null ? '' : json['day_id'] as String,
        imageKey: json['image_key'],
      );
}
