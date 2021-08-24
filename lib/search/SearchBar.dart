import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mywork/_services/models.dart';

import '../../mainLogin.dart';
import 'Cart.dart';
import 'ResultBar.dart';
import 'SearchEngine.dart';

class TheSearchBar extends StatefulWidget {
  //
  TheSearchBar() : super();

  final String title = 'Flutter Data Table';

  @override
  TheSearchBarState createState() => TheSearchBarState();
}


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

class TheSearchBarState extends State<TheSearchBar> {
  final _debouncer = Debouncer(milliseconds: 2000);

  List<Searchables> _drugs;
  List<Searchables> _filterdrugs;
  double _drugPrice;
  String _availability;

  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _drugs = [];
    _filterdrugs = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _clearValues();
    _getdrugsPh();
    debugPrint("Begin "+_filterdrugs.toString()+ "This ISt IT");
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


  _getdrugsPh() {
    _showProgress('Loading drugs...');
    SearchEngine.getSearchables().then((value) {
      print(value);
      setState((){
         _drugs = value;

         _filterdrugs = value;
        
    });
    });

  }

  
  // Method to clear TextField values
  _clearValues() {
    _drugPrice = 10000;
    _availability = 'Low';
  }

  _showValues(DrugPharma drugs) {
    _drugPrice = double.parse(drugs.drugPrice);
    _availability = drugs.availability;
  }


  _selectdrug(Searchables drugs) {
    
       _showProgress('Selecting drugs...');
        incart.add(drugs);
       _showSnackBar(context, 'Drug Added');
    
   
  }

  _clearSelection() {
    incart = [];
  }

  _showDialog(){
     showDialog(
context: context,
builder: (BuildContext context) {
  return AlertDialog(
    title: Text('Drugs To Search'),
    content: setupAlertDialoadContainer(),
    actions: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: () { 
                  _clearValues();
                  _clearSelection();
                  Navigator.of(context).pop();},
                child: Text("Clear", style: TextStyle(color: Colors.white),),),
            ),
              Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () { Navigator.of(context).pop();},
            child: Text("Add More", style: TextStyle(color: Colors.white),),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () { 
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TheResultBar()));},
            child: Text("Search", style: TextStyle(color: Colors.white),),),
        ),
          ],
        ),
      ),
      
    ],
  );
});

}
  bool _availableLogic(String avail){
    print("We were here");
    if(_availability == "Low"){
       return true;}
    else if (_availability == 'Mid'){
      if (avail == 'low') {
        return false;
      } else { return true;}
    } else if (_availability == 'High'){
      if (avail == 'high') {
        return true;
      } else { return false;}
    }
    return true;
  }

  _fixed(List<DrugPharma> drugs){


  }
   Widget menuDrawer()
{
  return Drawer(child: ListView(children: <Widget>[
    UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.pinkAccent),
      currentAccountPicture: GestureDetector(child: CircleAvatar(backgroundColor: Colors.white, 
      child:  Icon(Icons.person),),),
      // accountName: Text(pharmaid.toString()),
      accountEmail: Text('burka4573@gmail.com'), accountName: null,
      ),
      ListTile(
          leading: Icon(Icons.home, color: Colors.green,),
          title: Text('Home', style: TextStyle( color: Colors.green,),),
      ), 
      ListTile(
        onTap: (){
          // Navigator.push(context,MaterialPageRoute(builder: (context)=>DataTable1(),),);
          debugPrint("Add Drugs");
        },
          leading: Icon(Icons.label, color: Colors.grey,),
          title: Text('Add Drugs', style: TextStyle( color: Colors.grey,),),
      ), 
      ListTile(
        onTap: (){
          // Navigator.push(context,MaterialPageRoute(builder: (context)=>DataTableDemo(),),);

          debugPrint("Manage Durg");
        },
          leading: Icon(Icons.contact_page, color: Colors.amber,),
          title: Text('Manage Durg', style: TextStyle( color: Colors.amber,),),
      ), 
      ListTile(
        onTap: (){
          // Navigator.push(context,MaterialPageRoute(builder: (context)=>DataTable1(),),);

          debugPrint("See Request");
        },
          leading: Icon(Icons.contact_page, color: Colors.amber,),
          title: Text('Drug List', style: TextStyle( color: Colors.amber,),),
      ),
      ListTile(
        onTap: (){
          debugPrint("logout");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logout Successful"), ));
            
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPharma(),),);
          
         
          
        },
          leading: Icon(Icons.lock, color: Colors.red,),
          title: Text('Logout', style: TextStyle( color: Colors.red,),),
      ), 
  ]),);
}
  Widget setupAlertDialoadContainer() {
  return Container(
    height: 150.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: incart.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(incart[index].drugName),
          subtitle: Text(incart[index].drugPrice),
        );
      },
    ),
  );
}
// Since the server is running locally you may not
// see the progress in the titlebar, its so fast...
// :)

  // Let's create a DataTable and show the drugs list in it.
  SingleChildScrollView _dataBody() {
    debugPrint(_filterdrugs.toString()+" thi is from here !");
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('Drug Name'),
            ),
            DataColumn(
                label: Text('Drug Price'),
              ),
            DataColumn(
                label: Text('Availability'),
              ),
            DataColumn(
                label: Text('Offering Pharma'),
              ),
            DataColumn(
                label: Text('Distance To Pharma'),
              ),
             DataColumn(
                label: Text('Add Request'),
              ),
          ],
          // the list should show the filtered list now
          
          rows: _filterdrugs
              .map(
                (drugs) => DataRow(cells: [
                  DataCell(
                    Text(drugs.drugName),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      if(incart.contains(drugs)){
                        _showSnackBar(context, 'Drug allready Added');
                      } else {
                      _selectdrug(drugs);
                      _showDialog();
                       
                    }}
                  ),
                  DataCell(
                    Text(drugs.drugPrice + " birrs"),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () { },
                  ),
                  DataCell(
                    Text(drugs.availability),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () { },
                  ),
                  DataCell(
                    Text(drugs.pharmaName),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () { },
                  ),
                  DataCell(
                    Text((drugs.distance * 1000).toStringAsFixed(2)+" meters"),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () { },
                  ),
                  DataCell(
                    Container(
                      height:40,
                      width:60,
                      child:IconButton(
                        icon: Icon(Icons.delivery_dining),
                        onPressed: () {
                          // _sendRequest (drugs.pharmaId,currentUser)
                          _showSnackBar(context, "request Sent");
                        },
                      )
                    ),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () { },
                  ),
                  
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
          hintText: 'Filter Drug Name',
        ),
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {
              _filterdrugs = _drugs
                  .where((u) => (u.drugName
                          .toLowerCase()
                          .contains(string.toLowerCase()) &&
                          double.parse(u.drugPrice) <= _drugPrice &&
                          _availableLogic(u.availability)
                      ))
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
      drawer: menuDrawer(),
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // _filterIt();
              print(_filterdrugs.toString());
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Row(
                    children: [
                      Text('Price Limit :'),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: DropdownButton<double>(
                              value: _drugPrice,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (double newValue) {
                                setState(() {
                                  _drugPrice = newValue;

                                  _filterdrugs = _filterdrugs
                                      .where((u) => (
                                              double.parse(u.drugPrice) <= _drugPrice
                                          ))
                                      .toList();
                                });
                              },
                              items: <double>[10000,5000,1000,500,300,100,50,25]
                                  .map<DropdownMenuItem<double>>((double value) {
                                return DropdownMenuItem<double>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            )
                      ),
                   
                    ],
                  ),
                  Row(
                    children: [
                      Text('Avail Limit :'),
                      Padding(
                padding: EdgeInsets.all(20.0),
                child: DropdownButton<String>(
                          value: _availability,
                          icon: const Icon(Icons.arrow_upward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                                  _availability = newValue;
            
                                  _filterdrugs = _filterdrugs
                                      .where((u) => (
                                              _availableLogic(u.availability)
                                          ))
                                      .toList();
                                });
                          },
                          items: <String>['Low', 'Mid', 'High']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
              ),
                    ],
                  ),
              
                ],
              ),
            ),
            searchField(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                   _showDialog();
        },
        child: Text("Cart"),
      ),
    );
  }}
