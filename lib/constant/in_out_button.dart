import 'package:flutter/material.dart';

Widget inOutButton(String buttonText, Color color, Function() callback) {
  return InkWell(
    child: Card(
      elevation: 10,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: color, width: 5),),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              callback();
            },

            child: Center(
              child: Text(buttonText,
                  style: TextStyle(
                      color: color,
                      fontSize: 20,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w900
                  )),
            ),
          ),
        ),
      ),
    ),
  );
}