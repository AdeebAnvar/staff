class TeleCallerModel {
  TeleCallerModel(
      {this.userId,
      this.userName,
      this.profileKey,
      this.userType,
      this.userEmail,
      this.registered,
      this.depId,
      this.branchId,
      this.depName,
      this.depImage,
      this.branchName,
      this.depColor,
      this.userCode,
      this.profileImage});
  String? userId;
  String? userName;
  String? profileKey;
  String? userType;
  String? userEmail;
  bool? registered;
  String? depId;
  String? branchId;
  String? depName;
  String? depImage;
  String? branchName;
  String? depColor;
  String? profileImage;
  String? userCode;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_id': userId,
        'user_code': userCode,
        'user_name': userName,
        'profile_key': profileKey,
        'user_type': userType,
        'user_email': userEmail,
        'registered': registered,
        'dep_id': depId,
        'branch_id': branchId,
        'dep_name': depName,
        'dep_image': depImage,
        'branch_name': branchName,
        'profile_image': profileImage,
        'dep_color': depColor,
      };

  static TeleCallerModel fromJson(Map<String, dynamic> json) => TeleCallerModel(
      userId: json['user_id'] == null ? '' : json['user_id'] as String,
      userCode: json['user_code'] == null ? '' : json['user_code'] as String,
      userName: json['user_name'] == null ? '' : json['user_name'] as String,
      profileKey:
          json['profile_key'] == null ? '' : json['profile_key'] as String,
      userType: json['user_type'] == null ? '' : json['user_type'] as String,
      userEmail: json['user_email'] == null ? '' : json['user_email'] as String,
      registered:
          // ignore: avoid_bool_literals_in_conditional_expressions
          json['registered'] == null ? false : json['registered'] as bool,
      depId: json['dep_id'] == null ? '' : json['dep_id'] as String,
      branchId: json['branch_id'] == null ? '' : json['branch_id'] as String,
      depName: json['dep_name'] == null ? '' : json['dep_name'] as String,
      depImage: json['dep_image'] == null ? '' : json['dep_image'] as String,
      branchName:
          json['branch_name'] == null ? '' : json['branch_name'] as String,
      profileImage:
          json['profile_image'] == null ? '' : json['profile_image'] as String,
      depColor: json['dep_color'] == null ? '' : json['dep_color'] as String);
}
