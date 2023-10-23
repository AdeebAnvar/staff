class LeadResponseModel {
  LeadResponseModel(
      {this.responseId,
      this.customerId,
      this.responseText,
      this.responseKey,
      this.callDate,
      this.userId,
      this.userName,
      this.userType,
      this.userEmail,
      this.depId,
      this.branchId,
      this.registered,
      this.userPhone,
      this.profileKey,
      this.points,
      this.targetPoints,
      this.url});
  String? responseId;
  String? customerId;
  String? responseText;
  String? responseKey;
  String? callDate;
  String? userId;
  String? userName;
  String? userType;
  String? userEmail;
  String? depId;
  String? branchId;
  bool? registered;
  String? userPhone;
  String? profileKey;
  int? points;
  int? targetPoints;
  String? url;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'response_id': responseId,
        'customer_id': customerId,
        'response_text': responseText,
        'response_key': responseKey,
        'call_date': callDate,
        'user_id': userId,
        'user_name': userName,
        'user_type': userType,
        'user_email': userEmail,
        'dep_id': depId,
        'branch_id': branchId,
        'registered': registered,
        'user_phone': userPhone,
        'profile_key': profileKey,
        'points': points,
        'target_points': targetPoints,
        'url': url,
      };

  static LeadResponseModel fromJson(Map<String, dynamic> json) =>
      LeadResponseModel(
        userName: json['user_name'] == null ? '' : json['user_name'] as String,
        responseText: json['response_text'] == null
            ? ''
            : json['response_text'] as String,
        callDate: json['call_date'] == null ? '' : json['call_date'] as String,
      );
}
