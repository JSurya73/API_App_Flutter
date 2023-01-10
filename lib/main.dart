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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              child: Center(
                child: Column(children: [
                  Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.lightBlue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                              (ListResponse as dynamic)[index]["avatar"]),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                  "Id: ${(ListResponse as dynamic)[index]['id']}",
                                  style: TextStyle(color: Colors.white)),
                              Text(
                                "Name: ${(ListResponse as dynamic)[index]['first_name']}" +
                                    " " +
                                    "${(ListResponse as dynamic)[index]['last_name']}",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                  "Email: ${(ListResponse as dynamic)[index]['email']}",
                                  style: TextStyle(color: Colors.white)),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ]),
              ),
            ),
          );
        },
        itemCount: ListResponse == null ? 0 : (ListResponse as dynamic).length,
      ),
    ));
  }
}
