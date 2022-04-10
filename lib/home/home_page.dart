import 'package:flutter/material.dart';

import 'add_services.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text("Home",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20
          ),),
        ),

      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddServicesPage()
                        ));

                  },
                  child: Container(
                    height: 80,
                    width: 130,
                    color: Colors.red[300],
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        children: [
                          Icon(Icons.home_repair_service,size: 35,),
                          SizedBox(height: 5,),
                          Text("Add Services")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Container(
                  height: 80,
                  width: 130,
                  color: Colors.red[300],
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        Icon(Icons.person_pin,size: 35,),
                        SizedBox(height: 5,),
                        Text("Customers List")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Container(
                  height: 80,
                  width: 130,
                  color: Colors.red[300],
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        Icon(Icons.handyman,size: 35,),
                        SizedBox(height: 5,),
                        Text("Technician List")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Container(
                  height: 80,
                  width: 130,
                  color: Colors.red[300],
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        Icon(Icons.insert_drive_file,size: 35,),
                        SizedBox(height: 5,),
                        Text("Invoices")
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
