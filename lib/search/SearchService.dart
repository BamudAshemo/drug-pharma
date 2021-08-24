import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:mywork/global/global.dart';
import 'package:mywork/search/Cart.dart';
import 'SearchVars.dart';


class Services {
    static Future<List<DrugPharma>> serRequest(Searchables drug) async {
    try {
      var map = Map<String, dynamic>();
      final response = await http.post(Uri.parse(test+"/realback/users/CreateSpecRequest.php"), body: {
        "UserId":currentUser,
        "DrugId":drug.drugId,
        "DrugName":drug.drugName,
        "PharmaId":drug.pharmaId,
        "OrderId":drug.pharmaId // Should Be Changed @
      });
      print('getdrugs Response: ${response.body}');
      if (200 == response.statusCode) {
        List<DrugPharma> list = parseResponse(response.body);
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

}