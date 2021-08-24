import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:mywork/registerPharma.dart';
import 'package:mywork/search/SearchBar.dart';
import 'package:mywork/search/SearchBuild.dart';

import 'HomePage.dart';
import 'global/global.dart';

class LoginPharma extends StatefulWidget {

  @override
  _LoginPharmaState createState() => _LoginPharmaState();
}

class _LoginPharmaState extends State<LoginPharma> {
@override
  void initState() {
    super.initState();
    getloc();
    print("sadkjfaslkdfhalkjgaksjdghlkasjkgahsdlgkdhglakjhglakshdglkashglkasdhglkasdghalksdhgkljdg");
  }

TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();


  
  Future login() async {
    var url = host+"SYS/UserLogin.php";
    debugPrint("We Got Here"+url);
    var response = await http.post(Uri.parse(url), body: {
      "UserName": user.text,
      "PassWord": pass.text,
    });
    // debugPrint((response.body.toString() == "[]").toString()+response.body.toString()+"I Am Printing This");  
    debugPrint("We then Got Here");
    var data = json.decode(response.body);
    try{
      userType = data[0]['status'];
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Email or password is not correct"),
    ));
      return;
    }
    debugPrint("We Got Here What 1!!");
    if (data[0]['status'] == "Pharma") {
      pharmaid=data[0]['userId'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Successful login"),
    ));
      currentUser = data[0]['userId'];
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    }
    else if (data[0]['status'] == "Pending") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Not Approved Yet"),
    ));
     
    }
    else if (data[0]['status'] == "User"){
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text("SearchPage UnEmplimented Error")));
        // To the Search Page !
        // showSearch(context: context, delegate: Searcher());
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TheSearchBar()));
    } else {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Email or password is not correct"),
    ));
    }
  }
//



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Pharmacy Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
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
                controller: user,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    
                    labelText: 'username',
                    hintText: 'Enter valid username'),
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
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: () {
              
                },
              child: Text(
                'Forgot Password',
                
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  login();
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPharma()));
              },
              child: Text('New User? Create Account'))
          ],
        ),
      ),
    );
  }
}