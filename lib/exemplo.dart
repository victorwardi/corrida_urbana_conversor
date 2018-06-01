import 'package:flutter/material.dart';

const _padding = EdgeInsets.all(32.0);

class PaceKmScreen extends StatefulWidget {
  final String title;

  PaceKmScreen({Key key, this.title}) : super(key: key);

  @override
  _PaceKmScreenState createState() => new _PaceKmScreenState();
}

class _PaceKmScreenState extends State<PaceKmScreen> {
  double _inputValue;

  String _convertedValue = '';

  bool _showValidationError = false;

  final controller = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setDefaults();
  }

  void _setDefaults() {
    setState(() {});
  }

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSelection = new Container(
      padding: _padding,
      child: new Row(
        children: [
          new Expanded(
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      padding: _padding,
                      child: new Text(
                        "Meu texto",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Text(
                      "Meu Texto 2",
                      style: new TextStyle(color: Colors.grey[500]),
                    ),
                  ])),
          new Icon(
            Icons.star,
            color: Colors.amber,
          ),
          new Text('14'),
        ],
      ),
    );

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.directions_run, "Run"),
          buildButtonColumn(Icons.accessibility, "Stop"),
          buildButtonColumn(Icons.access_alarms, "Time"),
        ],
      ),
    );
    Widget textSection = new Container(
      padding: _padding,
      child: new Text(
        "Muito texto para caber neste quadrando,"
            " porém usaremos uma maneira muito legal de deixar esse text"
            "o apresentavel no nosso aplicativo.",
        softWrap: true,
      ),
    );

    Widget imageSection = new Image.asset(
      'images/logo.png',
      width: 200.0,
      height: 200.0,
      fit: BoxFit.contain,
    );

    final inputField = new TextField(
      controller: controller,
      style: Theme.of(context).textTheme.display1,
      decoration: new InputDecoration(
          labelStyle: Theme.of(context).textTheme.display1,
          errorText: 'Erroooou!',
          labelText: 'Distancia',
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(0.0),
          )),
      keyboardType: TextInputType.number,
      onChanged: _mostraMsg,
    );

    final resultado = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputDecorator(
            child: Text(
              _convertedValue,
              style: Theme.of(context).textTheme.display1,
            ),
            decoration: InputDecoration(
              labelText: 'Output',
              labelStyle: Theme.of(context).textTheme.display1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
        ],
      ),
    );

    return new MaterialApp(
      title: "Corrida Demo",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Logotipo!"),
        ),
        body: new ListView(
          children: <Widget>[
            imageSection,
            titleSelection,
            buttonSection,
            textSection,
            inputField,
            resultado,
          ],
        ),
      ),
    );
  } //build

  // function to add buttons with text
  Column buildButtonColumn(IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;

    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Icon(icon, color: color),
        new Container(
          margin: _padding,
          child: new Text(
            label,
            style: new TextStyle(fontSize: 12.0, color: color),
          ),
        ),
      ],
    );
  }

  void _mostraMsg(String msg) {



    setState(() {
      if (msg.length > 5) {
        _convertedValue = controller.text;
        print(_convertedValue);
      }
    });
  }
} //PaceKmScreen
