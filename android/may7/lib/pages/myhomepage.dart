import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/record.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Record> records;
  int newVotes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Name Votes'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('may5').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();

        records = [];
        for (DocumentSnapshot doc in snapshot.data!.docs) {
          records.add(Record.fromSnapshot(doc));
        }
        return _buildList(records);
      },
    );
  }

  Widget _buildList(List<Record> records) {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            newVotes = records[index].votes;
            records[index].votes = newVotes+1;
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(records[index].name),
              trailing: Text("${records[index].votes}"),
            ),
          ),
        );
      },
    );
  }
}