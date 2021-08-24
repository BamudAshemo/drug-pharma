
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/global/global.dart';
import '/location/polyline.dart';
import '/location/services.dart';
import '/location/themap.dart';
import '/pharmalogin.dart';

import 'package:mywork/registerPharma.dart';

import 'splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPharma(),
    );
  }
  
 
}
