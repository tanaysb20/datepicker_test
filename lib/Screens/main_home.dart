import 'dart:ui';

import 'package:date_test/Screens/monthpicker.dart';
import 'package:date_test/Screens/select_from_to_date.dart';
import 'package:date_test/Screens/selected_event_date.dart';
import 'package:date_test/Screens/vertical_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  String userType = "";
  String middlename = "";
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: height * 0.115,
              width: width,
              decoration: const BoxDecoration(color: Color(0xff0D47A1)),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    "EV Studios",
                    style: TextStyle(
                        fontSize: height * 0.032,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  SizedBox(width: width * 0.06),
                ],
              ),
            ),
            Expanded(
              child: VerticalTabs(
                itemExtent: height * 0.06,
                tabsWidth: width * 0.14,
                callback: (p0) {
                  if (p0 == 0) {
                    middlename = "Month Picker";
                  } else if (p0 == 1) {
                    middlename = "From To Date";
                  } else if (p0 == 2) {
                    middlename = "Salary Slip";
                  } else if (p0 == 3) {
                    middlename = "Clock In-Out Detail";
                  }
                  setState(() {});
                },
                tabs: const [
                  Tab(
                    text: "Range Selector Date",
                  ),
                  Tab(
                    text: "Month Picker",
                  ),
                  Tab(
                    text: "Selected Event Dates",
                  ),
                ],
                contents: const [
                  SelectFromToDate(),
                  SimpleDatePicker(),
                  SelectedEventDate(),
                ],
              ),
            )
          ],
        ),
        backgroundColor: Colors.white54);
  }
}

Widget customContainerSelection(BuildContext context, String title) {
  double _sigmaX = 0.1; // from 0-10
  double _sigmaY = 0.1; // from 0-10
  double _opacity = 0.1;
  return Container(
    height: MediaQuery.of(context).size.height * 0.2,
    width: MediaQuery.of(context).size.width * 0.37,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.amber.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
            image: NetworkImage(
                "https://s3-symbol-logo.tradingview.com/jk-tyre-and-industries--600.png"),
            fit: BoxFit.cover)),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
      child: Container(
        color: Colors.black.withOpacity(_opacity),
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.03, top: 4),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.height * 0.023,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
