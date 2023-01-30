import 'package:flutter/material.dart';

class RowBoxalender extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Row(
      children: [
        Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(child: Container(color: Color(0xffD9D9D9))),
                Container(
                  width: 2,
                  color: Colors.white,
                ),
                Expanded(child: Container(color: Color(0xffD9D9D9))),

              ],
            )),
        Expanded(
            flex: 1,
            child: Container(color: Color(0xff406EE5),))
      ],
    ));
  }
}