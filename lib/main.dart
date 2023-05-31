import 'package:flutter/material.dart';
import 'results.dart';
import 'options.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Covid Tracker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Covid Tracker"),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Menu",
              style: TextStyle(fontSize: 50),
            ),
            ElevatedButton(
              child: Text("Brasil"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OptionsPage(
                    inType: 0,
                  ),
                ));
              },
            ),
            ElevatedButton(
              child: Text("Todos os Países"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    inType: "paises",
                    inQuery: "",
                  ),
                ));
              },
            ),
            ElevatedButton(
              child: Text("Consultar por País"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OptionsPage(
                    inType: 1,
                  ),
                ));
              },
            ),
          ],
        )));
  }
}
