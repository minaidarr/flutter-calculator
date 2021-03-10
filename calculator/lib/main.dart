import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String expression = "";
  double equationFontSize = 90.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
      }

      else if (buttonText == "±") {
        equation = "-";
      }

      else if(buttonText == "="){

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('±', '-');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          equation = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          equation = "Error";
        }

      }

      else{
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Color.fromRGBO(67, 67, 67, 1),
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(67, 67, 67, 1), elevation: 0,),
      backgroundColor: Color.fromRGBO(67, 67, 67, 1),
      body: Column(
        children: <Widget>[


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 130, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize, color: Color.fromRGBO(233, 233, 233, 1)),),
          ),

          Expanded(
            child: Divider(),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, Color.fromRGBO(93, 94, 94, 1)),
                          buildButton("±", 1, Color.fromRGBO(93, 94, 94, 1)),
                          buildButton("%", 1, Color.fromRGBO(93, 94, 94, 1)),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Color.fromRGBO(120, 120, 120, 1)),
                          buildButton("8", 1, Color.fromRGBO(120, 120, 120, 1)),
                          buildButton("9", 1, Color.fromRGBO(120, 120, 120, 1)),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Color.fromRGBO(120, 120, 120, 1)),
                          buildButton("5", 1, Color.fromRGBO(120, 120, 120, 1)),
                          buildButton("6", 1, Color.fromRGBO(120, 120, 120, 1)),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Color.fromRGBO(120, 120, 120, 1)),
                          buildButton("2", 1, Color.fromRGBO(120, 120, 120, 1)),
                          buildButton("3", 1, Color.fromRGBO(120, 120, 120, 1)),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("0", 1, Color.fromRGBO(120, 120, 120, 1)),
                          buildButton("00", 1, Color.fromRGBO(120, 120, 120, 1)),
                          buildButton(".", 1, Color.fromRGBO(120, 120, 120, 1)),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("÷", 1, Color.fromRGBO(255, 160, 9, 1)),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("×", 1, Color.fromRGBO(255, 160, 9, 1)),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Color.fromRGBO(255, 160, 9, 1)),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Color.fromRGBO(255, 160, 9, 1)),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 1, Color.fromRGBO(255, 160, 9, 1)),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}

