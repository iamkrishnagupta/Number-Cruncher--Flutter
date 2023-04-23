// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'theme.dart'; //importing the colors theme, from the file that we have created

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalcApp(),
  ));
}

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
//creating all the required variables
  double f = 0.0;
  double s = 0.0;
  var input = '';
  var output = '';
  var operatn = '';

  //creating methods
  onButtonClick(value) {
    //if user presses AC, then reset the values
    if (value == 'C') {
      input = ' '; //blank
      output = ' ';
    } else if (value == '⌫ ') {
      //but think that there could still be an error if user presses it(backspace), before giving any input, means empty string! so fixing it-
      if (input.isNotEmpty) {
        //and if the input is empty it won't do anything
        //now if he wants to dlt something so
        input = input.substring(0, input.length - 1);
      }

      //same goes here, what if user presses "=" this button before giving any input
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;

        // can use replace all to replace x with * , but i am not really using the x(for multiplication symbol, i am using *)

        //using parser to include maths functionality
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cM = ContextModel();
        var finalValue =
            expression.evaluate(EvaluationType.REAL, cM); //evaluation
        output = finalValue.toString();
      }
    } else {
      input = input + value;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Number Cruncher',
        ),
        backgroundColor: funColor,
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: <Widget>[
          IconButton(
            onPressed: () => {},
            icon: Icon(
              Icons.calculate,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //code for input output area
          Expanded(
              child: Container(
            width: double.infinity,
            color: Color.fromARGB(255, 0, 0, 0),
            padding: EdgeInsets.all(12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 52),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                        fontSize: 26),
                  ),
                  SizedBox(
                    height: 49,
                  ),
                ]),
          )),

          //code for all the functional buttons
          Row(
            children: [
              button(text: 'C', bcolor: funColor),
              button(text: '%', bcolor: funColor),
              button(text: '⌫ ', bcolor: funColor),
              button(text: '/', bcolor: funColor),
            ],
          ),
          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: '*', bcolor: funColor),
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-', bcolor: funColor),
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+', bcolor: funColor),
            ],
          ),
          Row(
            children: [
              button(text: '00'),
              button(text: '0'),
              button(text: '.'),
              button(text: '=', bcolor: Color.fromARGB(255, 148, 80, 0)),
            ],
          ),
        ],
      ),
    );
  }

  //created a widget for button so we don't have to copy the long code again and again
  Widget button({text, bcolor = buttonColor}) => Expanded(
          //button takes text and a color in parameters
          child: Container(
        margin: const EdgeInsets.all(9),
        child: ElevatedButton(
          onPressed: () => onButtonClick(text),
          style: ElevatedButton.styleFrom(
            shape:
                //you can also use rectangular border
                // RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                //but i am using circular
                CircleBorder(),
            padding: EdgeInsets.all(23),
            backgroundColor: bcolor,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ));
}
