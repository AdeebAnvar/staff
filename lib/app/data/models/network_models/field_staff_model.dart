class FieldStaffBookingModel {
  FieldStaffBookingModel(
      {this.bookingId,
      this.userName,
      this.bookingDate,
      this.customerName,
      this.travelItinerary});
  String? bookingId;
  String? userName;
  String? bookingDate;
  String? customerName;
  String? travelItinerary;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'booking_id': bookingId,
        'user_name': userName,
        'booking_date': bookingDate,
        'customer_name': customerName,
        'travel_itinerary': travelItinerary,
      };

  static FieldStaffBookingModel fromJson(Map<String, dynamic> json) =>
      FieldStaffBookingModel(
        bookingId:
            json['booking_id'] == null ? '' : json['booking_id'] as String,
        userName: json['user_name'] == null ? '' : json['user_name'] as String,
        bookingDate:
            json['booking_date'] == null ? '' : json['booking_date'] as String,
        customerName: json['customer_name'] == null
            ? ''
            : json['customer_name'] as String,
        travelItinerary: json['travel_itinerary'] == null
            ? ''
            : json['customer_name'] as String,
      );
}
