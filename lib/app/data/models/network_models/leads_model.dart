// ignore_for_file: avoid_bool_literals_in_conditional_expressions

class LeadsModel {
  LeadsModel(
      {this.customerId,
      this.customerName,
      this.customerPhone,
      this.customerWhatsapp,
      this.customerVehicle,
      this.customerProgress,
      this.customerPax,
      this.customerSource,
      this.customerAddress,
      this.customerCategory,
      this.customerRemarks,
      this.customerCity,
      this.depId,
      this.branchId,
      this.userId,
      this.assigned,
      this.tourCode,
      this.leadId,
      this.followUp,
      this.followUpDate});
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? customerWhatsapp;
  String? customerVehicle;
  String? customerProgress;
  int? customerPax;
  String? customerSource;
  String? customerAddress;
  String? customerCategory;
  String? customerRemarks;
  String? customerCity;
  String? depId;
  String? branchId;
  String? userId;
  bool? assigned;
  String? tourCode;
  String? leadId;
  bool? followUp;
  String? followUpDate;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'customer_id': customerId,
        'follow_up': followUp,
        'follow_up_date': followUpDate,
        'customer_name': customerName,
        'customer_phone': customerPhone,
        'customer_whatsapp': customerWhatsapp,
        'customer_vehicle': customerVehicle,
        'customer_progress': customerProgress,
        'customer_pax': customerPax,
        'customer_source': customerSource,
        'customer_address': customerAddress,
        'customer_category': customerCategory,
        'customer_remarks': customerRemarks,
        'customer_city': customerCity,
        'dep_id': depId,
        'branch_id': branchId,
        'user_id': userId,
        'assigned': assigned,
        'tour_code': tourCode,
        'lead_id': leadId,
      };

  static LeadsModel fromJson(Map<String, dynamic> json) => LeadsModel(
      customerId:
          json['customer_id'] == null ? '' : json['customer_id'] as String,
      customerName:
          json['customer_name'] == null ? '' : json['customer_name'] as String,
      customerPhone: json['customer_phone'] == null
          ? ''
          : json['customer_phone'] as String,
      customerWhatsapp: json['customer_whatsapp'] == null
          ? ''
          : json['customer_whatsapp'] as String,
      customerVehicle: json['customer_vehicle'] == null
          ? ''
          : json['customer_vehicle'] as String,
      customerProgress: json['customer_progress'] == null
          ? ''
          : json['customer_progress'] as String,
      customerPax:
          json['customer_pax'] == null ? 0 : json['customer_pax'] as int,
      customerSource: json['customer_source'] == null
          ? ''
          : json['customer_source'] as String,
      customerAddress: json['customer_address'] == null
          ? ''
          : json['customer_address'] as String,
      customerCategory: json['customer_category'] == null
          ? ''
          : json['customer_category'] as String,
      customerRemarks: json['customer_remarks'] == null
          ? ''
          : json['customer_remarks'] as String,
      customerCity:
          json['customer_city'] == null ? '' : json['customer_city'] as String,
      depId: json['dep_id'] == null ? '' : json['dep_id'] as String,
      branchId: json['branch_id'] == null ? '' : json['branch_id'] as String,
      userId: json['user_id'] == null ? '' : json['user_id'] as String,
      assigned: json['assigned'] == null ? false : json['assigned'] as bool,
      tourCode: json['tour_code'] == null ? '' : json['tour_code'] as String,
      leadId: json['lead_id'] == null ? '' : json['lead_id'] as String,
      followUp: json['follow_up'] == null ? false : json['follow_up'] as bool,
      followUpDate: json['follow_up_date'] == null
          ? ''
          : json['follow_up_date'] as String);
}
