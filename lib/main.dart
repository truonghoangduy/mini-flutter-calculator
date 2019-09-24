// import 'dart:convert';
//export PATH="$PATH:/Users/hoangduy/Developer/flutter/bin"
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        primaryColor: Colors.teal,
      ),
      home: StatefulBuild(),
    );
  }
}

var keyLayout = [
  "9",
  "8",
  "7",
  "+",
  "6",
  "5",
  "4",
  "-",
  "3",
  "2",
  "1",
  "*",
  "0",
  ".",
  "00",
  "/",
  "AC",
  "="
];

class StatefulBuild extends StatefulWidget {
  @override
  MyHomePage createState() => MyHomePage();
}

class BuildFunctionKey extends MyHomePage {}

class MyHomePage extends State<StatefulBuild> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  double textSize = 5.0;
  int dotDectecher = 0;
  GlobalKey outPutBox = GlobalKey();

  void buttonPressed(String buttonText) {
    print("Press what " + buttonText);
    if (buttonText == "AC") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      dotDectecher = 0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "*") {
      num1 = double.parse(output);

      operand = buttonText;

      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already conatains a decimals");
        return;
      } else {
        dotDectecher = 2;
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "*") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    print(_output);
    RenderBox outPutBoxSize = outPutBox.currentContext.findRenderObject();
    setState(() {
      if (dotDectecher != 0) {
        filterDot(_output);
      }
      // print(outPutBoxSize.size);
      //  print(outPutBoxSize.localToGlobal(Offset.zero));
      output = double.parse(_output).toStringAsFixed(dotDectecher);
      if (output.length > 9) {
        textSize = 3.0;
      } else if (output.length > 14) {
        textSize = 2.0;
      } else {
        textSize = 5.0;
      }
    });
  }

  void filterDot(String data) {
    print("Cheking input data " + data);
    String Tempdata = "";
    int tempPointer;
    try {
      tempPointer = data.indexOf(".");
      Tempdata = Tempdata.substring(tempPointer, data.length);
    } catch (e) {} finally {
      print("After slipting : " + Tempdata);
    }
  }

  Widget functionKey(int index, String name) {
    if (name == "+" ||
        name == "-" ||
        name == "/" ||
        name == "*" ||
        name == "=" ||
        name == "AC") {
      return CupertinoButton(
          child: (Text(
            name,
            textScaleFactor: 3.0,
            textAlign: TextAlign.center,
          )),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.redAccent,
          padding: EdgeInsets.all(10),
          onPressed: () {
            buttonPressed(keyLayout[index]);
          });
    } else
      //Normal keynumber
      return CupertinoButton(
          child: Text(
            keyLayout[index],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blueGrey,
          padding: EdgeInsets.all(10),
          onPressed: () {
            buttonPressed(keyLayout[index]);
          });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.blueAccent,
          leading: CupertinoButton(
            child: Icon(CupertinoIcons.home),
            onPressed: () {},
          ),
          middle: Text("Mini Calculator"),
        ),
        child: Container(
            //padding: EdgeInsets.only(bottom: 10.0),
            child: Column(
          children: <Widget>[
            Container(
              // color: Colors.brown,
              key: outPutBox,
              height: 120,
              child: Align(
                // heightFactor: 10000,

                alignment: Alignment.centerRight,
                child: Text(
                  output,
                  textScaleFactor: textSize,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 10,
                    // top: 80,
                    //bottom: 0.0,
                    right: 10,
                  ),
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
                  crossAxisCount: 4,
                  children: List.generate(keyLayout.length - 2, (index) {
                    return functionKey(index, keyLayout[index]);
                  })),
            ),
            //alignment: Alignment.bottomCenter,
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                      margin: EdgeInsets.only(right: 20.0),
                      child: functionKey(16, "AC")),
                ),
                Expanded(flex: 4, child: functionKey(17, "=")),
              ],
            ),
          ],
        )));
  }
}
// Expanded(
//   child: GridView.count(
//       padding: EdgeInsets.only(
//         left: 10,
//         // top: 80,
//         right: 10,
//       ),
//       crossAxisSpacing: 9.0,
//       mainAxisSpacing: 9.0,
//       crossAxisCount: 4,
//       children: List.generate(keyLayout.length, (index) {
//         return functionKey(index, keyLayout[index]);
//       })),
// )
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return null;
//   }
// }
// CupertinoButton(
//                       child: Text(
//                         keyLayout[index],
//                         style: Theme.of(context).textTheme.headline,
//                       ),
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       color: Colors.blueGrey,
//                       padding: EdgeInsets.all(10),
//                       onPressed: () {},
//                     );
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.display1,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
