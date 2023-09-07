import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main(){
  runApp(const calculator_app_flutter());
}

// ignore: camel_case_types
class calculator_app_flutter extends StatelessWidget {
  const calculator_app_flutter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator_App_Flutter',
      color: Colors.blue,
      home: SimpleCalculator(),

    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation ="0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation ="0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;

      }else if(buttonText == "X"){
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = equation.substring(0, equation.length-1);
        if(equation == ""){
          equation ="0";
        }

      }else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll("x", '*');
        expression = expression.replaceAll("÷", '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel  cm  = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }else{
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        if(equation =="0"){
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
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: const BorderSide(
                color:
                Colors.white,
                width: 1,
                style: BorderStyle.solid)
        ),

        onPressed: ()=> buttonPressed(buttonText),


        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Calculator_App_Flutter' )),),
        body: Column(
          children:<Widget> [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
            ),


            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(result, style: TextStyle(fontSize: resultFontSize),),
            ),

            const Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width *.75,
                  child: Table(
                    children: [
                      TableRow(
                          children: [
                            buildButton("C",1,  const Color.fromARGB(192,192,192,0)),
                            buildButton("X",1, Colors.blue),
                            buildButton("÷",1, Colors.blue),

                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton("7",1, Colors.black45),
                            buildButton("8",1, Colors.black45),
                            buildButton("9",1, Colors.black45),

                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton("4",1, Colors.black45),
                            buildButton("5",1, Colors.black45),
                            buildButton("6",1, Colors.black45),

                          ]
                      ),


                      TableRow(
                          children: [
                            buildButton("1",1, Colors.black45),
                            buildButton("2",1, Colors.black45),
                            buildButton("3",1, Colors.black45),

                          ]
                      ),

                      TableRow(
                          children: [
                            buildButton(".",1, Colors.black45),
                            buildButton("0",1, Colors.black45),
                            buildButton("00",1, Colors.black45),

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
                            children:[
                              buildButton("x", 1, Colors.grey),
                            ]
                        ),

                        TableRow(
                            children:[
                              buildButton("-", 1, Colors.grey),
                            ]
                        ),

                        TableRow(
                            children:[
                              buildButton("+", 1, Colors.grey),
                            ]
                        ),

                        TableRow(
                            children:[
                              buildButton("=", 2, Colors.blueAccent),
                            ]
                        ),
                      ],
                    )
                )

              ],
            )

          ],
        ),
    );

  }
}