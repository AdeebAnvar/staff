class TourModel {
  TourModel(
      {this.tourId,
      this.depId,
      this.tourName,
      this.tourDes,
      this.tourCode,
      // this.pdfLink,
      this.tourPdf});
  String? tourId;
  String? depId;
  String? tourName;
  String? tourDes;
  String? tourCode;
  String? tourPdf;
  // String? pdfLink;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'tour_id': tourId,
        'dep_id': depId,
        'tour_name': tourName,
        'tour_des': tourDes,
        'tour_code': tourCode,
        'tour_pdf': tourPdf,
        // 'pdf_link': pdfLink,
      };

  static TourModel fromJson(Map<String, dynamic> json) => TourModel(
        tourId: json['tour_id'] == null ? '' : json['tour_id'] as String,
        depId: json['dep_id'] == null ? '' : json['dep_id'] as String,
        tourName: json['tour_name'] == null ? '' : json['tour_name'] as String,
        tourDes: json['tour_des'] == null ? '' : json['tour_des'] as String,
        tourCode: json['tour_code'] == null ? '' : json['tour_code'] as String,
        tourPdf: json['tour_pdf'] == null
            ? ''
            : json['tour_pdf'] == null
                ? ''
                : json['tour_pdf'] as String,
        // pdfLink: json['pdf_link'] == null ? '' : json['pdf_link'] as String,
      );
}
