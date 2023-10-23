class BookingsModel {
  BookingsModel(
      {this.bookingDate, this.tourName, this.customerId, this.points});
  String? bookingDate;
  String? tourName;
  String? customerId;
  int? points;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'booking_date': bookingDate,
        'tour_name': tourName,
        'customer_id': customerId,
        'points': points,
      };

  static BookingsModel fromJson(Map<String, dynamic> json) => BookingsModel(
        bookingDate: json['booking_date'] as String,
        tourName: json['tour_name'] as String,
        customerId: json['customer_id'] as String,
        points: json['points'] as int,
      );
}
