class FieldStaffBookingModel {
  FieldStaffBookingModel(
      {this.bookingId,
      this.bookingDate,
      this.customerName,
      this.startDate,
      this.endDate});
  String? bookingId;
  String? bookingDate;
  String? customerName;
  String? startDate;
  String? endDate;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'booking_id': bookingId,
        'booking_date': bookingDate,
        'customer_name': customerName,
        'start_date': startDate,
        'end_date': endDate
      };

  static FieldStaffBookingModel fromJson(Map<String, dynamic> json) =>
      FieldStaffBookingModel(
        bookingId:
            json['booking_id'] == null ? '' : json['booking_id'] as String,
        bookingDate:
            json['booking_date'] == null ? '' : json['booking_date'] as String,
        customerName: json['customer_name'] == null
            ? ''
            : json['customer_name'] as String,
        startDate:
            json['start_date'] == null ? ' ' : json['start_date'] as String,
        endDate: json['end_date'] == null ? ' ' : json['end_date'] as String,
      );
}
