import 'package:flutter/material.dart';
import 'package:mywork/global/global.dart';
import 'package:mywork/googleloc/glob.dart';
import 'directions_model.dart';
import 'directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLoc extends StatefulWidget {
  @override
  _PickLocState createState() => _PickLocState();
}


class _PickLocState extends State<PickLoc> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(8.54135,  39.26873),
    zoom: 11.5,
  );
  GoogleMapController _googleMapController;
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
        title: const Text('Pick a Location by LongPress'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            onLongPress: _addMarker,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
  void _addMarker(LatLng pos) async {
     saved = pos;
     Navigator.pop(context);
  }
}
