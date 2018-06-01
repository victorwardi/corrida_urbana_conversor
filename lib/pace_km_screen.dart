import 'package:flutter/material.dart';

const _padding = EdgeInsets.all(18.0);

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

  final controllerTempo = new TextEditingController();
  final controllerDistancia = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    controllerTempo.dispose();
    controllerDistancia.dispose();
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
  String _format(String text) {
    double conversion = double.tryParse(text);
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

    final inputDistancia = new Padding(
      padding: _padding,
      child: new TextField(
        controller: controllerDistancia,
        style: Theme.of(context).textTheme.display1,
        decoration: new InputDecoration(
            labelStyle: Theme.of(context).textTheme.display1,
            errorText: _showValidationError ? 'Valor inválido' : null,
            labelText: 'Distancia',
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(0.0),
            )),
        keyboardType: TextInputType.number,
      ),
    );

    final inputTempo = new Padding(
      padding: _padding,
      child: new TextField(
        controller: controllerTempo,
        style: Theme.of(context).textTheme.display1,
        decoration: new InputDecoration(
            labelStyle: Theme.of(context).textTheme.display1,
            errorText: _showValidationError ? 'Valor inválido' : null,
            labelText: 'Tempo',
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(0.0),
            )),
        keyboardType: TextInputType.datetime,
      ),
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
              labelText: 'Pace',
              labelStyle: Theme.of(context).textTheme.display1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
        ],
      ),
    );

    final button = new IconButton(
      icon: new Icon(Icons.play_arrow),
      tooltip: 'Calcular',
      onPressed: _calcular,
    );

    return new MaterialApp(
      title: "Corrida Demo",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Logotipo!"),
        ),
        body: new ListView(
          children: <Widget>[
            titleSelection,
            inputDistancia,
            inputTempo,
            button,
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

  void _calcular() {
    setState(() {
      String inputTempo = controllerTempo.text;
      String inputDistancia = controllerDistancia.text;

      if (inputTempo == null ||
          inputTempo.isEmpty ||
          inputDistancia == null ||
          inputDistancia.isEmpty) {
        _convertedValue = '';
      } else {
        // Even though we are using the numerical keyboard, we still have to check
        // for non-numerical input such as '5..0' or '6 -3'
        try {
          final distancia = double.parse(inputDistancia);
          final tempo = DateTime.parse(inputTempo);
          _showValidationError = false;
          _convertedValue = distancia.toString();
        } on Exception catch (e) {
          print('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }
} //PaceKmScreen
