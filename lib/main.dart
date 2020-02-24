import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "SI",
    home: calculator(),
    theme: ThemeData(
      //brightness: Brightness.light,
      primaryColor: Colors.black,
      accentColor: Colors.black45,
    ),
  ));
}

class calculator extends StatefulWidget {
  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  int principal, rate, term;
  var _currencies = ['Dollar', 'Rupees', 'Punds', 'Others'];
  var _currentItemSelected = 'Dollar';
  TextEditingController principalController = TextEditingController();
  TextEditingController roIController = TextEditingController();
  TextEditingController termController = TextEditingController();
  String msg = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
//      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text(
          " Simple Interest Calculator",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[Icon(Icons.equalizer), Text("     ")],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(children: <Widget>[
            //CALCULATOR IMAGE
            getCalculatorImage(),

            //TEXTFIELD-PRINCIPAL
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextFormField(
                controller: principalController,
                validator: (String val) {
                  if (val.isEmpty)
                    return 'Value  cannot be empty';

                  },
                // style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter Principal Eg.10000',
                    errorStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
            ),

            //TEXTFIELD-RATE OF INTEREST
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextFormField(
                validator: (String val) {
                  if (val.isEmpty)
                    return 'Rate Of Interest cannot be empty';
                },
                controller: roIController,
                // style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Rate Of Interest(%)',
                  hintText: 'Eg.10',
                  errorStyle: TextStyle(fontSize: 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),

//          //TEXTFIELD-TERM //DROPDOWN MENU
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(children: <Widget>[
                //TEXTFIELD-TERM
                Expanded(
                  child: TextFormField(
                      //style: textStyle,
                      validator: (String val) {
                        if (val.isEmpty){ return 'Term cannot be empty';}
                      },
                      controller: termController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 15.0),
                        labelText: 'TERM (Year)',
                        hintText: 'Eg.10',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onChanged: (String userInput) {
                        setState(() {
                          //term = userInput;
                        });
                      }),
                ),

                //DROP DOWN MENU
                Container(
                  width: 10.0,
                ),

                Expanded(
                  child: DropdownButton<String>(
                    style: textStyle,
                    items: _currencies.map((String dropDownMenuItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownMenuItem,
                        child: Text(dropDownMenuItem),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      _dropDownItemSelected(
                          newValueSelected); // newValue -> currentSelected◘
                    },
                    value: _currentItemSelected,
                  ),
                ),
              ]),
            ),

//          //BUTTON CALCULATE & RESET
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(children: <Widget>[
                //CALCULATE
                Expanded(
                  child: RaisedButton(
                      color: Colors.black45,
                      child: Text(
                        "Calculate",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            this.msg = totalAmountCalculate();
                          }
                        });
                      }),
                ),
                Container(
                  width: 10.0,
                ),
                //RESET
                Expanded(
                  child: RaisedButton(
                      color: Colors.black45,
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      }),
                )
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(msg))
          ]),
        ),
      ),
    );
  }

  void _dropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  void _reset() {
    principalController.text = '';
    roIController.text = '';
    termController.text = '';
    msg = '';
    _currentItemSelected = _currencies[0];
  }

  String totalAmountCalculate() {
    double p = double.parse(principalController.text);
    double r = double.parse(roIController.text);
    double t = double.parse(termController.text);
    double amt;
    amt = p + (p * r * t) / 100;
    return "Your investement $_currentItemSelected$p will be $_currentItemSelected$amt after $t years";
  }
}

class getCalculatorImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/calculator.png');
    Image image = Image(
      image: assetImage,
//      height: 10.0,
//      width: 10.0,
    );
    return Center(
      child: Container(
        child: image,
        width: 50.0,
        height: 50.0,
      ),
    );
  }
}
