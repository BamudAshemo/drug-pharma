import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'
    as http;
import 'package:mywork/global/global.dart';
import 'package:mywork/location/Router.dart';
// import 'package:latlong/latlong.dart';

class LocationServices {

    static Future<List<Router>> getRoute() async {
      print("We Were Called on !"+"Header"+osmApiHead+routes[0]+osmApiTail+startPt+";"+endPt+"This All IS From Here");
    try{
      print("object");
      final queryParameters ={"overview":"false","alternatives":"true","steps":"true"};

      final uri = Uri.https(osmApiHead,routes[0]+osmApiTail+startPt+";"+endPt, queryParameters );
      print("made it !");
      final response = await http.get(uri);
      print('getRoutes Response: ${response.body}');
        if (200 == response.statusCode) {
        List<Router> list = parseRouteResponse(response.body);
        return list;
      } else {
        print("this is taking to long !~");
        // ignore: deprecated_member_use
        return List<Router>();
      }
    } catch (e) {
      print(e.message);
      // ignore: deprecated_member_use
      return List<Router>(); // return an empty list on exception/error
    }
  }
  static List<Router> parseRouteResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Router>((json) => Router.fromJson(json)).toList();
  }
    
  static Future<List<LatLng>> getRealRoute () async {
    List<LatLng> realroutes = [];
    List<Router> routes = await getRoute();
    for ( var roots in routes){
      for ( var rout in roots.routes ){
        for ( var leg in rout.legs) {
          for ( var step in leg.steps) {
            realroutes.add(LatLng(step.maneuver.location[0], step.maneuver.location[1]));
          }
        }
      }
    }
    return realroutes;
  }
}