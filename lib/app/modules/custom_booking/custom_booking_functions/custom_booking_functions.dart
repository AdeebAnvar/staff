import 'dart:developer';
import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../controllers/custom_booking_controller.dart';

void createPdf(
    pw.Document pdf, String imageUrl, CustomBookingController controller) {
  final pw.MemoryImage image = pw.MemoryImage(File(imageUrl).readAsBytesSync());
  try {
    return pdf.addPage(
      pw.MultiPage(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        header: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Container(
                width: 100,
                height: 80,
                child: pw.Image(
                  height: 40,
                  image,
                  fit: pw.BoxFit.cover,
                ),
              ),
              pw.Divider(thickness: 2, color: PdfColors.grey),
              pw.SizedBox(height: 15)
            ],
          );
        },
        margin: const pw.EdgeInsets.symmetric(vertical: 30, horizontal: 25),
        pageFormat: PdfPageFormat.a3,
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.white)),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: <pw.Widget>[
                  pw.Column(
                    children: <pw.Widget>[
                      pw.Text(
                        controller.selectedTourWithoutTransit.value,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      pw.Text(
                        '${controller.days}D|${controller.nights}N',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (controller.isProposal.value)
              pw.Paragraph(
                text:
                    '*Note : This is just a referral itinerary Upon confirmation, please get in touch with our executive and ask for your itinerary confirmation. The itinerary here is not valid for your tour.',
                style: pw.TextStyle(
                    color: PdfColors.red900,
                    fontSize: 15,
                    letterSpacing: 2,
                    lineSpacing: 3,
                    fontWeight: pw.FontWeight.bold),
              ),
            if (controller.isProposal.value)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: <pw.Widget>[
                  pw.Paragraph(
                    text: '''
*Note : This itinerary is only valid upto 5 days from ${DateTime.now().toDatewithMonthFormat()}''',
                    style: pw.TextStyle(
                        color: PdfColors.red900,
                        fontSize: 15,
                        letterSpacing: 2,
                        lineSpacing: 3,
                        fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
            if (controller.isProposal.value != true)
              pw.Header(
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.white)),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Text('CONFIRM ITINERARY',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 28))
                  ],
                ),
              ),
            pw.ListView.builder(
              itemCount: controller.days.value,
              itemBuilder: (pw.Context context, int dayIndex) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Header(
                      textStyle: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 24,
                      ),
                      child: pw.Text(
                        'Day ${dayIndex + 1}',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 27),
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Paragraph(
                        text: controller.itineraryString['Day ${dayIndex + 1}'],
                        style:
                            const pw.TextStyle(fontSize: 17, lineSpacing: 6)),
                  ],
                );
              },
            ),
            pw.NewPage(),
            pw.Paragraph(
                text: 'Inclusions',
                style: pw.TextStyle(
                    fontSize: 17,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline)),
            pw.Paragraph(
                text:
                    'Pickup drop off\nAll local transport\nSightseeing\nAccomodation',
                style: const pw.TextStyle(fontSize: 16)),
            pw.Paragraph(
                text: 'HDFC BANK',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 17)),
            pw.Paragraph(
                text:
                    'Account Holder:TRIPPENS\nAccount Number:50200065078880\nBranch:TRICHUR-PALACE ROAD',
                style: const pw.TextStyle(
                    fontSize: 15,
                    lineSpacing: 2,
                    wordSpacing: 2,
                    letterSpacing: 2)),
            pw.Paragraph(
              text: 'PAYMENT POLICY - ',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15),
            ),
            pw.Paragraph(
                text:
                    '> A minimum payment is required for booking a tour - Non refundable',
                style: const pw.TextStyle(
                  fontSize: 15,
                  lineSpacing: 2,
                )),
            pw.Paragraph(
              text: '(The minimum payment will vary depending on the tour)',
              style: const pw.TextStyle(
                color: PdfColors.red900,
                fontSize: 15,
                lineSpacing: 2,
              ),
            ),
            pw.Paragraph(
                text:
                    '> 21-35 Days before date of departure : 50% of Cost \n 20 Days before date of departure : 100% of Total cost',
                style: const pw.TextStyle(
                  fontSize: 15,
                  lineSpacing: 2,
                )),
            pw.SizedBox(height: 15),
            pw.Paragraph(
                text: 'CANCELLATION AND REFUND POLICY  - ',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
            pw.Paragraph(
                text: '''
> 60 Days & Prior to Arrival POLICY - 25% of the Tour/Service Cost.
> 59 Days to 30 Days Prior To Arrival - 50% of the Tour/Service Cost.
> 29 Days to 15 Days Prior To Arrival - 75% of the Tour/Service Cost.
> 14 Days and less Prior To Arrival - No refund
> Transportation and accommodation are as per itinerary only, if you have to change any of the
same we will not be responsible for any kind of refund.
> There will be no refund for add-ons.
''',
                style: const pw.TextStyle(
                  fontSize: 15,
                  lineSpacing: 2,
                )),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: <pw.Widget>[
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: <pw.Widget>[
                      pw.Text('Customer name : ${controller.customerName}',
                          style: pw.TextStyle(
                              decorationThickness: 20,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 3),
                      pw.Text('Customer Id : ${controller.cid}',
                          style: pw.TextStyle(
                              decorationThickness: 20,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 3),
                      pw.Text(
                          'Tour date : ${controller.tourStartingDateTime.toString().parseFrom24Hours().toDatewithMonthFormat()}',
                          style: pw.TextStyle(
                              decorationThickness: 20,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 3),
                      pw.Text('Adult (above 5 years):${controller.adults} ',
                          style: pw.TextStyle(
                              fontSize: 10,
                              decorationThickness: 20,
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 3),
                      if (controller.kids.value != null &&
                          controller.kids.value != 0)
                        pw.Text('kids :${controller.kids} ',
                            style: pw.TextStyle(
                                fontSize: 10,
                                decorationThickness: 20,
                                fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 3),
                      if (controller.infants.value != null &&
                          controller.infants.value != 0)
                        pw.Text('infants :${controller.infants} ',
                            style: pw.TextStyle(
                                fontSize: 10,
                                decorationThickness: 20,
                                fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 3),
                      pw.Text(
                          'Executive name : ${controller.telecaCaller.userName}',
                          style: pw.TextStyle(
                              decorationThickness: 20,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text('Package Rate : ${controller.price} /pax',
                          style: pw.TextStyle(
                              decorationThickness: 20,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                          'Advance amount : ${controller.advAmount.value + controller.extraAdvAmount.value} /pax',
                          style: pw.TextStyle(
                              decorationThickness: 20,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold)),
                    ])
              ],
            ),
            pw.SizedBox(height: 20),
            pw.NewPage(),
            pw.Paragraph(
                text: 'TERMS AND CONDITIONS',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
            pw.Paragraph(text: '''
1. if you're not able to reach out the destination on time. That is not our responsibility
2. Hotel Check in time - 11.30 a.m. & checkout - 10.00 am.
3. The booking stands liable to be cancelled if 100% payment is not received less than 20 days before
date of departure. If the trip is cancel due to this reason advance will not be refundable. If you are
not pay the amount that in mentioned in payment policy then tour will be cancel.
4. There is no refund option in case you cancel the tour yourself.
5. All activities which are not mentioned in the above itinerary such as visiting additional spots or
involving in paid activities, If arranging separate cab etc. is not included in this.
6. In case of using additional transport will be chargeable.
7. All transport on the tour will be grouped together. Anyone who deviates from it will be excluded
from this package.
8. The company has the right for expelling persons who disagree with passengers or misrepresent
the company during the trip.
9. The company does not allow passengers to give tips to the driver for going additional spots.
10. In case of cancellation due to any reason such as Covid, strike, problems on the part of railways,
malfunctions, natural calamities etc., package amount will not be refunded.
11. The Company will not be liable for any confirmation of train tickets, flight tickets, other
transportation or any other related items not included in the package.
12. In Case Of Events And Circumstances Beyond Our Control, We Reserve The Right To Change All
Or Parts Of The Contents Of The Itinerary For Safety And Well Being Of Our Esteemed Passengers.
13. Bathroom Facility | Indian or European
14. In season rooms will not be the same as per itinerary but category will be the same (Budget
economy).
15. Charge will be the same from the age of 5 years.
16. We are not providing tourist guide, if you are taking their service in your own cost we will not be
responsible for the same.
17. You Should reach to departing place on time, also you should keep the time management or you
will not be able to cover all the place.
18. If the climate condition affect the sightseeing & activities that mentioned in itinerary, then we
won't provide you the additional spots apart from the itinerary.
19. Transportation timing 8 am to 6 pm, if use vehicle after that then cost will be extra
20. Will visit places as per itinerary only, if you visit other than this then cost will be extra
21. If any customers misbehave with our staffs improperly then we will cancel his tour immediately
and after that he can't continue with this tour.
22. If the trip is not fully booked or cancelled due to any special circumstances, we will postpone the
trip to another day. Otherwise, if the journey is to be done on the pre-arranged day, the customers
will have to bear the extra money themselves.
23. If you have any problems with the tour, please notify us as soon as possible so that we can
resolve the problem. If you raise the issue after the tour, we will not be able to help you.
24.Our company does not provide specific seats on the Volvo bus, if you need a seat particularly,
please let the executive know during the confirmation of your reservation.(requires additional
payment).
''', style: const pw.TextStyle(fontSize: 17))
          ];
        },
        footer: (pw.Context context) {
          log('nm,.${context.pagesCount}');
          // final String text =
          //     'Page ${context.pageNumber} of ${context.pagesCount} ';
          return pw.Container(
            // margin: const pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            alignment: pw.Alignment.centerRight,
            decoration:
                const pw.BoxDecoration(border: pw.Border(top: pw.BorderSide())),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: <pw.Widget>[
                pw.Paragraph(
                    margin: const pw.EdgeInsets.all(10),
                    text: '''
A TOWER COMPLEX, KALVARY, JUNCTION, POOTHOLE ROAD,\nTHRISSUR, KERALA 680004 | 04872383104 | 0487238410''',
                    style: pw.TextStyle(fontNormal: pw.Font.courier())),
                // pw.Text(text, style: const pw.TextStyle(color: PdfColors.grey)),
              ],
            ),
          );
        },
      ),
    );
  } catch (e) {
    log('hbhubu $e');
  }
}
