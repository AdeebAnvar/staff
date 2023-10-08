class LeaveStatusModel {
  LeaveStatusModel(
      {this.leaveId,
      this.userId,
      this.applyDate,
      this.comebackDate,
      this.reason,
      this.depId,
      this.branchId,
      this.status});
  String? leaveId;
  String? userId;
  String? applyDate;
  String? comebackDate;
  String? reason;
  String? depId;
  String? branchId;
  String? status;

  static LeaveStatusModel fromJson(Map<String, dynamic> json) =>
      LeaveStatusModel(
        leaveId: json['leave_id'] == null ? '' : json['leave_id'] as String,
        userId: json['user_id'] == null ? '' : json['user_id'] as String,
        applyDate:
            json['apply_date'] == null ? '' : json['apply_date'] as String,
        comebackDate: json['comeback_date'] == null
            ? ''
            : json['comeback_date'] as String,
        reason: json['reason'] == null ? '' : json['reason'] as String,
        depId: json['dep_id'] == null ? '' : json['dep_id'] as String,
        branchId: json['branch_id'] == null ? '' : json['branch_id'] as String,
        status: json['status'] == null ? '' : json['status'] as String,
      );
}
