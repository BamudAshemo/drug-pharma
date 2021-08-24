import 'package:flutter/material.dart';
import 'package:mywork/global/global.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mywork/googleloc/glob.dart';

class SeeLoc extends StatefulWidget {
  @override
  _SeeLocState createState() => _SeeLocState();
}

class _SeeLocState extends State<SeeLoc> {
  void initState() {
    super.initState();
    _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: InfoWindow(title: pharmaname),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: search,
        );
  }
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(8.54135,  39.26873),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;

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
        title: const Text('Google Maps'),
        actions: [
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
              child: const Text('CurLoc'),
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
            markers: {_origin}
          ),
        ],
      ),
    );
  }

      // Get directions

    }
  