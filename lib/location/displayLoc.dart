// import 'package:flutter/material.dart';
// import 'package:mywork/global/global.dart';
// import 'package:simple_location_picker/simple_location_picker_screen.dart';
// import 'package:simple_location_picker/simple_location_result.dart';
// import 'package:simple_location_picker/utils/slp_constants.dart';


// class MapPage extends StatefulWidget {
//   MapPage({Key key, this.latitude, this.longitude}) : super(key: key);

//   final String latitude;
//   final String longitude;

//   @override
//   _MapPageState createState() => _MapPageState(lat: latitude, long: longitude);
// }

// class _MapPageState extends State<MapPage> {
  
//   SimpleLocationResult _selectedLocation;
//   final lat ;
//   final long ;

//   _MapPageState({this.lat, this.long});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("This Is The Address !")),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(height: 50),

//               // The button that opens the SimpleLocationPicker in display ONLY mode.
//               // This opens the SimpleLocationPicker to display a specific location on the map with a marker.
//               ElevatedButton(
//                 child: Text("Display a location"),
//                 onPressed: () {
//                   double latitude = _selectedLocation != lat ? _selectedLocation.latitude : SLPConstants.DEFAULT_LATITUDE;
//                   double longitude = _selectedLocation != long ? _selectedLocation.longitude : SLPConstants.DEFAULT_LONGITUDE;
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => SimpleLocationPicker(
//                             initialLatitude: latitude,
//                             initialLongitude: longitude,
//                             appBarTitle: "Display Location",
//                             displayOnly: true,
//                           )));
//                 },
//               ),
//               SizedBox(height: 50),

//               // The button that opens the SimpleLocationPicker in picker mode.
//               // This opens the SimpleLocationPicker to allow the user to pick a location from the map.
//               // The SimpleLocationPicker returns SimpleLocationResult containing the lat, lng of the picked location.
//               ElevatedButton(
//                 child: Text("Pick a Location"),
//                 onPressed: () {
//                   // double latitude = _selectedLocation != null ? _selectedLocation.latitude : SLPConstants.DEFAULT_LATITUDE;
//                   // double longitude = _selectedLocation != null ? _selectedLocation.longitude : SLPConstants.DEFAULT_LONGITUDE;
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => SimpleLocationPicker(
//                                 initialLatitude: initlat,
//                                 initialLongitude: initlong,
//                                 appBarTitle: "Select Location",
//                               ))).then((value) {
//                     if (value != null) {
//                       setState(() {
//                         _selectedLocation = value;
//                       });
//                     }
//                   });
//                 },
//               ),

//               SizedBox(height: 50),
//               // Displays the picked location on the screen as text.
//               _selectedLocation != null ? Text('SELECTED: (${_selectedLocation.latitude}, ${_selectedLocation.longitude})') : Container(),
//             ],
//           ),
//         ));
//   }
// }