import 'package:flutter/material.dart';
import 'results.dart';
import 'dart:async';

List<String> paises = ["Argentina", "Brazil", "Cuba", "Bolivia"];
List<String> uf = [
  "RO",
  "AC",
  "AM",
  "RR",
  "PA",
  "AP",
  "TO",
  "MA",
  "PI",
  "CE",
  "RN",
  "PB",
  "PE",
  "AL",
  "SE",
  "BA",
  "MG",
  "ES",
  "RJ",
  "SP",
  "PR",
  "SC",
  "RS",
  "MS",
  "MT",
  "GO",
  "DF"
];

class OptionsPage extends StatefulWidget {
  final int inType;

  OptionsPage({super.key, required this.inType});

  final List<State> options = [
    BrasilOptions(),
    ConsultaOptions(),
  ];

  @override
  State<OptionsPage> createState() =>
      inType == 0 ? BrasilOptions() : ConsultaOptions();
}

class BrasilOptions extends State<OptionsPage> {
  String dropdownValue = uf.first;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Selecione uma opção de consulta.",
            style: TextStyle(fontSize: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text("Todos os Estados"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ResultsPage(inType: "estados", inQuery: ""),
                ));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.public_outlined),
                elevation: 16,
                style: const TextStyle(color: Colors.red),
                underline: Container(height: 2, color: Colors.redAccent),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: uf.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            ElevatedButton(
              child: Text("Pesquisar"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ResultsPage(inType: "estado", inQuery: dropdownValue),
                ));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text("Selecionar Data"),
              onPressed: () => _selectDate(context),
            ),
            ElevatedButton(
                child: Text("Pesquisar"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResultsPage(
                        inType: "data",
                        inQuery: selectedDate.year.toString() +
                            selectedDate.month.toString().padLeft(2, '0') +
                            selectedDate.day.toString().padLeft(2, '0')),
                  ));
                }),
          ],
        )
      ],
    )));
  }
}

class ConsultaOptions extends State<OptionsPage> {
  String dropdownValue = paises.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Selecione uma opção de consulta.",
            style: TextStyle(fontSize: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.public_outlined),
                elevation: 16,
                style: const TextStyle(color: Colors.red),
                underline: Container(height: 2, color: Colors.redAccent),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: paises.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            ElevatedButton(
              child: Text("Pesquisar"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ResultsPage(inType: "pais", inQuery: dropdownValue),
                ));
              },
            ),
          ],
        )
      ],
    )));
  }
}
