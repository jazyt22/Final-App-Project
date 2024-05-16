// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../model/record.dart';
// //
// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key});
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   late List<Record>? records;
// //   int newVotes = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Baby Name Votes'),
// //       ),
// //       body: _buildBody(),
// //     );
// //   }
// //
// //   Widget _buildBody() {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: FirebaseFirestore.instance.collection('baby').snapshots(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return LinearProgressIndicator();
// //
// //         records = [];
// //         for (DocumentSnapshot doc in snapshot.data!.docs) {
// //           if (records != null) {
// //             records!.add(Record.fromSnapshot(doc));
// //           }
// //         }
// //         return _buildList(records ?? []);
// //       },
// //     );
// //   }
// //
// //   Widget _buildList(List<Record> records) {
// //     return ListView.builder(
// //       itemCount: records.length,
// //       itemBuilder: (context, index) {
// //         return InkWell(
// //           onTap: (){
// //             newVotes = records[index].votes;
// //             records[index].votes = newVotes+1;
// //           },
// //           child: Container(
// //             margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
// //             decoration: BoxDecoration(
// //               border: Border.all(width: 1,color: Colors.grey),
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: ListTile(
// //               title: Text(records[index].name),
// //               trailing: Text("${records[index].votes}"),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../model/record.dart';
// //
// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   late List<Record>? records;
// //   late TextEditingController _nameController;
// //   late TextEditingController _quantityController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _nameController = TextEditingController();
// //     _quantityController = TextEditingController();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Baby Name Votes'),
// //       ),
// //       body: Column(
// //         children: [
// //           _buildBody(),
// //           _buildAddUserTextField(),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildBody() {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: FirebaseFirestore.instance.collection('baby').snapshots(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return LinearProgressIndicator();
// //
// //         records = [];
// //         for (DocumentSnapshot doc in snapshot.data!.docs) {
// //           if (records != null) {
// //             records!.add(Record.fromSnapshot(doc));
// //           }
// //         }
// //         return _buildList(records ?? []);
// //       },
// //     );
// //   }
// //
// //   Widget _buildList(List<Record> records) {
// //     return Expanded(
// //       child: ListView.builder(
// //         itemCount: records.length,
// //         itemBuilder: (context, index) {
// //           return InkWell(
// //             onTap: () {
// //               _promptForQuantity(records[index]);
// //             },
// //             child: Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// //               decoration: BoxDecoration(
// //                 border: Border.all(width: 1, color: Colors.grey),
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: ListTile(
// //                 title: Text(records[index].name),
// //                 trailing: Text("${records[index].votes}"),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   void _promptForQuantity(Record record) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text("Enter Quantity"),
// //           content: TextField(
// //             controller: _quantityController,
// //             keyboardType: TextInputType.number,
// //             decoration: InputDecoration(hintText: "Quantity"),
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               child: Text("Submit"),
// //               onPressed: () {
// //                 int quantity = int.tryParse(_quantityController.text) ?? 0;
// //                 if (quantity > 0) {
// //                   _incrementVotes(record, quantity);
// //                 }
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _buildAddUserTextField() {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: TextField(
// //               controller: _nameController,
// //               decoration: InputDecoration(
// //                 hintText: 'Enter name',
// //               ),
// //             ),
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.add),
// //             onPressed: () {
// //               _addUser(_nameController.text);
// //               _nameController.clear();
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void _addUser(String name) async {
// //     try {
// //       await FirebaseFirestore.instance.collection('baby').doc(name).set({
// //         'name': name,
// //         'votes': 0,
// //       });
// //     } catch (e) {
// //       print('Error adding user: $e');
// //     }
// //   }
// //
// //   void _incrementVotes(Record record, int quantity) async {
// //     try {
// //       record.votes += quantity; // Increment votes locally
// //       await record.reference!.update({'votes': record.votes}); // Update votes in Firestore
// //     } catch (e) {
// //       print('Error updating votes: $e');
// //     }
// //   }
// // }
//
//
//
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../model/record.dart';
// //
// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   late List<Record>? records;
// //   late TextEditingController _nameController;
// //   late TextEditingController _quantityController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _nameController = TextEditingController();
// //     _quantityController = TextEditingController();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Baby Name Votes'),
// //       ),
// //       body: Column(
// //         children: [
// //           _buildBody(),
// //           _buildAddUserTextField(),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildBody() {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: FirebaseFirestore.instance.collection('baby').snapshots(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return LinearProgressIndicator();
// //
// //         records = [];
// //         for (DocumentSnapshot doc in snapshot.data!.docs) {
// //           if (records != null) {
// //             records!.add(Record.fromSnapshot(doc));
// //           }
// //         }
// //         return _buildList(records ?? []);
// //       },
// //     );
// //   }
// //
// //   Widget _buildList(List<Record> records) {
// //     return Expanded(
// //       child: ListView.builder(
// //         itemCount: records.length,
// //         itemBuilder: (context, index) {
// //           return Dismissible(
// //             key: UniqueKey(),
// //             onDismissed: (direction) {
// //               _deleteRecord(records[index]);
// //             },
// //             direction: DismissDirection.endToStart,
// //             background: Container(
// //               alignment: Alignment.centerRight,
// //               padding: EdgeInsets.only(right: 20.0),
// //               color: Colors.red,
// //               child: Icon(
// //                 Icons.delete,
// //                 color: Colors.white,
// //               ),
// //             ),
// //             child: ListTile(
// //               onTap: () {
// //                 _promptForQuantity(records[index]);
// //               },
// //               title: Text(records[index].name),
// //               trailing: Text("${records[index].votes}"),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   void _promptForQuantity(Record record) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text("Enter Quantity"),
// //           content: TextField(
// //             controller: _quantityController,
// //             keyboardType: TextInputType.number,
// //             decoration: InputDecoration(hintText: "Quantity"),
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               child: Text("Submit"),
// //               onPressed: () {
// //                 int quantity = int.tryParse(_quantityController.text) ?? 0;
// //                 if (quantity > 0) {
// //                   _incrementVotes(record, quantity);
// //                 }
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _buildAddUserTextField() {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: TextField(
// //               controller: _nameController,
// //               decoration: InputDecoration(
// //                 hintText: 'Enter name',
// //               ),
// //             ),
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.add),
// //             onPressed: () {
// //               _addUser(_nameController.text);
// //               _nameController.clear();
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void _addUser(String name) async {
// //     try {
// //       await FirebaseFirestore.instance.collection('baby').doc(name).set({
// //         'name': name,
// //         'votes': 0,
// //       });
// //     } catch (e) {
// //       print('Error adding user: $e');
// //     }
// //   }
// //
// //   void _incrementVotes(Record record, int quantity) async {
// //     try {
// //       record.votes += quantity; // Increment votes locally
// //       await record.reference!.update({'votes': record.votes}); // Update votes in Firestore
// //     } catch (e) {
// //       print('Error updating votes: $e');
// //     }
// //   }
// //
// //   void _deleteRecord(Record record) async {
// //     try {
// //       await record.reference!.delete();
// //     } catch (e) {
// //       print('Error deleting record: $e');
// //     }
// //   }
// // }
//
//
//
//
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../model/record.dart';
// //
// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   late TextEditingController _nameController;
// //   late TextEditingController _quantityController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _nameController = TextEditingController();
// //     _quantityController = TextEditingController();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Grocery List'),
// //       ),
// //       body: Column(
// //         children: [
// //           _buildBody(),
// //           _buildAddUserTextField(),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildBody() {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: FirebaseFirestore.instance.collection('baby').snapshots(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return LinearProgressIndicator();
// //
// //         List<Record> records = [];
// //         for (DocumentSnapshot doc in snapshot.data!.docs) {
// //           records.add(Record.fromSnapshot(doc));
// //         }
// //         return _buildList(records);
// //       },
// //     );
// //   }
// //
// //   Widget _buildList(List<Record> records) {
// //     return Expanded(
// //       child: ListView.builder(
// //         itemCount: records.length,
// //         itemBuilder: (context, index) {
// //           return GestureDetector(
// //             onTap: () {
// //               _editRecord(context, records[index]);
// //             },
// //             child: Dismissible(
// //               key: UniqueKey(),
// //               onDismissed: (direction) {
// //                 _deleteRecord(records[index]);
// //               },
// //               direction: DismissDirection.endToStart,
// //               background: Container(
// //                 alignment: Alignment.centerRight,
// //                 padding: EdgeInsets.only(right: 20.0),
// //                 color: Colors.red,
// //                 child: Icon(
// //                   Icons.delete,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //               child: ListTile(
// //                 title: Text(records[index].name),
// //                 trailing: Text("${records[index].votes}"),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   void _editRecord(BuildContext context, Record record) {
// //     _nameController.text = record.name;
// //     _quantityController.text = record.votes.toString();
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text("Edit Item"),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: <Widget>[
// //               TextField(
// //                 controller: _nameController,
// //                 decoration: InputDecoration(labelText: 'Name'),
// //               ),
// //               TextField(
// //                 controller: _quantityController,
// //                 keyboardType: TextInputType.number,
// //                 decoration: InputDecoration(labelText: 'Quantity'),
// //               ),
// //             ],
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 _updateRecord(record.id, _nameController.text, int.tryParse(_quantityController.text) ?? 0);
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('Save'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _buildAddUserTextField() {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: TextField(
// //               controller: _nameController,
// //               decoration: InputDecoration(
// //                 hintText: 'Enter name',
// //               ),
// //             ),
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.add),
// //             onPressed: () {
// //               _addUser(_nameController.text);
// //               _nameController.clear();
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void _addUser(String name) async {
// //     try {
// //       await FirebaseFirestore.instance.collection('baby').doc(name).set({
// //         'name': name,
// //         'votes': 0,
// //       });
// //     } catch (e) {
// //       print('Error adding user: $e');
// //     }
// //   }
// //
// //   void _updateRecord(String id, String name, int votes) async {
// //     try {
// //       await FirebaseFirestore.instance.collection('baby').doc(id).update({'name': name, 'votes': votes});
// //     } catch (e) {
// //       print('Error updating record: $e');
// //     }
// //   }
// //
// //   void _deleteRecord(Record record) async {
// //     try {
// //       await FirebaseFirestore.instance.collection('baby').doc(record.id).delete();
// //     } catch (e) {
// //       print('Error deleting record: $e');
// //     }
// //   }
// // }
//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../model/record.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late TextEditingController _nameController;
//   late TextEditingController _quantityController;
//   late TextEditingController _categoryController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     _quantityController = TextEditingController();
//     _categoryController = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Grocery List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('baby').orderBy('category').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return LinearProgressIndicator();
//
//           final records = snapshot.data!.docs.map((doc) => Record.fromSnapshot(doc)).toList();
//
//           // Group records by category
//           Map<String, List<Record>> groupedRecords = {};
//           for (var record in records) {
//             if (!groupedRecords.containsKey(record.category)) {
//               groupedRecords[record.category] = [];
//             }
//             groupedRecords[record.category]!.add(record);
//           }
//
//           return ListView.builder(
//             itemCount: groupedRecords.length,
//             itemBuilder: (context, index) {
//               final category = groupedRecords.keys.toList()[index];
//               final items = groupedRecords[category]!;
//
//               return Card(
//                 margin: EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         category,
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Column(
//                       children: items.map((item) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                           child: ListTile(
//                             title: Text(
//                               item.name,
//                               style: TextStyle(fontSize: 18.0),
//                             ),
//                             subtitle: Text('Votes: ${item.votes}'),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.edit),
//                                   onPressed: () => _showEditDialog(context, item),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.delete),
//                                   onPressed: () => _deleteItem(item),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddDialog(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _showAddDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Add Item"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: _categoryController,
//                 decoration: InputDecoration(labelText: 'Category'),
//               ),
//               TextField(
//                 controller: _quantityController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Quantity'),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _addItem(_nameController.text, _categoryController.text, int.tryParse(_quantityController.text) ?? 0);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showEditDialog(BuildContext context, Record item) {
//     _nameController.text = item.name;
//     _categoryController.text = item.category;
//     _quantityController.text = item.votes.toString();
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Edit Item"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: _categoryController,
//                 decoration: InputDecoration(labelText: 'Category'),
//               ),
//               TextField(
//                 controller: _quantityController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Quantity'),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _updateItem(item, _nameController.text, _categoryController.text, int.tryParse(_quantityController.text) ?? 0);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _addItem(String name, String category, int quantity) async {
//     try {
//       await FirebaseFirestore.instance.collection('baby').doc(name).set({
//         'name': name,
//         'category': category,
//         'votes': quantity,
//       });
//     } catch (e) {
//       print('Error adding item: $e');
//     }
//   }
//
//   void _updateItem(Record item, String name, String category, int quantity) async {
//     try {
//       await FirebaseFirestore.instance.collection('baby').doc(item.id).update({
//         'name': name,
//         'category': category,
//         'votes': quantity,
//       });
//     } catch (e) {
//       print('Error updating item: $e');
//     }
//   }
//
//   void _deleteItem(Record item) async {
//     try {
//       await FirebaseFirestore.instance.collection('baby').doc(item.id).delete();
//     } catch (e) {
//       print('Error deleting item: $e');
//     }
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/record.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _categoryController;
  late TextEditingController _searchController;
  String _selectedCategory = 'All';
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _quantityController = TextEditingController();
    _categoryController = TextEditingController();
    _searchController = TextEditingController();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('baby').get();
      final List<String> categories = snapshot.docs.map((doc) => doc['category'] as String).toSet().toList();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grocery List',
          textAlign: TextAlign.center, // Center align the text
        ),
        centerTitle: true, // Center the title
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by Item Name',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: _buildCategoryDropdownItems(),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('baby').orderBy('category').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();

                final records = snapshot.data!.docs.map((doc) => Record.fromSnapshot(doc)).toList();

                var filteredRecords = records;
                if (_searchController.text.isNotEmpty) {
                  filteredRecords = filteredRecords
                      .where((record) => record.name.toLowerCase().contains(_searchController.text.toLowerCase()))
                      .toList();
                }
                if (_selectedCategory != 'All') {
                  filteredRecords =
                      filteredRecords.where((record) => record.category == _selectedCategory).toList();
                }

                Map<String, List<Record>> groupedRecords = {};
                for (var record in filteredRecords) {
                  if (!groupedRecords.containsKey(record.category)) {
                    groupedRecords[record.category] = [];
                  }
                  groupedRecords[record.category]!.add(record);
                }

                return ListView.builder(
                  itemCount: groupedRecords.length,
                  itemBuilder: (context, index) {
                    final category = groupedRecords.keys.toList()[index];
                    final items = groupedRecords[category]!;

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Column(
                            children: items.map((item) {
                              return ListTile(
                                title: Text(
                                  item.name,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                subtitle: Text('Votes: ${item.votes}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.green),
                                      onPressed: () => _showEditDialog(context, item),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _deleteItem(item),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildCategoryDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    dropdownItems.add(DropdownMenuItem<String>(
      value: 'All',
      child: Text('All'),
    ));
    dropdownItems.addAll(_categories.map((category) => DropdownMenuItem<String>(
      value: category,
      child: Text(category),
    )));
    return dropdownItems;
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addItem(_nameController.text, _categoryController.text, int.tryParse(_quantityController.text) ?? 0);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Record item) {
    _nameController.text = item.name;
    _categoryController.text = item.category;
    _quantityController.text = item.votes.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateItem(item, _nameController.text, _categoryController.text, int.tryParse(_quantityController.text) ?? 0);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addItem(String name, String category, int quantity) async {
    try {
      await FirebaseFirestore.instance.collection('baby').doc(name).set({
        'name': name,
        'category': category,
        'votes': quantity,
      });
    } catch (e) {
      print('Error adding item: $e');
    }
  }

  void _updateItem(Record item, String name, String category, int quantity) async {
    try {
      await FirebaseFirestore.instance.collection('baby').doc(item.id).update({
        'name': name,
        'category': category,
        'votes': quantity,
      });
    } catch (e) {
      print('Error updating item: $e');
    }
  }

  void _deleteItem(Record item) async {
    try {
      await FirebaseFirestore.instance.collection('baby').doc(item.id).delete();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }
}

