class FieldStaffSingleBookingModel {
  String? taskId;
  String? task;
  String? status;
  String? reason;
  String? dayId;
  String? imageKey;

  FieldStaffSingleBookingModel(
      {this.taskId,
      this.task,
      this.status,
      this.reason,
      this.dayId,
      this.imageKey});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'task_id': taskId,
        'task': task,
        'status': status,
        'reason': reason,
        'day_id': dayId,
        'image_key': imageKey,
      };

  static FieldStaffSingleBookingModel fromJson(Map<String, dynamic> json) =>
      FieldStaffSingleBookingModel(
        taskId: json['task_id'] == null ? '' : json['task_id'] as String,
        task: json['task'] == null ? '' : json['task'] as String,
        status: json['status'] == null ? '' : json['status'] as String,
        reason: json['reason'] == null ? '' : json['reason'] as String,
        dayId: json['day_id'] == null ? '' : json['day_id'] as String,
        imageKey: json['image_key'] == null ? '' : json['image_key'] as String,
      );
}
