import 'package:flutter/material.dart';
import 'package:mywork/global/global.dart';
import 'package:mywork/googleloc/glob.dart';
import 'package:mywork/search/SearchBar.dart';
import 'directions_model.dart';
import 'directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrigDest extends StatefulWidget {
  @override
  _OrigDestState createState() => _OrigDestState();
}

class _OrigDestState extends State<OrigDest> {
  int _rating;
  String _comment;
  void initState() {
    _rating = 5;
    super.initState();
    _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Current Location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: currentlocation,
        );

    _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: InfoWindow(title: pharmaname),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: search,
        );
    _getDirect();
  }
  _getDirect()async{
    final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: _destination.position);
      setState(() => _info = directions);
  }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(8.54135,  39.26873),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Route'),
        actions: [
          
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Current'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.purple,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Pharma'),
            ),
            
            TextButton(
            onPressed: (){
             showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                        Padding(padding: EdgeInsets.all(20.0),
                        child: TextField(
                          maxLines: 4,
                                          decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5.0),
                                hintText: 'Comment',
                              ),
                              onChanged: (string) {
                                setState(() {
                                    _comment = string;
                                  });
                              },
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Text('RATING :'),
                              SizedBox(width:15),
                              DropdownButton<int>(
                                    value: _rating,
                                    icon: const Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (int newValue) {
                                      setState(() {
                                        _rating = newValue;
                                      });
                                    },
                                    items: <int>[1,2,3,4,5]
                                        .map<DropdownMenuItem<int>>((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                  ),
                            ],
                          )
                        ),
                                         
                                          ],
                                      ),
                      ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: ElevatedButton(
                                          onPressed: () { 
                                            // API SET CALL
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TheSearchBar()));},
                                          child: Text("Comment", style: TextStyle(color: Colors.white),),),
                                      ),
                                       Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // SAME API SET CALL
                                             Navigator.of(context).pop();},
                                          child: Text("Skip", style: TextStyle(color: Colors.white),),),
                                      ),
                                    ],
                                  );
                                }
                            );

          }, 
          child: const Text("Complete"),
          style: TextButton.styleFrom(
                backgroundColor: Colors.white54,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              _origin,
              _destination
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },

          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDistance}, ${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

      // Get directions
      
    }
 