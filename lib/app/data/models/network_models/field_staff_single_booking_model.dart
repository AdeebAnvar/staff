class FieldStaffSingleBookingModel {
  FieldStaffSingleBookingModel(
      {this.bookingId,
      this.userName,
      this.bookingDate,
      this.customerName,
      this.amountPaid,
      this.amountPayable,
      this.travelItinerary});
  String? bookingId;
  String? userName;
  String? bookingDate;
  String? customerName;
  String? amountPaid;
  String? amountPayable;
  String? travelItinerary;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'booking_id': bookingId,
        'user_name': userName,
        'booking_date': bookingDate,
        'customer_name': customerName,
        'amount_paid': amountPaid,
        'amount_payable': amountPayable,
        'travel_itinerary': travelItinerary,
      };

  static FieldStaffSingleBookingModel fromJson(Map<String, dynamic> json) =>
      FieldStaffSingleBookingModel(
        bookingId:
            json['booking_id'] == null ? '' : json['booking_id'] as String,
        userName: json['user_name'] == null ? '' : json['user_name'] as String,
        bookingDate:
            json['booking_date'] == null ? '' : json['booking_date'] as String,
        customerName: json['customer_name'] == null
            ? ''
            : json['customer_name'] as String,
        amountPaid:
            json['amount_paid'] == null ? '' : json['amount_paid'] as String,
        amountPayable: json['amount_payable'] == null
            ? ''
            : json['amount_payable'] as String,
        travelItinerary: json['travel_itinerary'] == null
            ? ''
            : json['travel_itinerary'] as String,
      );
}
