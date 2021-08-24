import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

String pharmaid;
String userType;
// const String host = "http://192.168.137.180/";
                    //  http://localhost/
const String host = "http://192.168.137.1/realback/";
const String test = "http://192.168.137.1";
// http://localhost/realback/users/GetAllDrugPharma.php
// http://localhost/backend/test/loginpharma.php
List<String> activedrugs = [];

List<String> routes = ['routed-car','routed-foot','routed-bike'];
  
String osmApiHead = "https://routing.openstreetmap.de/";
// routed-car
String osmApiTail = "/route/v1/driving/";
String startPt = "6.487427,51.813709";
String endPt = "6.469745635986327,51.80160919518729";
//40.6346851

// ignore: avoid_init_to_null 
LocationData currentLoc = null;
// LatLng currentlocation = LatLng(currentLoc.latitude,currentLoc.longitude);
LatLng currentlocation = LatLng(8.560939169352514, 39.28742695554454);
LatLng ActivepharmaLocation; 
var pointsGradient = <LatLng>[
      LatLng(37.752889386891795, -122.43145823478699),
      LatLng(37.77768430536759, -122.43953570723532),
      LatLng(37.763721985381004, -122.44583286345004),
    ]; 
// these are the defualt routes for adama !  
final initlat = 8.541355941559404;
final initlong = 39.26873102660878;

String currentUser ;

Future getloc() async {
  // if(currentLoc != null){
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return ;
      }
    }

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}
print("dvaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeeeeeeeeeeeeeeeeeeava");
currentLoc = await location.getLocation();
print("dasdvdddddddddddddddddddddddddddddddddddddddddddddddddddddddd"+currentLoc.latitude.toString());
  }