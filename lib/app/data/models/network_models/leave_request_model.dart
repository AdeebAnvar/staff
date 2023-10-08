class LeaveRequestModel {
  LeaveRequestModel({
    this.reason,
    this.applyDate,
    this.deptId,
    this.branchId,
    this.returnDate,
  });
  String? reason;
  String? applyDate;
  String? returnDate;
  String? deptId;
  String? branchId;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'reason': reason,
        'apply_date': applyDate,
        'return_date': returnDate,
        'dep_id': deptId,
        'branch_id': branchId,
      };
}
