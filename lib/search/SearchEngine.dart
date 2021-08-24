import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mywork/global/global.dart';

import 'Cart.dart';
import 'SearchVars.dart';
import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:mywork/search/Cart.dart';


// To Be Added Sort By
// Show Distance
// Convert LocStr To LatLang
class SearchEngine {
  
  static List<Pharma> searchpharma (){
    debugPrint("we have began !");
    List<List<Pharma>> mega = [];
    for (var drugs in incart){
      List<Pharma> kilo = [];
      for (var pharma in allDrugPharmas){
        if (drugs.drugName == pharma.drugName){
          // debugPrint(incart.length.toString()+allDrugPharmas.length.toString());
          // print(incart[0].drugName+"From Result");
          // debugPrint('incart.length.toString()+allDrugPharmas.length.toString() Works');
          List<Pharma> str = allPharmas.where((pharm) => pharm.ownerId == pharma.pharmaId).toList();
          kilo.add(str[0]);
        }
      mega.add(kilo);
      }
    }
    print("Mega Collected !");
    List<Pharma> filterd = allPharmas;
    int druglength = mega.length;
    for (var count = druglength-1; count >=0;count--){
        filterd = filterd.where((pharm) => mega[count].contains(pharm)).toList();
        }

        print(filterd[0].pharmaName+"WHDTRTDHHTHHHHHHHHHHHHHHHHHHHHHHH");

    return sorter(filterd);
}

  static Future<List<DrugPharma>> getAllDrugPharma() async {
    try {
      var map = Map<String, dynamic>();
      final response = await http.post(Uri.parse("http://192.168.137.1/backend/test/GetAllDrugPharma.php"), body: {
      });
      print('getdrugPharma Response: ${response.body}');
      if (200 == response.statusCode) {
        List<DrugPharma> list = parseResponse(response.body);
        debugPrint(list.toString()+"From This obj");
        allDrugPharmas = list;
        return list;
      } else {
        
        return [];
      }
    } catch (e) {
      
      // ignore: deprecated_member_use
      return List<DrugPharma>(); // return an empty list on exception/error
    }
  }
  static List<DrugPharma> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<DrugPharma>((json) => DrugPharma.fromJson(json)).toList();
  }


  static Future<List<Pharma>> getAllPharma() async {
    try {
      var map = Map<String, dynamic>();

      final response = await http.post(Uri.parse("http://192.168.137.1/backend/test/GetAllPharma.php"), body: map);
      print('getpharma Response: ${response.body}');
      if (200 == response.statusCode) {
        debugPrint('we got here !');
        List<Pharma> list = parseDrugResponse(response.body);
        allPharmas = list;
        print(list.toString());
        
        return list;
      } else {
        
        return [];
      }
    } catch (e) {
      
      return []; // return an empty list on exception/error
    }
  }
  static List<Pharma> parseDrugResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pharma>((json) => Pharma.fromJson(json)).toList();
  }


 
 static Future<String> getPhone(String pharmaId) async {
   try {
    final response = await http.post(Uri.parse(host+"users/GetPhone.php"), body: {"PharmaId":pharmaId});
    print('getPhone Response: ${response.body}');
    if (200 == response.statusCode) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      Phone res = parsed.map<Phone>((json) => Pharma.fromJson(json)).toList();
      return res.phone;
      // allPharmas = list;
    } else {
      
      return "";
    }
  } catch (e) {
    return ""; // return an empty list on exception/error
  }
 }

 static Future<List<Searchables>> getSearchables() async {
   List<DrugPharma> druging = await getAllDrugPharma();
   List<Pharma> pharma = await getAllPharma();
   debugPrint(pharma.toString());
   if(pharma[0].pharmaName.runtimeType == String){
     return execute(druging, pharma);
   }
   
 }
  static execute(List<DrugPharma> druging,List<Pharma> pharma) {
   List<Searchables> results = [];
     for (var drugs in druging){
            for (var pharmas in pharma){
              if (drugs.pharmaId == pharmas.ownerId){
                Searchables res = Searchables.fromDPh(pharmas, drugs);
                print(res.pharmaId.toString()+"iter");
                results.add(res);
              }
            }
          }
          print(results.toString()+"dfsdfhsdfhsfdh");
    return sorter(results);
  }
//  static List<Searchables>_perfecttheform(List<DrugPharma> provision,List<Pharma> providers){
    
//      return results;
//   } 










  static List sorter(List sortees){
    // print(sortees)
    sortees.sort((a,b){return a.distance.compareTo(b.distance);});
    print(sortees);
    return sortees;
  }

  static List<LatLng> setOrigDest(String lat,String long){
    return [currentlocation,LatLng(double.parse(lat),double.parse(long))];
  }
  static double distfromCurrent(LatLng location){
    print(currentLoc.toString()+"print from current lco");
  return calculateDistance(
    currentlocation.latitude, 
    currentlocation.longitude, 
    location.latitude, 
    location.longitude);
     }
  
  static double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

}


