import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SelectedEventDate extends StatefulWidget {
  const SelectedEventDate({super.key});

  @override
  State<SelectedEventDate> createState() => _SelectedEventDateState();
}

class _SelectedEventDateState extends State<SelectedEventDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfDateRangePicker(
      view: DateRangePickerView.month,
      monthViewSettings: DateRangePickerMonthViewSettings(blackoutDates: [
        DateTime(2020, 03, 26)
      ], weekendDays: [
        7,
        6
      ], specialDates: [
        DateTime(2023, 02, 20),
        DateTime(2023, 02, 16),
        DateTime(2023, 02, 17)
      ], showTrailingAndLeadingDates: true),
      monthCellStyle: DateRangePickerMonthCellStyle(
        blackoutDatesDecoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: const Color(0xFFF44436), width: 1),
            shape: BoxShape.circle),
        weekendDatesDecoration: BoxDecoration(
            color: const Color(0xFFDFDFDF),
            border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
            shape: BoxShape.circle),
        specialDatesDecoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://img.freepik.com/free-vector/elegant-merry-christmas-background-with-white-christmas-ornament_44538-4702.jpg")),
            color: Colors.green,
            border: Border.all(color: const Color(0xFF2B732F), width: 1),
            shape: BoxShape.circle),
        blackoutDateTextStyle: TextStyle(
            color: Colors.white, decoration: TextDecoration.lineThrough),
        specialDatesTextStyle: const TextStyle(color: Colors.white),
      ),
    ));
  }
}
