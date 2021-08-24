import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'Drugs.dart';


class Services {
  static const ROOT = 'http://192.168.137.180/adminDB/admin_actions.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
 
  // Method to create the table drugs.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  static Future<List<Drugs>> getdrugs() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getdrugs Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Drugs> list = parseResponse(response.body);
        return list;
      } else {
        
        // ignore: deprecated_member_use
        return List<Drugs>();
      }
    } catch (e) {
      
      // ignore: deprecated_member_use
      return List<Drugs>(); // return an empty list on exception/error
    }
  }
  static List<Drugs> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Drugs>((json) => Drugs.fromJson(json)).toList();
  }
 
  // Method to add Drugs to the database...
  // ignore: non_constant_identifier_names
  static Future<String> addDrugs(String firstName, String lastName, String Check) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['check1'] = Check;

      

     final response = await http.post(Uri.parse(ROOT), body: map);
      print('addDrugs Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  // Method to update an Drugs in Database...
  static Future<String> updateDrugs(
      // ignore: non_constant_identifier_names
      String empId, String firstName, String lastName, String Check) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['check1'] = Check;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('updateDrugs Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  // Method to Delete an Drugs from Database...
  static Future<String> deleteDrugs(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteDrugs Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}