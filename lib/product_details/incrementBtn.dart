import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_job/product_details/product_details_page.dart';

class stepper extends StatefulWidget {
  @override
  _stepperState createState() => _stepperState();
}

class _stepperState extends State<stepper> {
  RxInt SliderNum = 1.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 30,
      width: size.width / 3,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(color: color3),
          borderRadius: BorderRadius.circular(5),
          color: selectedColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///------------------------------------------------------------
          ///        this widget is for Decrement Btn
          ///------------------------------------------------------------

          Container(
            width: 30,
            child: GestureDetector(
                onTap: () {
                  if (SliderNum.value > 1) {
                    SliderNum.value--;
                  }
                },
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 16,
                )),
          ),

          ///------------------------------------------------------------
          ///        this widget is for Increment Btn
          ///------------------------------------------------------------
          Container(
            width: 30,
            margin: EdgeInsets.symmetric(horizontal: 3),
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: Center(
              child: Obx(
                () => Text(
                  '$SliderNum',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ),
          Container(
            width: 30,
            child: GestureDetector(
                onTap: () {
                  SliderNum.value++;
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 16,
                )),
          ),
        ],
      ),
    );
  }
}
