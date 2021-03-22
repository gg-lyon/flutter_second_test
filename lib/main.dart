import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'History.dart';
import 'NumberOutput.dart';
import 'generateAPI.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Generation',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Random Number Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<NumberOutput> futureNumberGenerator;
  int output;
  List<int> previousValues = [];
  Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
  Date date;

  @override
  void initState() {
    super.initState();
    futureNumberGenerator = fetchNumberGenerator();
  }

  @override
  Widget build(BuildContext context) {

    CollectionReference ref = FirebaseFirestore.instance.collection('randomnumbers');
    return Scaffold(

      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Column(
        children: [
          RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => History()),
                );
              },
              child: Text('History Page')
          ),
          Center(

              child: FutureBuilder<FirebaseApp>(
                  future: firebaseApp,
                  builder: (context, AsyncSnapshot<FirebaseApp> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading Firebase");
                    }
                    return Column(children: [

                      //FutureBuilder<QuerySnapshot>(
                          //future: ref.get(),
                      FutureBuilder<NumberOutput>(
                          future: futureNumberGenerator,
                          builder: (context,  AsyncSnapshot<NumberOutput> snapshot) {
                            if (snapshot.hasData) {
                              previousValues.add(snapshot.data.randomNumber);
                              Map<String, int> document = Map();
                              document["randomNumber"] = snapshot.data.randomNumber;
                              ref.add(document);
                              return Column(
                                children: [
                                  RaisedButton(
                                    child: Text("Get a new random number"),
                                    onPressed:
                                    snapshot.connectionState == ConnectionState.waiting ? null : () async{
                                      setState(() {
                                        futureNumberGenerator = fetchNumberGenerator();
                                      });
                                      date.dateTime = DateTime.now();
                                      //Map<String, int> document = Map();
                                      //document["dateTime"] = snapshot.data.dateTime;
                                      //ref.doc();
                                      },
                                    color: Colors.lightBlue,
                                  ),
                                  Text('output'),
                                  Column(children: previousValues.map((e) {
                                    return Text(e.toString());
                                  }).toList()),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            return CircularProgressIndicator();
                          }
                      )
                    ],);
                  }
              )
          ),
        ],
      ),
    );
  }
}
