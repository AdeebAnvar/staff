import 'package:flutter/material.dart';
import '../../core/theme/style.dart';
import '../../core/utils/constants.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    this.value,
    required this.onChanged,
    required this.labelText,
    this.dropdownValues = const <String>[''],
    required this.errorText,
    this.onTap,
  });
  final String? value;
  final List<String> dropdownValues;
  final void Function(String?) onChanged;
  final String labelText;
  final String? errorText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                // border: Border.all(
                //     color: errorText!.isEmpty
                //         ? Colors.r
                //         : Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                onTap: onTap,
                elevation: 2,
                isExpanded: true,
                underline: const SizedBox(),
                value: value,
                hint: Text(labelText),
                items: dropdownValues.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onChanged,
                iconEnabledColor: getColorFromHex(depColor),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        if (errorText!.isNotEmpty)
          Text(
            errorText.toString(),
            style: paragraph3.copyWith(color: Colors.redAccent),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
