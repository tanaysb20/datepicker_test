import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class SimpleDatePicker extends StatefulWidget {
  const SimpleDatePicker({super.key});

  @override
  State<SimpleDatePicker> createState() => _SimpleDatePickerState();
}

class _SimpleDatePickerState extends State<SimpleDatePicker> {
  DateTime? selectedMonth;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final DateFormat formatter = DateFormat('MMMM/yyyy');

    final DateFormat formatDate = DateFormat('yyyy-MM-dd');
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            print("object");
            final DateFormat formatter = DateFormat('MMMM');
            final pickedMonth = await showMonthYearPicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2011),
                lastDate: DateTime(2070),
                initialMonthYearPickerMode: MonthYearPickerMode.month);

            if (pickedMonth == null) {
            } else {
              selectedMonth = pickedMonth;
              // print("${formatter.format(selectedMonth!)} selectedMonth");
              setState(() {});
              setState(() {});
            }
          },
          child: Container(
            height: height * 0.055,
            width: width * 0.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 3)),
            child: Text(
              selectedMonth == null
                  ? "Select Month"
                  : formatter.format(selectedMonth!),
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
