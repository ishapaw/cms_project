import 'package:cms/Useful/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Useful/widgets.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? date;

  @override
  void initState() {
    getText();
  }

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      // return DateFormat('MM/dd/yyyy').format(date);
      return '${date?.month}/${date?.day}/${date?.year}';
    }
  }

  @override
  Widget build(BuildContext context) =>
      borderbtnsss(getText(), () => pickDate(context), darkBlue, lightBlue);

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }
}
