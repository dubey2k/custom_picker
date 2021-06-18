import 'package:custom_picker/custom_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var opt = [5, 17, 41];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomPicker(
              // deciding list whether to show loop over popup items
              optionLoop: [false, false, false],
              // give popup height
              popupHeight: 500,
              // where to show popupmenu
              below: false,
              // give where to place popup vertically
              verticalOffset: 10,
              // hanfle all changes here
              handleChange: (list) {
                print(list);
              },
              // to include yes no dialog or not
              yesNo: true,
              //give color to popup selected option
              popUpSelColor: Colors.black.withAlpha(50),
              // customize text style for each popUp list
              popUpTextStyle: [
                TextStyle(color: Colors.grey.shade600, fontSize: 18),
                TextStyle(color: Colors.grey.shade600, fontSize: 18),
                TextStyle(color: Colors.grey.shade600, fontSize: 18),
              ],
              // customize text style for each list
              widTextStyle: [
                TextStyle(color: Colors.black.withAlpha(120), fontSize: 18),
                TextStyle(color: Colors.black.withAlpha(120), fontSize: 18),
                TextStyle(color: Colors.black.withAlpha(120), fontSize: 18),
              ],
              // customize divider color
              divColor: Colors.grey.shade200,
              //add padding
              contentPadding: const EdgeInsets.all(7),
              //give a decoration to your popupmenu
              popUpDecoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x33000000).withAlpha(50),
                      offset: Offset(2, 4),
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              // decorate your picker widget
              widDecoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x33000000).withAlpha(50),
                    offset: Offset(2, 4),
                    blurRadius: 7,
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              // input all list you want to display in popupmenu
              list: [
                [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec'
                ],
                List.generate(31, (index) => '${index + 1}').toList(),
                List.generate(50, (index) => '${index + 1980}').toList(),
              ],
              // control flex property of picker children
              wtList: [3, 1, 2],
              // callback that'll be call when option of YesNo dialog is clicked
              onChanged: (List<int> value) {
                opt = value;
                setState(() {});
              },
              //give initial selected item indicies
              selected: opt,
            ),
            SizedBox(height: 100),
          ],
          // CustomPicker(
          //   // deciding list whether to show loop over popup items
          //   optionLoop: [false, false],
          //   // give popup height
          //   popupHeight: 200,
          //   // where to show popupmenu
          //   below: false,
          //   // give where to place popup vertically
          //   verticalOffset: 10,
          //   // hanfle all changes here
          //   handleChange: (list) {
          //     print(list);
          //   },
          //   // to include yes no dialog or not
          //   yesNo: true,
          //   //give color to popup selected option
          //   popUpSelColor: Colors.black.withAlpha(150),
          //   // customize text style for each popUp list
          //   popUpTextStyle: const [
          //     TextStyle(color: Colors.white, fontSize: 20),
          //     TextStyle(color: Colors.white, fontSize: 20),
          //   ],
          //   // customize text style for each list
          //   widTextStyle: const [
          //     TextStyle(color: Colors.black, fontSize: 18),
          //     TextStyle(color: Colors.black, fontSize: 18),
          //   ],
          //   // customize divider color
          //   divColor: Colors.black,
          //   //give a decoration to your popupmenu
          //   popUpDecoration: BoxDecoration(
          //       color: Colors.black.withAlpha(100),
          //       borderRadius: BorderRadius.circular(10)),
          //   // decorate your picker widget
          //   widDecoration: BoxDecoration(
          //     border: Border.all(width: 2, color: Colors.black),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   // input all list you want to display in popupmenu
          //   list: const [
          //     ['1', '2', '3', '4', '5', '6'],
          //     ['one', 'two', 'three']
          //   ],
          //   // control flex property of picker children
          //   wtList: [3, 1],
          //   // callback that'll be call when option of YesNo dialog is clicked
          //   onChanged: (List<int> value) {
          //     print(value);
          //   },
          //   //give initial selected item indicies
          //   selected: const [0, 1],
          // ),
        ),
      ),
    );
  }
}
