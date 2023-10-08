class SendTaskData {
  SendTaskData({
    this.customerId,
    this.amountPayable,
    this.advanceAmount,
    this.tasks,
    this.bookables,
    this.tourId,
    this.startDate,
    this.endDate,
    this.depId,
    this.branchId,
  });

  int? customerId;
  int? amountPayable;
  int? advanceAmount;
  List<List<String>>? tasks;
  List<String>? bookables;
  int? tourId;
  String? startDate;
  String? endDate;
  int? depId;
  int? branchId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'customer_id': customerId,
      'amount_payable': amountPayable,
      'advance_amount': advanceAmount,
      'bookables': bookables,
      'tour_id': tourId,
      'start_date': startDate,
      'end_date': endDate,
      'dep_id': depId,
      'branch_id': branchId,
    };

    if (tasks != null) {
      data['tasks'] = tasks!.map((List<String> v) => v.toList()).toList();
    }

    return data;
  }
}
