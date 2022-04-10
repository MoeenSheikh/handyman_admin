import 'package:flutter/material.dart';
import 'package:handyman_admin/constants.dart';

import 'add_subservice_page.dart';
class AddServicesPage extends StatefulWidget {
  const AddServicesPage({Key key}) : super(key: key);

  @override
  _AddServicesPageState createState() => _AddServicesPageState();
}

class _AddServicesPageState extends State<AddServicesPage> {
  List<String> services=Constants().services;
  List toSend=[];
  String valueText = "";
  TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Service'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Service Title"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.white,
                textColor: Colors.red,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {

                    Navigator.pop(context);
                    _textFieldController.clear();
                  });
                },
              ),
              FlatButton(
                color: Colors.red[300],
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    services.add(valueText);
                    Navigator.pop(context);
                    _textFieldController.clear();
                  });
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 30.0,
        child: IconButton(
          onPressed: () async {
            await _displayTextInputDialog(context);
          },
          icon: Center(
            child: Icon(
              Icons.add,
              size: 35,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.red[300],
        title: Center(
          child: Text("Services",
          style: TextStyle(
              color: Colors.black,
              fontSize: 24
          ),),
        ),
      ),
      body: Container(
        
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(

                  itemCount: services.length,
                    itemBuilder: (context,index){
                    return Column(
                      children: [
                        ListTile(
                          title: Text(services[index]),
                          leading: Icon(Icons.design_services),
                          onTap: (){
                            if(services[index].contains("AC"))
                              {
                                toSend=Constants().acSubServices;
                              }
                            if(services[index].contains("Car Services"))
                            {
                              toSend=Constants().carSubServices;
                            }
                            if(services[index].contains("Carpenter"))
                            {
                              toSend=Constants().carpSubServices;
                            }
                            if(services[index].contains("Cleaning"))
                            {
                              toSend=Constants().cleaningSubServices;
                            }
                            if(services[index].contains("Handy"))
                            {
                              toSend=Constants().handySubServices;
                            }
                            if(services[index].contains("Geyser"))
                            {
                              toSend=Constants().geyserSubServices;
                            }
                            if(services[index].contains("Elect"))
                            {
                              toSend=Constants().electSubServices;
                            }
                            if(services[index].contains("Home"))
                            {
                              toSend=Constants().homeSubServices;
                            }
                            if(services[index].contains("Plumb"))
                            {
                              toSend=Constants().plumbSubServices;
                            }
                            if(services[index].contains("Paint"))
                            {
                              toSend=Constants().paintSubServices;
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddSubServicePage(title: services[index],subService: toSend,)
                                ));
                          },

                        ),
                        Divider(thickness: 2,)
                      ],
                    );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
