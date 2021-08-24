import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mywork/global/global.dart';
import 'druglist.dart';
import 'serv.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
class DataTable1 extends StatefulWidget {
  //
  DataTable1() : super();

  final String title = 'Drug Data Table';

  @override
  DataTable1State createState() => DataTable1State();
}

// Now we will write a class that will help in searching.
// This is called a Debouncer class.
// I have made other videos explaining about the debouncer classes
// The link is provided in the description or tap the 'i' button on the right corner of the video.
// The Debouncer class helps to add a delay to the search
// that means when the class will wait for the user to stop for a defined time
// and then start searching
// So if the user is continuosly typing without any delay, it wont search
// This helps to keep the app more performant and if the search is directly hitting the server
// it keeps less hit on the server as well.
// Lets write the Debouncer class

class Debouncer {
  Debouncer({this.milliseconds});

  VoidCallback action;
  final int milliseconds;

  Timer _timer;

  run(VoidCallback action) {
    if (null != _timer) {
      _timer
          .cancel(); // when the user is continuosly typing, this cancels the timer
    }
    // then we will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class DataTable1State extends State<DataTable1> {
  // This will wait for 500 milliseconds after the user has stopped typing.
  // This puts less pressure on the device while searching.
  // If the search is done on the server while typing, it keeps the
  // server hit down, thereby improving the performance and conserving
  // battery life...
  final _debouncer = Debouncer(milliseconds: 2000);

  List<Drug> _drugs;
  // this list will hold the filtered drugs
  List<Drug> _filterdrugs;

  // controller for the First Name TextField we are going to create.
  TextEditingController _drugNameController =TextEditingController();
  TextEditingController _priceController=TextEditingController();
  TextEditingController _avalController=TextEditingController();

  bool _isUpdating;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _drugFamilyController;
  TextEditingController _descriptionController;

  GlobalKey<ScaffoldState> _scaffoldKey;
  Drug _selecteddrug;
  String _titleProgress;

  // Lets increase the time to wait and search to 2 seconds.
  // So now its searching after 2 seconds when the user stops typing...
  // That's how we can do filtering in Flutter DataTables.

  @override
  void initState() {
    super.initState();
    _drugs = [];
    _filterdrugs = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _drugNameController = TextEditingController();
    _drugFamilyController = TextEditingController();
    _descriptionController = TextEditingController();
    _getdrugs();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }
  

  _showSnackBar(context, message) {
    
    ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
          content:Text(message),
          duration: Duration(seconds: 2),
    ),
);
    
  }


 

  _getdrugs() {
    _showProgress('Loading Drugs...');
    Services.getdrugs().then((drugs) {
      setState(() {
        _drugs = drugs;
        // Initialize to the list from Server when reloading...
        _filterdrugs = drugs;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${drugs.length}");
    });
  }

  

  // Method to clear TextField values
  _clearValues() {
    _drugNameController.text = '';
    _drugFamilyController.text = '';
    _descriptionController.text = '';
  }

  _showValues(Drug drug) {
    _drugNameController.text = drug.drugName;
    _drugFamilyController.text = drug.drugFamily;
    _descriptionController.text = drug.description;
  }

///
 bool _validate = false;
Future register() async {
    if(_validate==true)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("fill the form!"),
    ));
    }
    else{
      debugPrint(_avalController.text);
      var url = "http://localhost/login/pharmadddrug.php";
    var response = await http.post(Uri.parse(url), body: {
      "price": _priceController.text,
      "Avalability": _avalController.text,
      "Pharmaid": pharmaid,
      "DrugName": _selecteddrug.drugName,
      "DrugID": _selecteddrug.id,
      
    });
    var data = json.decode(response.body);
    if (data == "Error") {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("The Drug already Exit !"),
    ));
    } else {

       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Successfully Added"),
    ));
      
    }
    }
  }

///


// Since the server is running locally you may not
// see the progress in the titlebar, its so fast...
// :)

  // Let's create a DataTable and show the drug list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('DRUG NAME'),
            ),
            DataColumn(
              label: Text('DRUG FAMILY'),
            ),
            DataColumn(
              label: Text('DISCRIPTION'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('ADD'),
            )
          ],
          // the list should show the filtered list now
          rows: _filterdrugs
              .map(
                (drug) => DataRow(cells: [
                  DataCell(
                    Text(drug.id),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(drug);
                      // Set the Selected drug to Update
                      _selecteddrug = drug;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      drug.drugName,
                    ),
                    onTap: () {
                      _showValues(drug);
                      // Set the Selected drug to Update
                      _selecteddrug = drug;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      drug.drugFamily,
                    ),
                    onTap: () {
                      _showValues(drug);
                      // Set the Selected drug to Update
                      _selecteddrug = drug;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      drug.description,
                    ),
                    onTap: () {
                      _showValues(drug);
                      // Set the Selected drug to Update
                      _selecteddrug = drug;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Add"),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("Price: ", textAlign: TextAlign.start,),
                      ),
                      TextField(
                        controller: _priceController,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Avalability: "),
                      ),
                      TextField(
                        controller: _avalController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () { Navigator.of(context).pop();},
                        child: Text("Undo", style: TextStyle(color: Colors.white),),),
                    ),

                    //Add Button

                    ElevatedButton(

                      onPressed: () {
                        //add
                         _selecteddrug = drug;
                        register();
                         Navigator.of(context).pop();
                        

                      },
                      child: Text("save", style: TextStyle(color: Colors.white),),
                    ),

                  ],
                );
              }
          );
                    },
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  // Let's add a searchfield to search in the DataTable.
  searchField() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: 'Filter by Drug name or Drug Family',
        ),
        onChanged: (string) {
          // We will start filtering when the user types in the textfield.
          // Run the debouncer and start searching
          _debouncer.run(() {
            // Filter the original List and update the Filter list
            setState(() {
              _filterdrugs = _drugs
                  .where((u) => (u.drugName
                          .toLowerCase()
                          .contains(string.toLowerCase()) ||
                      u.drugFamily.toLowerCase().contains(string.toLowerCase())))
                  .toList();
            });
          });
        },
      ),
    );
  }

  // id is coming as String
  // So let's update the model...

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getdrugs();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            // Add an update button and a Cancel Button
            // show these buttons only when updating an drug
            
            searchField(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
    );
  }
}
