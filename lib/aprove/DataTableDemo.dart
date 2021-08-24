// import 'package:flutter/material.dart';
// import 'drugs.dart';
// import 'Services.dart';
// import 'dart:async';

// class DataTableDemo extends StatefulWidget {
//   //
//   DataTableDemo() : super();

//   final String title = 'Flutter Data Table';

//   @override
//   DataTableDemoState createState() => DataTableDemoState();
// }

// // Now we will write a class that will help in searching.
// // This is called a Debouncer class.
// // I have made other videos explaining about the debouncer classes
// // The link is provided in the description or tap the 'i' button on the right corner of the video.
// // The Debouncer class helps to add a delay to the search
// // that means when the class will wait for the user to stop for a defined time
// // and then start searching
// // So if the user is continuosly typing without any delay, it wont search
// // This helps to keep the app more performant and if the search is directly hitting the server
// // it keeps less hit on the server as well.
// // Lets write the Debouncer class

// class Debouncer {
//   Debouncer({this.milliseconds});

//   VoidCallback action;
//   final int milliseconds;

//   Timer _timer;

//   run(VoidCallback action) {
//     if (null != _timer) {
//       _timer
//           .cancel(); // when the user is continuosly typing, this cancels the timer
//     }
//     // then we will start a new timer looking for the user to stop
//     _timer = Timer(Duration(milliseconds: milliseconds), action);
//   }
// }

// class DataTableDemoState extends State<DataTableDemo> {
//   // This will wait for 500 milliseconds after the user has stopped typing.
//   // This puts less pressure on the device while searching.
//   // If the search is done on the server while typing, it keeps the
//   // server hit down, thereby improving the performance and conserving
//   // battery life...
//   final _debouncer = Debouncer(milliseconds: 2000);

//   List<drugs> _drugs;
//   // this list will hold the filtered drugs
//   List<drugs> _filterdrugs;

//   // controller for the First Name TextField we are going to create.
//   TextEditingController _firstNameController;

//   bool _isUpdating;
//   // controller for the Last Name TextField we are going to create.
//   TextEditingController _lastNameController;
//   TextEditingController _checkController;

//   GlobalKey<ScaffoldState> _scaffoldKey;
//   drugs _selecteddrugs;
//   String _titleProgress;

//   // Lets increase the time to wait and search to 2 seconds.
//   // So now its searching after 2 seconds when the user stops typing...
//   // That's how we can do filtering in Flutter DataTables.

//   @override
//   void initState() {
//     super.initState();
//     _drugs = [];
//     _filterdrugs = [];
//     _isUpdating = false;
//     _titleProgress = widget.title;
//     _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
//     _firstNameController = TextEditingController();
//     _lastNameController = TextEditingController();
//     _checkController = TextEditingController();
//     _getdrugs();
//   }

//   // Method to update title in the AppBar Title
//   _showProgress(String message) {
//     setState(() {
//       _titleProgress = message;
//     });
//   }
  

//   _showSnackBar(context, message) {
    
//     ScaffoldMessenger.of(context).showSnackBar(
//      SnackBar(
//           content:Text(message),
//           duration: Duration(seconds: 2),
//     ),
// );
    
//   }


//   // Now lets add an drugs
//   _adddrugs() {
//     if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
//       print('Empty Fields');
//       return;
//     }
//     _showProgress('Adding drugs...');
//     Services.adddrugs(_firstNameController.text, _lastNameController.text,_checkController.text)
//         .then((result) {
//       if ('success' == result) {
//         _getdrugs(); // Refresh the List after adding each drugs...
//         _clearValues();
//       }
//     });
//   }

//   _getdrugs() {
//     _showProgress('Loading drugs...');
//     Services.getdrugs().then((drugs) {
//       setState(() {
//         _drugs = drugs;
//         // Initialize to the list from Server when reloading...
//         _filterdrugs = drugs;
//       });
//       _showProgress(widget.title); // Reset the title...
//       print("Length ${drugs.length}");
//     });
//   }

//   _updatedrugs(drugs drugs) {
//     setState(() {
//       _isUpdating = true;
//     });
//     _showProgress('Updating drugs...');
//     Services.updatedrugs(
//             drugs.id, _firstNameController.text, _lastNameController.text,_checkController.text)
//         .then((result) {
//       if ('success' == result) {
//         _getdrugs(); // Refresh the list after update
//         setState(() {
//           _isUpdating = false;
//         });
//         _clearValues();
//       }
//     });
//   }

//   _deletedrugs(drugs drugs) {
//     _showProgress('Deleting drugs...');
//     Services.deletedrugs(drugs.id).then((result) {
//       if ('success' == result) {
//         _getdrugs(); // Refresh after delete...
//       }
//     });
//   }

//   // Method to clear TextField values
//   _clearValues() {
//     _firstNameController.text = '';
//     _lastNameController.text = '';
//   }

//   _showValues(drugs drugs) {
//     _firstNameController.text = drugs.firstName;
//     _lastNameController.text = drugs.lastName;
//   }

// // Since the server is running locally you may not
// // see the progress in the titlebar, its so fast...
// // :)

//   // Let's create a DataTable and show the drugs list in it.
//   SingleChildScrollView _dataBody() {
//     // Both Vertical and Horozontal Scrollview for the DataTable to
//     // scroll both Vertical and Horizontal...
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DataTable(
//           columns: [
//             DataColumn(
//               label: Text('ID'),
//             ),
//             DataColumn(
//               label: Text('FIRST NAME'),
//             ),
//             DataColumn(
//               label: Text('LAST NAME'),
//             ),
//             DataColumn(
//               label: Text('Check'),
//             ),
//             // Lets add one more column to show a delete button
//             DataColumn(
//               label: Text('DELETE'),
//             )
//           ],
//           // the list should show the filtered list now
//           rows: _filterdrugs
//               .map(
//                 (drugs) => DataRow(cells: [
//                   DataCell(
//                     Text(drugs.id),
//                     // Add tap in the row and populate the
//                     // textfields with the corresponding values to update
//                     onTap: () {
//                       _showValues(drugs);
//                       // Set the Selected drugs to Update
//                       _selecteddrugs = drugs;
//                       setState(() {
//                         _isUpdating = true;
//                       });
//                     },
//                   ),
//                   DataCell(
//                     Text(
//                       drugs.firstName.toUpperCase(),
//                     ),
//                     onTap: () {
//                       _showValues(drugs);
//                       // Set the Selected drugs to Update
//                       _selecteddrugs = drugs;
//                       // Set flag updating to true to indicate in Update Mode
//                       setState(() {
//                         _isUpdating = true;
//                       });
//                     },
//                   ),
//                   DataCell(
//                     Text(
//                       drugs.lastName.toUpperCase(),
//                     ),
//                     onTap: () {
//                       _showValues(drugs);
//                       // Set the Selected drugs to Update
//                       _selecteddrugs = drugs;
//                       setState(() {
//                         _isUpdating = true;
//                       });
//                     },
//                   ),
//                   DataCell(
//                     Text(
//                       drugs.Check.toUpperCase(),
//                     ),
                    
//                   ),
//                   DataCell(IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       _deletedrugs(drugs);
//                     },
//                   ))
//                 ]),
//               )
//               .toList(),
//         ),
//       ),
//     );
//   }

//   // Let's add a searchfield to search in the DataTable.
//   searchField() {
//     return Padding(
//       padding: EdgeInsets.all(20.0),
//       child: TextField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.all(5.0),
//           hintText: 'Filter by First name or Last name',
//         ),
//         onChanged: (string) {
//           // We will start filtering when the user types in the textfield.
//           // Run the debouncer and start searching
//           _debouncer.run(() {
//             // Filter the original List and update the Filter list
//             setState(() {
//               _filterdrugs = _drugs
//                   .where((u) => (u.firstName
//                           .toLowerCase()
//                           .contains(string.toLowerCase()) ||
//                       u.lastName.toLowerCase().contains(string.toLowerCase())))
//                   .toList();
//             });
//           });
//         },
//       ),
//     );
//   }

//   // id is coming as String
//   // So let's update the model...

//   // UI
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text(_titleProgress), // we show the progress in the title...
//         actions: <Widget>[
          
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               _getdrugs();
//             },
//           )
//         ],
//       ),
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(20.0),
//               child: TextField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration.collapsed(
//                   hintText: 'First Name',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(20.0),
//               child: TextField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration.collapsed(
//                   hintText: 'Last Name',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(20.0),
//               child: TextField(
//                 controller: _checkController,
//                 decoration: InputDecoration.collapsed(
//                   hintText: 'check',
//                 ),
//               ),
//             ),

            

//             // Add an update button and a Cancel Button
//             // show these buttons only when updating an drugs
//             _isUpdating
//                 ? Row(
//                     children: <Widget>[
//                       OutlinedButton(
//                         child: Text('UPDATE'),
//                         onPressed: () {
//                           _updatedrugs(_selecteddrugs);
//                         },
//                       ),
//                       OutlinedButton(
//                         child: Text('CANCEL'),
//                         onPressed: () {
//                           setState(() {
//                             _isUpdating = false;
//                           });
//                           _clearValues();
//                         },
//                       ),
//                     ],
//                   )
//                 : Container(),
//             searchField(),
//             Expanded(
//               child: _dataBody(),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _adddrugs();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
