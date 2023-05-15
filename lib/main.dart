import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:interview_test/Userdetailscreen.dart';
import 'package:interview_test/pojo/Userdatapojo.dart';
import 'package:interview_test/utils/Network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Interview test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Userdatapojo? userdatapojo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child : FutureBuilder<List<Userdatapojo>>(
          future: getuserdata(),
          builder: (context, snapshot) {
            print("snapshot");
            print(snapshot.data);
            if (snapshot.hasData) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder:  (BuildContext context, int i){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Userdetailscreen(id: snapshot.data![i].id!.toInt(),)));
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(snapshot.data![i].name.toString(),),
                                    Text(snapshot.data![i].email.toString(),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  )
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Future<List<Userdatapojo>> getuserdata() async {
    var response = await http.get(
      Uri.parse(Network.baseurl+Network.users),
    );
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Userdatapojo.fromJson(job)).toList();
  }


}
