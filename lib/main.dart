import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // ignore: no_leading_underscores_for_local_identifiers
  List _data = await getJson();
  debugPrint(
      _data[1]["id"].toString()); // Convert list to a string before printing

  // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
  String _body = "";

  for (int i = 0; i < _data.length; i++) {
    debugPrint("Title: ${_data[i]["title"]}");
    debugPrint("Body: ${_data[i]["body"]}");
  }

  _body = _data[0]["body"];

  runApp(
    MaterialApp(
      title: "JSON Parsing",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("JSON Parsing"),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: _data.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd) return const Divider();

                final index = position ~/ 2; //we are dividing position by 2
                // and returning an integer rersult
                return ListTile(
                    title: Text(
                      (_data[index]["title"]),
                      style: const TextStyle(fontSize: 14.9),
                    ),
                    subtitle: Text(
                      _data[index]["body"],
                      style: const TextStyle(
                          fontSize: 13.4,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        (_data[index]["title"][0].toString().toUpperCase()),
                        style: const TextStyle(
                            fontSize: 19.4, color: Colors.orangeAccent),
                      ),
                    ),
                    onTap: () {
                      _showOnTapMessage(
                        context,
                        (_data[index]["title"]),
                      );
                    });
              }),
        ),
      ),
    ),
  );
}

Future<List> getJson() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  http.Response response = await http.get(Uri.parse(apiUrl));
  return json.decode(response.body);
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: const Text(
      "App",
    ),
    content: Text(message),
    actions: [
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK"))
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
