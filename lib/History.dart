import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CollectionReference ref = FirebaseFirestore.instance.collection('randomnumbers');
    return Scaffold(
      appBar: AppBar(
        title: Text("History Page"),
      ),
      body: Column(
          children: [
            Text("Previous Values"),
            FutureBuilder<QuerySnapshot>(
              future: ref.get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData){
                  return Container();
                }
                return Column(
                );
              }
            )
          ]
      ),

    );
  }


}