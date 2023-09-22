import 'package:flutter/material.dart';
import 'package:flutter_calculator/const.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const BeginScreen(),
    );
  }
}

class BeginScreen extends StatefulWidget {
  const BeginScreen({super.key});

  @override
  State<BeginScreen> createState() => _BeginScreenState();
}

class _BeginScreenState extends State<BeginScreen> {
  String inputNumer = '';
  String result = '';

  inputFunction(String text) {
    setState(() {
      inputNumer = inputNumer + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            screenWidget(),
            toolsWidget(),
            buttonsWidget(),
          ],
        ),
      ),
    );
  }

  Expanded buttonsWidget() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customRow('C', '()', '%', '/'),
            customRow('7', '8', '9', '*'),
            customRow('4', '5', '6', '-'),
            customRow('1', '2', '3', '+'),
            customRow('+/-', '0', '.', '='),
          ],
        ),
      ),
    );
  }

  Expanded toolsWidget() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.access_time,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.straighten,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calculate_outlined,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (inputNumer.isNotEmpty) {
                    inputNumer = inputNumer.substring(0, inputNumer.length - 1);
                  }
                });
              },
              icon: Icon(
                Icons.backspace_outlined,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded screenWidget() {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              inputNumberText(inputNumer),
              style: TextStyle(fontSize: 32),
              textAlign: TextAlign.right,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              result,
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Row customRow(
    String label1,
    String label2,
    String label3,
    String label4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(side: BorderSide()),
            fixedSize: const Size(75, 75),
            backgroundColor: buttonBackgroundColor,
          ),
          onPressed: () {
            if (label1 == 'C') {
              setState(() {
                result = '';
                inputNumer = '';
              });
            } else {
              inputFunction(label1);
            }
          },
          child: Text(
            label1,
            style: TextStyle(
              fontSize: 22,
              color: textColor(label1),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(side: BorderSide()),
            fixedSize: const Size(75, 75),
            backgroundColor: buttonBackgroundColor,
          ),
          onPressed: () {
            inputFunction(label2);
          },
          child: Text(
            label2,
            style: TextStyle(
              fontSize: 22,
              color: textColor(label2),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(side: BorderSide()),
            fixedSize: const Size(75, 75),
            backgroundColor: buttonBackgroundColor,
          ),
          onPressed: () {
            inputFunction(label3);
          },
          child: Text(
            label3,
            style: TextStyle(
              fontSize: 22,
              color: textColor(label3),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(side: BorderSide()),
            fixedSize: const Size(75, 75),
            backgroundColor: backgroundColor(label4),
          ),
          onPressed: () {
            if (label4 == '=') {
              Parser p = Parser();
              Expression exp = p.parse(inputNumer);

              ContextModel equal = ContextModel();

              double eval = exp.evaluate(EvaluationType.REAL, equal);
              setState(() {
                result = eval.toString();
              });
              print(eval);
            } else {
              inputFunction(label4);
            }
          },
          child: Text(
            label4,
            style: TextStyle(
              fontSize: 22,
              color: textColor(label4),
            ),
          ),
        ),
      ],
    );
  }

  String inputNumberText(String text) {
// inputNumer.isEmpty ? "0" : inputNumer
    if (inputNumer.isEmpty) {
      return '0';
    }
    return inputNumer;
  }

  bool isOperator(String text) {
    var operators = ['()', '%', '/', '*', '-', '+'];

    for (var item in operators) {
      if (item == text) {
        return true;
      }
    }
    return false;
  }

  bool isClean(String text) {
    String clean = 'C';

    if (clean == text) {
      return true;
    }
    return false;
  }

  Color textColor(String text) {
    if (isClean(text)) {
      return Colors.red.shade300;
    } else {
      if (isOperator(text)) {
        return primaryColor;
      } else {
        return Colors.white;
      }
    }
  }

  bool isEqual(String text) {
    String clean = '=';

    if (clean == text) {
      return true;
    }
    return false;
  }

  Color backgroundColor(String text) {
    if (isEqual(text)) {
      return primaryColor;
    } else {
      return buttonBackgroundColor;
    }
  }
}
