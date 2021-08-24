import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mywork/global/global.dart';
import 'package:mywork/search/SearchEngine.dart';

class DrugPharma {
  String pharmaId;
  String availability;
  String drugId;
  String drugName;
  String drugPrice;
  DrugPharma({this.drugId, this.pharmaId , this.drugName, this.drugPrice, this.availability});
  factory DrugPharma.fromJson(Map<String, dynamic> json) {
    return DrugPharma(
      drugId: json['drugId'] as String,
      drugName: json['drugName'] as String,
      pharmaId: json['pharmaId'] as String,
      drugPrice: json['drugPrice'] as String,
      availability: json['availability'] as String,
    );
  }
}

class Pharma {
  final String ownerId;
  final String pharmaName;
  final String locationlat;
  final String locationlong;
  final String location;
  final double distance;
  // final String description;
  // final String pharmaLevel;
  Pharma({this.ownerId, this.pharmaName, this.locationlat, this.locationlong, this.location,this.distance});
  factory Pharma.fromJson(Map<String, dynamic> json) {
    print((json['locationlat'] as String)+" "+(json['locationlong'] as String)+" this is distance !");

    print(SearchEngine.distfromCurrent(LatLng(double.parse(json['locationlat'] as String),double.parse(json['locationlong'] as String))).toString()+"ththis is returs");
    print('distance response didn\'t');
    return Pharma(
      ownerId: json['ownerId'] as String,
      pharmaName: json['pharmaName'] as String,
      locationlat: json['locationlat'] as String,
      locationlong: json['locationlong'] as String,
      location: json['location'] as String,
      distance: SearchEngine.distfromCurrent(LatLng(double.parse(json['locationlat'] as String),double.parse(json['locationlong'] as String)))
      // description: json['description'] as String,
      // pharmaLevel: json['pharmaLevel'] as String,
    );
  }

}
class Phone{
   final String phone;

  Phone({this.phone});
  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      phone: json['phone_no']
    );
  }
   
 }

 class Searchables{
  final String pharmaName;
  final String locationlat;
  final String locationlong;
  final String location;
  final double distance;
  final String pharmaId;
  final String availability;
  final String drugId;
  final String drugName;
  final String drugPrice;

  Searchables({
    this.pharmaName, 
  this.locationlat, 
  this.locationlong, 
  this.location, 
  this.distance, 
  this.pharmaId, 
  this.availability, 
  this.drugId, 
  this.drugName, 
  this.drugPrice});

  factory Searchables.fromDPh(Pharma pharma,DrugPharma drugs) {
    return Searchables(
      pharmaName : pharma.pharmaName,
      locationlat : pharma.locationlat,
      locationlong : pharma.locationlong,
      location : pharma.location,
      distance : pharma.distance,
      pharmaId : pharma.ownerId,
      availability : drugs.availability,
      drugId : drugs.drugId,
      drugName : drugs.drugName,
      drugPrice : drugs.drugPrice
    );}
   
  

 }