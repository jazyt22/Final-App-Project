// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Record {
//   late String _name;
//   late int _votes;
//   DocumentReference? reference;
//
//   Record.fromMap(Map<String, dynamic> map, {this.reference}) {
//     _name = map['name'];
//     _votes = map['votes'];
//   }
//
//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data() as Map<String, dynamic>,
//     reference: snapshot.reference,
//   );
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': _name,
//       'votes': _votes,
//     };
//   }
//
//   int get votes => _votes;
//
//   String get name => _name;
//
//   set votes(int value) {
//     _votes = value;
//     reference?.update(toJson());
//   }
// }



//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Record {
//   final String name;
//   int votes;
//   bool crossedOut;
//
//   Record({
//     required this.name,
//     required this.votes,
//     this.crossedOut = false, // Default value is false
//   });
//
//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : name = snapshot['name'],
//         votes = snapshot['votes'],
//         crossedOut = snapshot['crossedOut'] ?? false; // Default value is false
//
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'votes': votes,
//       'crossedOut': crossedOut,
//     };
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  late String _id;
  late String _name;
  late int _votes;
  late String _category;

  Record(this._id, this._name, this._votes, this._category);

  Record.fromMap(Map<String, dynamic> map, {String? id}) {
    _id = id!;
    _name = map['name'];
    _votes = map['votes'];
    _category = map['category'];
  }

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, id: snapshot.id);

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'votes': _votes,
      'category': _category,
    };
  }

  String get id => _id;

  String get name => _name;

  int get votes => _votes;

  String get category => _category;
}
