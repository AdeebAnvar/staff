import 'dart:io';

class ResponseModel {
  ResponseModel({
    this.audio,
    this.responseText,
    this.customeID,
    this.customerProgress,
    this.followUpDate,
    this.leadID,
  });
  File? audio;
  String? responseText;
  String? followUpDate;
  String? customeID;
  String? leadID;
  String? customerProgress;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'audio': audio,
        'response_text': responseText,
        'customer_id': customeID,
        'lead_id': leadID,
        'customer_progress': customerProgress
      };
}
