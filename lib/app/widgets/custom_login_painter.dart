// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
// class CustomLoginPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Path path_0 = Path();
//     path_0.moveTo(size.width * 0.09741551, 0);
//     path_0.lineTo(size.width * 0.9483101, 0);
//     path_0.lineTo(size.width * 0.9483101, size.height);
//     path_0.lineTo(size.width * 0.09741551, size.height);
//     path_0.lineTo(size.width * 0.09741551, 0);
//     path_0.close();

//     final Paint paint0Fill = Paint()..style = PaintingStyle.fill;
//     paint0Fill.shader = ui.Gradient.linear(
//         Offset(size.width * 0.5228628, 0),
//         Offset(size.width * 0.5228628, size.height * 4.433629),
//         [const Color(0xff0075FF).withOpacity(1), Colors.white.withOpacity(1)],
//         [0.0001, 1]);
//     canvas.drawPath(path_0, paint0Fill);

//     final Path path_1 = Path();
//     path_1.moveTo(size.width * 0.09741551, size.height * 0.4397754);
//     path_1.cubicTo(
//         size.width * 0.09741551,
//         size.height * 0.4051210,
//         size.width * 0.09741551,
//         size.height * 0.3877937,
//         size.width * 0.1103771,
//         size.height * 0.3753931);
//     path_1.cubicTo(
//         size.width * 0.1217960,
//         size.height * 0.3644687,
//         size.width * 0.1398698,
//         size.height * 0.3560486,
//         size.width * 0.1614863,
//         size.height * 0.3515832);
//     path_1.cubicTo(
//         size.width * 0.1860237,
//         size.height * 0.3465151,
//         size.width * 0.2175487,
//         size.height * 0.3491555,
//         size.width * 0.2806024,
//         size.height * 0.3544374);
//     path_1.cubicTo(
//         size.width * 0.3711531,
//         size.height * 0.3620216,
//         size.width * 0.4164274,
//         size.height * 0.3658143,
//         size.width * 0.4619344,
//         size.height * 0.3673326);
//     path_1.cubicTo(
//         size.width * 0.5025149,
//         size.height * 0.3686857,
//         size.width * 0.5432107,
//         size.height * 0.3686857,
//         size.width * 0.5837913,
//         size.height * 0.3673326);
//     path_1.cubicTo(
//         size.width * 0.6292982,
//         size.height * 0.3658143,
//         size.width * 0.6745726,
//         size.height * 0.3620216,
//         size.width * 0.7651233,
//         size.height * 0.3544374);
//     path_1.cubicTo(
//         size.width * 0.8281769,
//         size.height * 0.3491555,
//         size.width * 0.8597018,
//         size.height * 0.3465151,
//         size.width * 0.8842386,
//         size.height * 0.3515832);
//     path_1.cubicTo(
//         size.width * 0.9058569,
//         size.height * 0.3560486,
//         size.width * 0.9239304,
//         size.height * 0.3644687,
//         size.width * 0.9353479,
//         size.height * 0.3753931);
//     path_1.cubicTo(
//         size.width * 0.9483101,
//         size.height * 0.3877937,
//         size.width * 0.9483101,
//         size.height * 0.4051210,
//         size.width * 0.9483101,
//         size.height * 0.4397754);
//     path_1.lineTo(size.width * 0.9483101, size.height);
//     path_1.lineTo(size.width * 0.09741551, size.height);
//     path_1.lineTo(size.width * 0.09741551, size.height * 0.4397754);
//     path_1.close();

//     final Paint paint1Fill = Paint()..style = PaintingStyle.fill;
//     paint1Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawPath(path_1, paint1Fill);

//     final Paint paint2Stroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     paint2Stroke.color = Colors.white.withOpacity(1.0);
//     canvas.drawRRect(
//         RRect.fromRectAndCorners(
//             Rect.fromLTWH(size.width * 0.8744195, size.height * 0.009539212,
//                 size.width * 0.04174950, size.height * 0.01115907),
//             bottomRight: Radius.circular(size.width * 0.004307495),
//             bottomLeft: Radius.circular(size.width * 0.004307495),
//             topLeft: Radius.circular(size.width * 0.004307495),
//             topRight: Radius.circular(size.width * 0.004307495)),
//         paint2Stroke);

//     final Paint paint2Fill = Paint()..style = PaintingStyle.fill;
//     paint2Fill.color = const Color(0xff000000).withOpacity(1.0);
//     canvas.drawRRect(
//         RRect.fromRectAndCorners(
//             Rect.fromLTWH(size.width * 0.8744195, size.height * 0.009539212,
//                 size.width * 0.04174950, size.height * 0.01115907),
//             bottomRight: Radius.circular(size.width * 0.004307495),
//             bottomLeft: Radius.circular(size.width * 0.004307495),
//             topLeft: Radius.circular(size.width * 0.004307495),
//             topRight: Radius.circular(size.width * 0.004307495)),
//         paint2Fill);

//     final Path path_3 = Path();
//     path_3.moveTo(size.width * 0.9191511, size.height * 0.01295896);
//     path_3.lineTo(size.width * 0.9191511, size.height * 0.01727862);
//     path_3.cubicTo(
//         size.width * 0.9207515,
//         size.height * 0.01691274,
//         size.width * 0.9217913,
//         size.height * 0.01606166,
//         size.width * 0.9217913,
//         size.height * 0.01511879);
//     path_3.cubicTo(
//         size.width * 0.9217913,
//         size.height * 0.01417592,
//         size.width * 0.9207515,
//         size.height * 0.01332484,
//         size.width * 0.9191511,
//         size.height * 0.01295896);

//     final Paint paint3Fill = Paint()..style = PaintingStyle.fill;
//     paint3Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawPath(path_3, paint3Fill);

//     final Paint paint4Fill = Paint()..style = PaintingStyle.fill;
//     paint4Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawRRect(
//         RRect.fromRectAndCorners(
//             Rect.fromLTWH(size.width * 0.8774016, size.height * 0.01115907,
//                 size.width * 0.03578529, size.height * 0.007919363),
//             bottomRight: Radius.circular(size.width * 0.002650755),
//             bottomLeft: Radius.circular(size.width * 0.002650755),
//             topLeft: Radius.circular(size.width * 0.002650755),
//             topRight: Radius.circular(size.width * 0.002650755)),
//         paint4Fill);

//     final Path path_5 = Path();
//     path_5.moveTo(size.width * 0.8482445, size.height * 0.01146350);
//     path_5.cubicTo(
//         size.width * 0.8526680,
//         size.height * 0.01146361,
//         size.width * 0.8569205,
//         size.height * 0.01238596,
//         size.width * 0.8601272,
//         size.height * 0.01403996);
//     path_5.cubicTo(
//         size.width * 0.8603678,
//         size.height * 0.01416760,
//         size.width * 0.8607535,
//         size.height * 0.01416598,
//         size.width * 0.8609920,
//         size.height * 0.01403629);
//     path_5.lineTo(size.width * 0.8632982, size.height * 0.01277246);
//     path_5.cubicTo(
//         size.width * 0.8634195,
//         size.height * 0.01270670,
//         size.width * 0.8634871,
//         size.height * 0.01261760,
//         size.width * 0.8634851,
//         size.height * 0.01252484);
//     path_5.cubicTo(
//         size.width * 0.8634851,
//         size.height * 0.01243218,
//         size.width * 0.8634155,
//         size.height * 0.01234352,
//         size.width * 0.8632942,
//         size.height * 0.01227851);
//     path_5.cubicTo(
//         size.width * 0.8548807,
//         size.height * 0.007902408,
//         size.width * 0.8416083,
//         size.height * 0.007902408,
//         size.width * 0.8331948,
//         size.height * 0.01227851);
//     path_5.cubicTo(
//         size.width * 0.8330716,
//         size.height * 0.01234341,
//         size.width * 0.8330040,
//         size.height * 0.01243207,
//         size.width * 0.8330020,
//         size.height * 0.01252484);
//     path_5.cubicTo(
//         size.width * 0.8330000,
//         size.height * 0.01261749,
//         size.width * 0.8330676,
//         size.height * 0.01270659,
//         size.width * 0.8331889,
//         size.height * 0.01277246);
//     path_5.lineTo(size.width * 0.8354970, size.height * 0.01403629);
//     path_5.cubicTo(
//         size.width * 0.8357336,
//         size.height * 0.01416620,
//         size.width * 0.8361193,
//         size.height * 0.01416782,
//         size.width * 0.8363618,
//         size.height * 0.01403996);
//     path_5.cubicTo(
//         size.width * 0.8395666,
//         size.height * 0.01238585,
//         size.width * 0.8438211,
//         size.height * 0.01146350,
//         size.width * 0.8482445,
//         size.height * 0.01146350);
//     path_5.close();
//     path_5.moveTo(size.width * 0.8482445, size.height * 0.01557527);
//     path_5.cubicTo(
//         size.width * 0.8506740,
//         size.height * 0.01557527,
//         size.width * 0.8530179,
//         size.height * 0.01606544,
//         size.width * 0.8548191,
//         size.height * 0.01695076);
//     path_5.cubicTo(
//         size.width * 0.8550636,
//         size.height * 0.01707635,
//         size.width * 0.8554473,
//         size.height * 0.01707365,
//         size.width * 0.8556839,
//         size.height * 0.01694460);
//     path_5.lineTo(size.width * 0.8579901, size.height * 0.01568078);
//     path_5.cubicTo(
//         size.width * 0.8581113,
//         size.height * 0.01561447,
//         size.width * 0.8581769,
//         size.height * 0.01552451,
//         size.width * 0.8581769,
//         size.height * 0.01543110);
//     path_5.cubicTo(
//         size.width * 0.8581750,
//         size.height * 0.01533769,
//         size.width * 0.8581034,
//         size.height * 0.01524849,
//         size.width * 0.8579801,
//         size.height * 0.01518348);
//     path_5.cubicTo(
//         size.width * 0.8524950,
//         size.height * 0.01241415,
//         size.width * 0.8440000,
//         size.height * 0.01241415,
//         size.width * 0.8385149,
//         size.height * 0.01518348);
//     path_5.cubicTo(
//         size.width * 0.8383897,
//         size.height * 0.01524849,
//         size.width * 0.8383201,
//         size.height * 0.01533769,
//         size.width * 0.8383181,
//         size.height * 0.01543121);
//     path_5.cubicTo(
//         size.width * 0.8383161,
//         size.height * 0.01552462,
//         size.width * 0.8383837,
//         size.height * 0.01561458,
//         size.width * 0.8385050,
//         size.height * 0.01568078);
//     path_5.lineTo(size.width * 0.8408091, size.height * 0.01694460);
//     path_5.cubicTo(
//         size.width * 0.8410477,
//         size.height * 0.01707365,
//         size.width * 0.8414314,
//         size.height * 0.01707635,
//         size.width * 0.8416740,
//         size.height * 0.01695076);
//     path_5.cubicTo(
//         size.width * 0.8434751,
//         size.height * 0.01606609,
//         size.width * 0.8458171,
//         size.height * 0.01557592,
//         size.width * 0.8482445,
//         size.height * 0.01557527);
//     path_5.close();
//     path_5.moveTo(size.width * 0.8528608, size.height * 0.01834190);
//     path_5.cubicTo(
//         size.width * 0.8528648,
//         size.height * 0.01843564,
//         size.width * 0.8527972,
//         size.height * 0.01852592,
//         size.width * 0.8526740,
//         size.height * 0.01859158);
//     path_5.lineTo(size.width * 0.8486879, size.height * 0.02077516);
//     path_5.cubicTo(
//         size.width * 0.8485706,
//         size.height * 0.02083931,
//         size.width * 0.8484115,
//         size.height * 0.02087549,
//         size.width * 0.8482445,
//         size.height * 0.02087549);
//     path_5.cubicTo(
//         size.width * 0.8480775,
//         size.height * 0.02087549,
//         size.width * 0.8479185,
//         size.height * 0.02083931,
//         size.width * 0.8478032,
//         size.height * 0.02077516);
//     path_5.lineTo(size.width * 0.8438151, size.height * 0.01859158);
//     path_5.cubicTo(
//         size.width * 0.8436918,
//         size.height * 0.01852592,
//         size.width * 0.8436243,
//         size.height * 0.01843553,
//         size.width * 0.8436282,
//         size.height * 0.01834179);
//     path_5.cubicTo(
//         size.width * 0.8436322,
//         size.height * 0.01824806,
//         size.width * 0.8437058,
//         size.height * 0.01815940,
//         size.width * 0.8438350,
//         size.height * 0.01809654);
//     path_5.cubicTo(
//         size.width * 0.8463797,
//         size.height * 0.01692775,
//         size.width * 0.8501093,
//         size.height * 0.01692775,
//         size.width * 0.8526561,
//         size.height * 0.01809654);
//     path_5.cubicTo(
//         size.width * 0.8527833,
//         size.height * 0.01815940,
//         size.width * 0.8528588,
//         size.height * 0.01824816,
//         size.width * 0.8528608,
//         size.height * 0.01834190);
//     path_5.close();

//     final Paint paint5Fill = Paint()..style = PaintingStyle.fill;
//     paint5Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawPath(path_5, paint5Fill);

//     final Path path_6 = Path();
//     path_6.moveTo(size.width * 0.8210736, size.height * 0.009359276);
//     path_6.lineTo(size.width * 0.8190855, size.height * 0.009359276);
//     path_6.cubicTo(
//         size.width * 0.8179881,
//         size.height * 0.009359276,
//         size.width * 0.8170974,
//         size.height * 0.009842765,
//         size.width * 0.8170974,
//         size.height * 0.01043919);
//     path_6.lineTo(size.width * 0.8170974, size.height * 0.01979849);
//     path_6.cubicTo(
//         size.width * 0.8170974,
//         size.height * 0.02039482,
//         size.width * 0.8179881,
//         size.height * 0.02087840,
//         size.width * 0.8190855,
//         size.height * 0.02087840);
//     path_6.lineTo(size.width * 0.8210736, size.height * 0.02087840);
//     path_6.cubicTo(
//         size.width * 0.8221710,
//         size.height * 0.02087840,
//         size.width * 0.8230616,
//         size.height * 0.02039482,
//         size.width * 0.8230616,
//         size.height * 0.01979849);
//     path_6.lineTo(size.width * 0.8230616, size.height * 0.01043919);
//     path_6.cubicTo(
//         size.width * 0.8230616,
//         size.height * 0.009842765,
//         size.width * 0.8221710,
//         size.height * 0.009359276,
//         size.width * 0.8210736,
//         size.height * 0.009359276);
//     path_6.close();
//     path_6.moveTo(size.width * 0.8098072, size.height * 0.01187905);
//     path_6.lineTo(size.width * 0.8117952, size.height * 0.01187905);
//     path_6.cubicTo(
//         size.width * 0.8128946,
//         size.height * 0.01187905,
//         size.width * 0.8137833,
//         size.height * 0.01236253,
//         size.width * 0.8137833,
//         size.height * 0.01295896);
//     path_6.lineTo(size.width * 0.8137833, size.height * 0.01979849);
//     path_6.cubicTo(
//         size.width * 0.8137833,
//         size.height * 0.02039482,
//         size.width * 0.8128946,
//         size.height * 0.02087840,
//         size.width * 0.8117952,
//         size.height * 0.02087840);
//     path_6.lineTo(size.width * 0.8098072, size.height * 0.02087840);
//     path_6.cubicTo(
//         size.width * 0.8087097,
//         size.height * 0.02087840,
//         size.width * 0.8078191,
//         size.height * 0.02039482,
//         size.width * 0.8078191,
//         size.height * 0.01979849);
//     path_6.lineTo(size.width * 0.8078191, size.height * 0.01295896);
//     path_6.cubicTo(
//         size.width * 0.8078191,
//         size.height * 0.01236253,
//         size.width * 0.8087097,
//         size.height * 0.01187905,
//         size.width * 0.8098072,
//         size.height * 0.01187905);
//     path_6.close();
//     path_6.moveTo(size.width * 0.8025189, size.height * 0.01439892);
//     path_6.lineTo(size.width * 0.8005308, size.height * 0.01439892);
//     path_6.cubicTo(
//         size.width * 0.7994314,
//         size.height * 0.01439892,
//         size.width * 0.7985427,
//         size.height * 0.01488240,
//         size.width * 0.7985427,
//         size.height * 0.01547883);
//     path_6.lineTo(size.width * 0.7985427, size.height * 0.01979849);
//     path_6.cubicTo(
//         size.width * 0.7985427,
//         size.height * 0.02039482,
//         size.width * 0.7994314,
//         size.height * 0.02087840,
//         size.width * 0.8005308,
//         size.height * 0.02087840);
//     path_6.lineTo(size.width * 0.8025189, size.height * 0.02087840);
//     path_6.cubicTo(
//         size.width * 0.8036163,
//         size.height * 0.02087840,
//         size.width * 0.8045070,
//         size.height * 0.02039482,
//         size.width * 0.8045070,
//         size.height * 0.01979849);
//     path_6.lineTo(size.width * 0.8045070, size.height * 0.01547883);
//     path_6.cubicTo(
//         size.width * 0.8045070,
//         size.height * 0.01488240,
//         size.width * 0.8036163,
//         size.height * 0.01439892,
//         size.width * 0.8025189,
//         size.height * 0.01439892);
//     path_6.close();
//     path_6.moveTo(size.width * 0.7932406, size.height * 0.01655875);
//     path_6.lineTo(size.width * 0.7912525, size.height * 0.01655875);
//     path_6.cubicTo(
//         size.width * 0.7901551,
//         size.height * 0.01655875,
//         size.width * 0.7892644,
//         size.height * 0.01704222,
//         size.width * 0.7892644,
//         size.height * 0.01763866);
//     path_6.lineTo(size.width * 0.7892644, size.height * 0.01979849);
//     path_6.cubicTo(
//         size.width * 0.7892644,
//         size.height * 0.02039482,
//         size.width * 0.7901551,
//         size.height * 0.02087840,
//         size.width * 0.7912525,
//         size.height * 0.02087840);
//     path_6.lineTo(size.width * 0.7932406, size.height * 0.02087840);
//     path_6.cubicTo(
//         size.width * 0.7943380,
//         size.height * 0.02087840,
//         size.width * 0.7952286,
//         size.height * 0.02039482,
//         size.width * 0.7952286,
//         size.height * 0.01979849);
//     path_6.lineTo(size.width * 0.7952286, size.height * 0.01763866);
//     path_6.cubicTo(
//         size.width * 0.7952286,
//         size.height * 0.01704222,
//         size.width * 0.7943380,
//         size.height * 0.01655875,
//         size.width * 0.7932406,
//         size.height * 0.01655875);
//     path_6.close();

//     final Paint paint6Fill = Paint()..style = PaintingStyle.fill;
//     paint6Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawPath(path_6, paint6Fill);

//     final Path path_7 = Path();
//     path_7.moveTo(size.width * 0.1736266, size.height * 0.01827754);
//     path_7.cubicTo(
//         size.width * 0.1737857,
//         size.height * 0.01875270,
//         size.width * 0.1741435,
//         size.height * 0.01911987,
//         size.width * 0.1747002,
//         size.height * 0.01937905);
//     path_7.cubicTo(
//         size.width * 0.1752767,
//         size.height * 0.01962743,
//         size.width * 0.1760421,
//         size.height * 0.01975162,
//         size.width * 0.1769964,
//         size.height * 0.01975162);
//     path_7.cubicTo(
//         size.width * 0.1782290,
//         size.height * 0.01975162,
//         size.width * 0.1791237,
//         size.height * 0.01947624,
//         size.width * 0.1796803,
//         size.height * 0.01892549);
//     path_7.cubicTo(
//         size.width * 0.1802370,
//         size.height * 0.01836393,
//         size.width * 0.1805153,
//         size.height * 0.01742441,
//         size.width * 0.1805153,
//         size.height * 0.01610691);
//     path_7.cubicTo(
//         size.width * 0.1800581,
//         size.height * 0.01645248,
//         size.width * 0.1794119,
//         size.height * 0.01672246,
//         size.width * 0.1785769,
//         size.height * 0.01691685);
//     path_7.cubicTo(
//         size.width * 0.1777618,
//         size.height * 0.01711123,
//         size.width * 0.1768771,
//         size.height * 0.01720842,
//         size.width * 0.1759229,
//         size.height * 0.01720842);
//     path_7.cubicTo(
//         size.width * 0.1746505,
//         size.height * 0.01720842,
//         size.width * 0.1734974,
//         size.height * 0.01706803,
//         size.width * 0.1724636,
//         size.height * 0.01678726);
//     path_7.cubicTo(
//         size.width * 0.1714497,
//         size.height * 0.01649568,
//         size.width * 0.1706445,
//         size.height * 0.01606911,
//         size.width * 0.1700481,
//         size.height * 0.01550756);
//     path_7.cubicTo(
//         size.width * 0.1694517,
//         size.height * 0.01493521,
//         size.width * 0.1691535,
//         size.height * 0.01424406,
//         size.width * 0.1691535,
//         size.height * 0.01343413);
//     path_7.cubicTo(
//         size.width * 0.1691535,
//         size.height * 0.01223542,
//         size.width * 0.1698095,
//         size.height * 0.01128510,
//         size.width * 0.1711217,
//         size.height * 0.01058315);
//     path_7.cubicTo(
//         size.width * 0.1724338,
//         size.height * 0.009870410,
//         size.width * 0.1742231,
//         size.height * 0.009514039,
//         size.width * 0.1764895,
//         size.height * 0.009514039);
//     path_7.cubicTo(
//         size.width * 0.1793125,
//         size.height * 0.009514039,
//         size.width * 0.1813006,
//         size.height * 0.01000540,
//         size.width * 0.1824537,
//         size.height * 0.01098812);
//     path_7.cubicTo(
//         size.width * 0.1836266,
//         size.height * 0.01197084,
//         size.width * 0.1842131,
//         size.height * 0.01345032,
//         size.width * 0.1842131,
//         size.height * 0.01542657);
//     path_7.cubicTo(
//         size.width * 0.1842131,
//         size.height * 0.01683045,
//         size.width * 0.1839845,
//         size.height * 0.01798056,
//         size.width * 0.1835272,
//         size.height * 0.01887689);
//     path_7.cubicTo(
//         size.width * 0.1830899,
//         size.height * 0.01977322,
//         size.width * 0.1823245,
//         size.height * 0.02045356,
//         size.width * 0.1812310,
//         size.height * 0.02091793);
//     path_7.cubicTo(
//         size.width * 0.1801575,
//         size.height * 0.02138229,
//         size.width * 0.1786863,
//         size.height * 0.02161447,
//         size.width * 0.1768175,
//         size.height * 0.02161447);
//     path_7.cubicTo(
//         size.width * 0.1753463,
//         size.height * 0.02161447,
//         size.width * 0.1740938,
//         size.height * 0.02146328,
//         size.width * 0.1730600,
//         size.height * 0.02116091);
//     path_7.cubicTo(
//         size.width * 0.1720262,
//         size.height * 0.02084773,
//         size.width * 0.1712310,
//         size.height * 0.02044276,
//         size.width * 0.1706744,
//         size.height * 0.01994600);
//     path_7.cubicTo(
//         size.width * 0.1701376,
//         size.height * 0.01943844,
//         size.width * 0.1698294,
//         size.height * 0.01888229,
//         size.width * 0.1697499,
//         size.height * 0.01827754);
//     path_7.lineTo(size.width * 0.1736266, size.height * 0.01827754);
//     path_7.close();
//     path_7.moveTo(size.width * 0.1767877, size.height * 0.01536177);
//     path_7.cubicTo(
//         size.width * 0.1778215,
//         size.height * 0.01536177,
//         size.width * 0.1786366,
//         size.height * 0.01518898,
//         size.width * 0.1792330,
//         size.height * 0.01484341);
//     path_7.cubicTo(
//         size.width * 0.1798294,
//         size.height * 0.01449784,
//         size.width * 0.1801276,
//         size.height * 0.01403348,
//         size.width * 0.1801276,
//         size.height * 0.01345032);
//     path_7.cubicTo(
//         size.width * 0.1801276,
//         size.height * 0.01281317,
//         size.width * 0.1798095,
//         size.height * 0.01232181,
//         size.width * 0.1791734,
//         size.height * 0.01197624);
//     path_7.cubicTo(
//         size.width * 0.1785571,
//         size.height * 0.01161987,
//         size.width * 0.1777121,
//         size.height * 0.01144168,
//         size.width * 0.1766386,
//         size.height * 0.01144168);
//     path_7.cubicTo(
//         size.width * 0.1755650,
//         size.height * 0.01144168,
//         size.width * 0.1747101,
//         size.height * 0.01162527,
//         size.width * 0.1740740,
//         size.height * 0.01199244);
//     path_7.cubicTo(
//         size.width * 0.1734577,
//         size.height * 0.01234881,
//         size.width * 0.1731495,
//         size.height * 0.01282397,
//         size.width * 0.1731495,
//         size.height * 0.01341793);
//     path_7.cubicTo(
//         size.width * 0.1731495,
//         size.height * 0.01399028,
//         size.width * 0.1734477,
//         size.height * 0.01446004,
//         size.width * 0.1740441,
//         size.height * 0.01482721);
//     path_7.cubicTo(
//         size.width * 0.1746604,
//         size.height * 0.01518359,
//         size.width * 0.1755750,
//         size.height * 0.01536177,
//         size.width * 0.1767877,
//         size.height * 0.01536177);
//     path_7.close();
//     path_7.moveTo(size.width * 0.1891924, size.height * 0.02171166);
//     path_7.cubicTo(
//         size.width * 0.1884370,
//         size.height * 0.02171166,
//         size.width * 0.1878107,
//         size.height * 0.02158747,
//         size.width * 0.1873137,
//         size.height * 0.02133909);
//     path_7.cubicTo(
//         size.width * 0.1868366,
//         size.height * 0.02107991,
//         size.width * 0.1865980,
//         size.height * 0.02076134,
//         size.width * 0.1865980,
//         size.height * 0.02038337);
//     path_7.cubicTo(
//         size.width * 0.1865980,
//         size.height * 0.02000540,
//         size.width * 0.1868366,
//         size.height * 0.01969222,
//         size.width * 0.1873137,
//         size.height * 0.01944384);
//     path_7.cubicTo(
//         size.width * 0.1878107,
//         size.height * 0.01918467,
//         size.width * 0.1884370,
//         size.height * 0.01905508,
//         size.width * 0.1891924,
//         size.height * 0.01905508);
//     path_7.cubicTo(
//         size.width * 0.1899280,
//         size.height * 0.01905508,
//         size.width * 0.1905344,
//         size.height * 0.01918467,
//         size.width * 0.1910115,
//         size.height * 0.01944384);
//     path_7.cubicTo(
//         size.width * 0.1914887,
//         size.height * 0.01969222,
//         size.width * 0.1917272,
//         size.height * 0.02000540,
//         size.width * 0.1917272,
//         size.height * 0.02038337);
//     path_7.cubicTo(
//         size.width * 0.1917272,
//         size.height * 0.02076134,
//         size.width * 0.1914887,
//         size.height * 0.02107991,
//         size.width * 0.1910115,
//         size.height * 0.02133909);
//     path_7.cubicTo(
//         size.width * 0.1905344,
//         size.height * 0.02158747,
//         size.width * 0.1899280,
//         size.height * 0.02171166,
//         size.width * 0.1891924,
//         size.height * 0.02171166);
//     path_7.close();
//     path_7.moveTo(size.width * 0.1891924, size.height * 0.01500540);
//     path_7.cubicTo(
//         size.width * 0.1884370,
//         size.height * 0.01500540,
//         size.width * 0.1878107,
//         size.height * 0.01488121,
//         size.width * 0.1873137,
//         size.height * 0.01463283);
//     path_7.cubicTo(
//         size.width * 0.1868366,
//         size.height * 0.01437365,
//         size.width * 0.1865980,
//         size.height * 0.01405508,
//         size.width * 0.1865980,
//         size.height * 0.01367711);
//     path_7.cubicTo(
//         size.width * 0.1865980,
//         size.height * 0.01329914,
//         size.width * 0.1868366,
//         size.height * 0.01298596,
//         size.width * 0.1873137,
//         size.height * 0.01273758);
//     path_7.cubicTo(
//         size.width * 0.1878107,
//         size.height * 0.01247840,
//         size.width * 0.1884370,
//         size.height * 0.01234881,
//         size.width * 0.1891924,
//         size.height * 0.01234881);
//     path_7.cubicTo(
//         size.width * 0.1899280,
//         size.height * 0.01234881,
//         size.width * 0.1905344,
//         size.height * 0.01247840,
//         size.width * 0.1910115,
//         size.height * 0.01273758);
//     path_7.cubicTo(
//         size.width * 0.1914887,
//         size.height * 0.01298596,
//         size.width * 0.1917272,
//         size.height * 0.01329914,
//         size.width * 0.1917272,
//         size.height * 0.01367711);
//     path_7.cubicTo(
//         size.width * 0.1917272,
//         size.height * 0.01405508,
//         size.width * 0.1914887,
//         size.height * 0.01437365,
//         size.width * 0.1910115,
//         size.height * 0.01463283);
//     path_7.cubicTo(
//         size.width * 0.1905344,
//         size.height * 0.01488121,
//         size.width * 0.1899280,
//         size.height * 0.01500540,
//         size.width * 0.1891924,
//         size.height * 0.01500540);
//     path_7.close();
//     path_7.moveTo(size.width * 0.1939250, size.height * 0.01929806);
//     path_7.lineTo(size.width * 0.1939250, size.height * 0.01751620);
//     path_7.lineTo(size.width * 0.2036759, size.height * 0.009935205);
//     path_7.lineTo(size.width * 0.2085368, size.height * 0.009935205);
//     path_7.lineTo(size.width * 0.2085368, size.height * 0.01732181);
//     path_7.lineTo(size.width * 0.2111610, size.height * 0.01732181);
//     path_7.lineTo(size.width * 0.2111610, size.height * 0.01929806);
//     path_7.lineTo(size.width * 0.2085368, size.height * 0.01929806);
//     path_7.lineTo(size.width * 0.2085368, size.height * 0.02159827);
//     path_7.lineTo(size.width * 0.2043618, size.height * 0.02159827);
//     path_7.lineTo(size.width * 0.2043618, size.height * 0.01929806);
//     path_7.lineTo(size.width * 0.1939250, size.height * 0.01929806);
//     path_7.close();
//     path_7.moveTo(size.width * 0.2046302, size.height * 0.01236501);
//     path_7.lineTo(size.width * 0.1985175, size.height * 0.01732181);
//     path_7.lineTo(size.width * 0.2046302, size.height * 0.01732181);
//     path_7.lineTo(size.width * 0.2046302, size.height * 0.01236501);
//     path_7.close();
//     path_7.moveTo(size.width * 0.2127157, size.height * 0.01187905);
//     path_7.lineTo(size.width * 0.2127157, size.height * 0.009789417);
//     path_7.lineTo(size.width * 0.2199026, size.height * 0.009789417);
//     path_7.lineTo(size.width * 0.2199026, size.height * 0.02159827);
//     path_7.lineTo(size.width * 0.2156083, size.height * 0.02159827);
//     path_7.lineTo(size.width * 0.2156083, size.height * 0.01187905);
//     path_7.lineTo(size.width * 0.2127157, size.height * 0.01187905);
//     path_7.close();

//     final Paint paint7Fill = Paint()..style = PaintingStyle.fill;
//     paint7Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawPath(path_7, paint7Fill);

//     final Paint paint8Fill = Paint()..style = PaintingStyle.fill;
//     paint8Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawCircle(Offset(size.width * 0.4860835, size.height * 0.2694384),
//         size.width * 0.2216700, paint8Fill);

//     final Paint paint9Fill = Paint()..style = PaintingStyle.fill;
//     paint9Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawCircle(Offset(size.width * 0.1033797, size.height * 0.08207343),
//         size.width * 0.09940358, paint9Fill);

//     final Paint paint10Fill = Paint()..style = PaintingStyle.fill;
//     paint10Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawCircle(Offset(size.width * 0.9324056, size.height * 0.1954644),
//         size.width * 0.05964215, paint10Fill);

//     final Paint paint11Fill = Paint()..style = PaintingStyle.fill;
//     paint11Fill.color = Colors.white.withOpacity(1.0);
//     canvas.drawCircle(Offset(size.width * 0.8260437, size.height * 0.3439525),
//         size.width * 0.04671968, paint11Fill);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
