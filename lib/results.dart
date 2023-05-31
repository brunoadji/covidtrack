import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResultsPage extends StatelessWidget {
  final String inType;
  final String inQuery;

  const ResultsPage({super.key, required this.inType, required this.inQuery});

  Future<Map> getResults(String type, String query) async {
    String url = "https://covid19-brazil-api.now.sh/api/report/v1/";
    switch (type) {
      case "paises":
        {
          url = url + "countries";
        }
        break;
      case "pais":
        {
          url = url + query;
        }
        break;
      case "estados":
        {
          url = url;
        }
        break;
      case "estado":
        {
          url = url + "brazil/uf/" + query;
        }
        break;
      case "data":
        {
          url = url + "brazil/" + query;
        }
        break;
      default:
        {
          print("This shouldn't happen...");
        }
        break;
    }
    print(url);
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Resultado da Pesquisa"),
        ),
        body: Center(
            child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: FutureBuilder<Map>(
                    future: getResults(this.inType, this.inQuery),
                    builder: ((context, snapshot) {
                      int cases = 0,
                          confirmed = 0,
                          deaths = 0,
                          recovered = 0,
                          aux;
                      if (snapshot.hasData) {
                        if (snapshot.data?["data"] is List) {
                          for (int i = 0;
                              i < snapshot.data?["data"].length;
                              i++) {
                            aux = snapshot.data?["data"][i]?["cases"] ?? 0;
                            cases += aux;
                            aux = snapshot.data?["data"][i]?["confirmed"] ?? 0;
                            confirmed += aux;
                            aux = snapshot.data?["data"][i]?["deaths"] ?? 0;
                            deaths += aux;
                            aux = snapshot.data?["data"][i]?["recovered"] ?? 0;
                            recovered += aux;
                          }
                        } else if (snapshot.data?["data"] != null) {
                          aux = snapshot.data?["data"]?["cases"] ?? -1;
                          cases = aux;
                          aux = snapshot.data?["data"]?["confirmed"] ?? -1;
                          confirmed = aux;
                          aux = snapshot.data?["data"]?["deaths"] ?? -1;
                          deaths = aux;
                          aux = snapshot.data?["data"]?["recovered"] ?? -1;
                          recovered = aux;
                        } else {
                          aux = snapshot.data?["cases"] ?? -1;
                          cases = aux;
                          aux = snapshot.data?["confirmed"] ?? -1;
                          confirmed = aux;
                          aux = snapshot.data?["deaths"] ?? -1;
                          deaths = aux;
                          aux = snapshot.data?["recovered"] ?? -1;
                          recovered = aux;
                        }
                      } else if (snapshot.hasError) {
                        return const Text(
                          "Ocorreu um erro, tente novamente mais tarde.",
                          style: TextStyle(fontSize: 50),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tabela de Dados",
                              style: TextStyle(fontSize: 40)),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Table(
                                  border: TableBorder.symmetric(
                                      inside: BorderSide(width: 2)),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: <TableRow>[
                                    TableRow(children: <TableCell>[
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Container(
                                              height: 100,
                                              width: 160,
                                              color: Colors.amberAccent,
                                              child: Center(
                                                  child: Text("Caso(s)",
                                                      style: TextStyle(
                                                          fontSize: 20))))),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Container(
                                              height: 100,
                                              width: 160,
                                              color: Colors.black12,
                                              child: Center(
                                                  child: Text(cases.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16))))),
                                    ]),
                                    TableRow(children: <TableCell>[
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Container(
                                              height: 100,
                                              width: 160,
                                              color: Colors.amberAccent,
                                              child: Center(
                                                  child: Text("Confirmado(s)",
                                                      style: TextStyle(
                                                          fontSize: 20))))),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Container(
                                              height: 100,
                                              width: 160,
                                              color: Colors.black12,
                                              child: Center(
                                                  child: Text(
                                                      confirmed.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16))))),
                                    ]),
                                    TableRow(children: <TableCell>[
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Container(
                                              height: 100,
                                              width: 160,
                                              color: Colors.amberAccent,
                                              child: Center(
                                                  child: Text("Morte(s)",
                                                      style: TextStyle(
                                                          fontSize: 20))))),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Container(
                                              height: 100,
                                              width: 160,
                                              color: Colors.black12,
                                              child: Center(
                                                  child: Text(deaths.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16))))),
                                    ]),
                                    TableRow(children: <TableCell>[
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Container(
                                              height: 100,
                                              width: 160,
                                              color: Colors.amberAccent,
                                              child: Center(
                                                  child: Text("Recuperado(s)",
                                                      style: TextStyle(
                                                          fontSize: 20))))),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Container(
                                              height: 100,
                                              width: 160,
                                              color: Colors.black12,
                                              child: Center(
                                                  child: Text(
                                                      recovered.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16))))),
                                    ]),
                                  ]))
                        ],
                      );
                    })))));
  }
}
