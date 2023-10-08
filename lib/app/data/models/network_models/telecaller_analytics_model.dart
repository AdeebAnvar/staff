class TeleCallerAnalytics {
  TeleCallerAnalytics({
    this.calls,
    this.followUps,
    this.points,
    this.bookings,
    this.targetPoints,
  });
  int? calls;
  int? followUps;
  int? points;
  int? targetPoints;
  int? bookings;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'calls': calls,
        'follow_ups': followUps,
        'points': points,
        'target_points': targetPoints,
        'bookings': bookings,
      };
  static TeleCallerAnalytics fromJson(Map<String, dynamic> json) =>
      TeleCallerAnalytics(
        calls: json['calls'] == null ? 0 : json['calls'] as int,
        followUps: json['follow_ups'] == null ? 0 : json['follow_ups'] as int,
        points: json['points'] == null ? 0 : json['points'] as int,
        targetPoints:
            json['target_points'] == null ? 0 : json['target_points'] as int,
        bookings: json['bookings'] == null ? 0 : json['bookings'] as int,
      );
}
