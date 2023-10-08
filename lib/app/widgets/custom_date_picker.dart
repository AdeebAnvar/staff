import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomDatePickerField extends StatelessWidget {
  const CustomDatePickerField({
    super.key,
    required this.labelName,
    required this.validator,
    required this.onChange,
    this.maxLines,
    this.inputType,
    bool? isTime,
    Color? labelColor,
    Color? calanderIconColor,
    Color? borderColor,
    EdgeInsets? padding,
    String? initialValue,
    required this.hintText,
  })  : padding = padding ?? const EdgeInsets.symmetric(vertical: 8.0),
        isTime = isTime ?? false,
        calanderIconColor = calanderIconColor ?? Colors.black,
        borderColor = borderColor ?? Colors.black,
        labelColor = labelColor ?? Colors.black,
        initialValue = initialValue ?? ' ';
  final String labelName;
  final String hintText;
  final String? Function(String? value) validator;
  final Function(String value) onChange;
  final int? maxLines;
  final TextInputType? inputType;
  final bool isTime;
  final String initialValue;
  final EdgeInsets padding;
  final Color labelColor;
  final Color calanderIconColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: DateTimePicker(
              type: isTime
                  ? DateTimePickerType.dateTime
                  : DateTimePickerType.date,
              // use24HourFormat: false,
              locale: const Locale('en', 'US'),
              calendarTitle: '',
              dateMask: isTime ? 'd MMM yy HH:mm aa' : 'd MMM yy',
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(7),
                label: Text(
                  labelName,
                ),
                hintText: hintText,
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: getColorFromHex(depColor),
                ),
                isDense: true,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              initialValue: initialValue,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              onChanged: onChange,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
