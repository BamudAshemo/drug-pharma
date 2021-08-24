import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'druglist.dart';


class Services {
  static const ROOT = 'http://192.168.137.180/adminDB/addDrug.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
 
  // Method to create the table Employees.
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
 
  static Future<List<Drug>> getdrugs() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Drug> list = parseResponse(response.body);
        return list;
      } else {
        
        // ignore: deprecated_member_use
        return List<Drug>();
      }
    } catch (e) {
      
      // ignore: deprecated_member_use
      return List<Drug>(); // return an empty list on exception/error
    }
  }
  static List<Drug> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Drug>((json) => Drug.fromJson(json)).toList();
  }
 
  // Method to add employee to the database...
  // ignore: non_constant_identifier_names
  static Future<String> addEmployee(String firstName, String lastName, String Check) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['drugname'] = firstName;
      map['drugfamily'] = lastName;
      map['description'] = Check;

      

     final response = await http.post(Uri.parse(ROOT), body: map);
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  // Method to update an Employee in Database...
  static Future<String> updateEmployee(
      // ignore: non_constant_identifier_names
      String empId, String firstName, String lastName, String Check) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['drugname'] = firstName;
      map['drugfamily'] = lastName;
      map['description'] = Check;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('updateEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  // Method to Delete an Employee from Database...
  static Future<String> deleteEmployee(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteEmployee Response: ${response.body}');
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