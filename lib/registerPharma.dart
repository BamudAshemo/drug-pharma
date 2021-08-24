import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:simple_location_picker/simple_location_picker_screen.dart';

import 'HomePage.dart';
import 'global/global.dart';


class RegisterPharma extends StatefulWidget {
  @override
  _RegisterPharmaState createState() => _RegisterPharmaState();
}

class _RegisterPharmaState extends State<RegisterPharma> {
//
TextEditingController user = TextEditingController();
TextEditingController name = TextEditingController();
String location = "";
TextEditingController loclat = TextEditingController();
TextEditingController loclong = TextEditingController();
TextEditingController pass = TextEditingController();
  bool _validate = false;


  Future register() async {
    if(_validate==true && location == "")
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("fill the form!"),
    ));
    }
    else{
      var url = "http://localhost/realback/";
    var response = await http.post(Uri.parse(url), body: {
      "username": user.text,
      "location": location.toString(),
      "name": name.text,
      "loclat": loclat.text,
      "loclong": loclong.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("The user already Exit !"),
    ));
    } else {

       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Successful Register"),
    ));
      
    }
    }
  }

//////////////////////////////////////




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Pharmacy Registration Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder(),
                    
                    labelText: 'Pharmacy name',
                    ),
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: user,
                
                decoration: InputDecoration(
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder(),
                    labelText: 'username',
                    hintText: 'Enter valid user'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 15.0, right: 15.0, top: 15, bottom: 0),
            //   //padding: EdgeInsets.symmetric(horizontal: 15),
            //   child: ElevatedButton(
            //     child: Text("Pick a Location"),
            //     onPressed: () {
            //       // double latitude = _selectedLocation != null ? _selectedLocation.latitude : SLPConstants.DEFAULT_LATITUDE;
            //       // double longitude = _selectedLocation != null ? _selectedLocation.longitude : SLPConstants.DEFAULT_LONGITUDE;
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => SimpleLocationPicker(
            //                     initialLatitude: initlat,
            //                     initialLongitude: initlong,
            //                     appBarTitle: "Select Location",
            //                   ))).then((value) {
            //         if (value != null) {
            //           setState(() {
            //             location = value;
            //           });
            //         }
            //       });
            //     },
            //   ),
              // child: TextField(
              //   controller: location,
                
              //   decoration: InputDecoration(
              //     errorText: _validate ? 'Value Can\'t Be Empty' : null,
              //       border: OutlineInputBorder(),
              //       labelText: 'location',
              //       ),
              // ),
            
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: loclat,
                
                decoration: InputDecoration(
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder(),
                    labelText: 'Enter pharmacy location latitude',
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: loclong,
                
                decoration: InputDecoration(
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    border: OutlineInputBorder(),
                    labelText: 'Enter Pharmacy loction longitude',
                    ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                  //    setState(() {
                  // user.text.isEmpty ? _validate = true : _validate = false;
                  // });
                  //  setState(() {
                  //   pass.text.isEmpty ? _validate = true : _validate = false;
                  //   register();
                  // });
                  
                  },
                  child: Text(
                    'register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            TextButton(onPressed: (){

            }, 
            child: Text(
                    'Go to Login Page',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),)
          ],
        ),
      ),
    );
  }
}