import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  late String _name;
  late int _votes;
  DocumentReference? reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference}) {
    _name = map['name'];
    _votes = map['votes'];
  }

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
    snapshot.data() as Map<String, dynamic>,
    reference: snapshot.reference,
  );

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'votes': _votes,
    };
  }

  int get votes => _votes;

  String get name => _name;

  set votes(int value) {
    _votes = value;
    reference?.update(toJson());
  }
}