import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

var request =
    Uri.parse("https://api.hgbrasil.com/finance?format=json&key=3007570d");

void main() async {
  // http.Response response = await http.get(request);
  //print(json.decode(response.body)["results"]["currencies"]["USD"]);

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\$Conversor\$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return textoCentralizado("Carregando Dados  :)");
            default:
              if (snapshot.hasError) {
                return textoCentralizado("Erro ao Carregar Dados :(");
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.monetization_on, size: 150, color: Colors.amber,),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Reais",
                          labelStyle: TextStyle(color: Colors.amber),
                          border: OutlineInputBorder(),
                          prefixText: "R\$"
                        ),
                        style: TextStyle(color:Colors.amber),
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Center textoCentralizado(String texto) {
  return Center(
      child: Text(
    texto,
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    textAlign: TextAlign.center,
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
