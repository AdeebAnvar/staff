class ItineraryModel {
  ItineraryModel({
    this.tourPdf,
    this.pdfLink,
  });
  String? tourPdf;
  String? pdfLink;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tour_pdf': tourPdf,
        'pdf_link': pdfLink,
      };

  static ItineraryModel fromJson(Map<String, dynamic> json) => ItineraryModel(
        tourPdf: json['tour_pdf'] == null ? '' : json['tour_pdf'] as String,
        pdfLink: json['pdf_link'] == null ? '' : json['pdf_link'] as String,
      );
}
