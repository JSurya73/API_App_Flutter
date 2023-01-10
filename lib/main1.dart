import 'dart:io';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

var stringResponse;
Map? MapResponse;
List? ListResponse;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode != null) {
      setState(() {
        MapResponse = json.decode(response.body);
        ListResponse = (MapResponse as dynamic)['data'];
        print(response.body.toString());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("API Application")),
        body: Center(
            child: Container(
          height: 400,
          width: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.redAccent),
          child: Center(
              child: ListResponse == null
                  ? const Text("Information is loading")
                  : Text((ListResponse as dynamic)[0].toString())),
        )),
      ),
    );
  }
}
