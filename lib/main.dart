import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String decBin(userDec) {
    int userDecInt = int.parse(userDec);

    int loop = userDecInt;

    String bin = "";

    while (loop >= 1) {
      bin += (loop % 2).toString();
      loop = (loop / 2).floor();
    }
    for (int i = bin.length; i < 8; i++) {
      bin += "0";
    }
    bin = bin.split('').reversed.join();
    bin = bin.substring(0, 4) + " " + bin.substring(4, 8);

    return bin;
  }

  int binDec(userBin) {
    userBin = userBin.split(' ').join();
    int decimal = 0;

    for (int i = userBin.length - 1, j = 0; i >= 0; i--, j++) {
      if (int.parse(userBin[i]) != 0) {
        decimal += pow(2, j);
      }
    }
    return decimal;
  }

  TextEditingController binController = TextEditingController();
  TextEditingController decController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String infoFinal(numberInfo, textInfo, info) {
    return "O número $numberInfo $textInfo convertido é: $info";
  }

  String text = "";
  String info = "";
  String numberInfo = "";
  String textInfo = "";

  bool dec = false;
  bool bin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor BinToDec"),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.refresh),
            onTap: () {
              setState(() {
                bin = false;
                dec = false;
                decController.clear();
                binController.clear();
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    onSubmitted: (term) {
                      binController.text =
                          decBin(decController.text).toString();
                    },
                    onChanged: (text) {
                      binController.clear();
                      bin = false;
                      dec = true;
                    },
                    controller: decController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Decimal",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    onSubmitted: (term) {
                      decController.text =
                          binDec(binController.text.toString()).toString();
                    },
                    onChanged: (text) {
                      decController.clear();
                      bin = true;
                      dec = false;
                    },
                    controller: binController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Binario",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: RaisedButton(
                        onPressed: () {
                          if (bin == true) {
                            decController.text =
                                binDec(binController.text.toString())
                                    .toString();
                          } else if (dec == true) {
                            binController.text =
                                decBin(decController.text.toString())
                                    .toString();
                          } else {
                            print("error");
                          }
                        },
                        color: Colors.blueAccent,
                        child: Text("Converter",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
