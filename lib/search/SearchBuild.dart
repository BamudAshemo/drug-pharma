// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:mywork/global/global.dart';
// import 'package:http/http.dart' as http;

// class Searcher extends SearchDelegate<String> {
//   static final String screenID = '/searcher';
//   List<String> total;
//   List<String> suggest;

//     Future login() async {
//     var url = host+"realback/GetAllDrugs.php";
//     debugPrint("We Got Here");
//     var response = await http.post(Uri.parse(url));
//     debugPrint((response.body.toString() == "[]").toString()+response.body.toString()+"I Am Printing This");  
//     debugPrint("We then Got Here");
//     var data = json.decode(response.body);
//     try{
//       userType = data[0];
//     }catch(e){
//       return Center(child: Text("No Available Drugs !"),);
//     }
//     debugPrint("We Got Here What 1!!");
//     total = data;
//     suggest = data[0];

//   }
//   @override
//   List<Widget> buildActions(Object context) {
//     // actions for appbar
//     return [
//       IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () {
//             query = "";
//           })
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // leading icon of appbar
//     return IconButton(
//         icon: AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow,
//           progress: transitionAnimation,
//         ),
//         onPressed: () {
//           close(context, null);
//         });
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // selection based result
//     return Center(
//       child: Container(
//           height: 100,
//           width: 100,
//           child: Card(
//             color: Colors.red,
//             child: Center(child: Text('$query')),
//           )),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // when written
//     final suggestionList = query.isEmpty
//         ? suggest
//         : total
//             .where((element) => element.startsWith(query.toUpperCase()))
//             .toList();
//     return ListView.builder(
//         itemCount: suggestionList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Icon(Icons.medication),
//             title: Text(
//               suggestionList[index].toString(),
//             ),
//             onTap: () {},
//           );
//         });
//     // cleann(suggestionList);
//     // return buildMyDrugListView(suggestionList);
//   }
  
// }



// //

// Widget cleann(suggession) {
//   return Center(
//     child: Container(
//         height: 100,
//         width: 100,
//         child: Card(
//           color: Colors.red,
//           child: Center(child: Text(suggession[0].toString())),
//         )),
//   );
// }
