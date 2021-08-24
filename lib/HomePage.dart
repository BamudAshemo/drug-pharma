import 'package:flutter/material.dart';

import 'package:mywork/adddrug/DataTable1.dart';
import 'package:mywork/pharmalogin.dart';

import 'aprove/DataTableDemo.dart';
import 'global/global.dart';

class HomePage extends StatefulWidget {
 

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    Widget menuDrawer()
{
  return Drawer(child: ListView(children: <Widget>[
    UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.pinkAccent),
      currentAccountPicture: GestureDetector(child: CircleAvatar(backgroundColor: Colors.white, 
      child:  Icon(Icons.person),),),
      accountName: Text(pharmaid.toString()),
      accountEmail: Text('burka4573@gmail.com')
      ),
      ListTile(
          leading: Icon(Icons.home, color: Colors.green,),
          title: Text('Home', style: TextStyle( color: Colors.green,),),
      ), 
      ListTile(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>DataTable1(),),);
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
          Navigator.push(context,MaterialPageRoute(builder: (context)=>DataTable1(),),);

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
return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: <Widget>[
        
      ]),
          drawer: menuDrawer(),
          body: ListView(
            
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Admin Panel', style: TextStyle(fontSize: 25,)),
              ),
            Row
            ( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

            ],
            ),

      


            ],
          ),
    );
  }
}