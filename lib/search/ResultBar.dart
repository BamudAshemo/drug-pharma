import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/_location/load2locations.dart';
import '/_location/glob.dart';

import 'SearchEngine.dart';


class TheResultBar extends StatefulWidget {
  final String title = 'Pharma Results';
  @override
  TheResultBarState createState() => TheResultBarState();
}

class TheResultBarState extends State<TheResultBar> {
  Center _dataBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text('Pharma Name'),
                  ),
                  DataColumn(
                    label: Text('Pharma Location'),
                  ),
                  DataColumn(
                    label: Text('Routing'),
                  ),
                ],
                // the list should show the filtered list now
                rows: SearchEngine.searchpharma()
                    .map(
                      (drugs) => DataRow(cells: [
                        DataCell(
                          Text(drugs.pharmaName),
                        ),
                        DataCell(
                          Text(drugs.locationlat+" "+drugs.locationlong),
                          onTap: () async {
                            // String phoneNo = await Services.getPhone(drugs.ownerId);
                          
                          },
                        ),
                        DataCell(
                          Text("Start Routing..."),
                           onTap: () async {
                            // String phoneNo = await Services.getPhone(drugs.ownerId);
                            pharmaname = drugs.pharmaName;
                            or_dst = SearchEngine.setOrigDest(drugs.locationlat, drugs.locationlong);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OrigDest()));
                             
                          },
                        ),
                        
                        
                      ]),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
            },
          ),
        title: Text("The Result !"), // we show the progress in the title...
      ),
      body: Container(
        child: _dataBody(),
      ),
    );
  }
  
}

