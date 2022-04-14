import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:handyman_admin/constants.dart';
import 'package:handyman_admin/repo/firebase_repo.dart';


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
  Stream res;
  TextEditingController _textFieldController = TextEditingController();
  PlatformFile imgFile;
  String uploadPath="";

  Future<void> _displayTextInputDialog(BuildContext context) async {
    setState(() {
      imgFile=null;
    });
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context,setState){
              return AlertDialog(
                title: Text('Add Service'),
                content: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          valueText = value;
                        });
                      },
                      controller: _textFieldController,
                      decoration: InputDecoration(hintText: "Service Title"),
                    ),
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        InkWell(
                          onTap: ()async{
                            final res = await FilePicker.platform.pickFiles(type: FileType.image);
                            final file = res.files.first;
                            setState(() {
                              imgFile=file;
                            });

                          },
                          child: Container(
                            height: 30,
                            width: 90,
                            decoration:
                            BoxDecoration(border: Border.all(color: Colors.grey)),
                            child: Center(
                              child: Text("Attach",style: TextStyle(
                                  color: Colors.grey
                              ),),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        if(imgFile!=null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(imgFile.name,style: TextStyle(fontSize: 12),),
                            ],
                          ),

                      ],
                    )
                  ],
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
                        //services.add(valueText);

                        if(imgFile!=null){
                          storeImage();
                        }

                        Navigator.pop(context);
                        _textFieldController.clear();
                      });
                    },
                  ),
                ],
              );
            }

          );
        });
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getServices();
  }
  Future<void> storeImage()async{
    FirebaseStorage firebaseStorage=FirebaseStorage.instance;
    Reference reference=firebaseStorage.ref().child("ServiceImages").child(imgFile.name);
    UploadTask uploadTask=reference.putFile(File(imgFile.path));
    uploadTask.snapshotEvents.listen((event) { });

    await uploadTask.whenComplete(() async{
      uploadPath=await uploadTask.snapshot.ref.getDownloadURL();
      DataBase().addService(valueText,uploadPath);
    });

  }
  void getServices()async{
    res=await DataBase().getServices();
    setState(() {

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
                child:StreamBuilder(
                  stream: res,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Scaffold();
                    }
                    return ListBuilder(snapshot);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget ListBuilder(snapshot)
  {
    return ListView.builder(

        itemCount: snapshot.data.docs.length,
        itemBuilder: (context,index){
          print(snapshot.data.docs.length);
          return Column(
            children: [
              Container(
                height:90,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.74),
                    image: DecorationImage(
                        image: NetworkImage(
                            snapshot.data.docs[index].data()["imgURL"]),
                        fit: BoxFit.cover)),

                child: Center(
                  child: ListTile(
                    title: Container(
                        color: Colors.white.withOpacity(0.75),

                        child: Text(snapshot.data.docs[index].data()["name"])
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddSubServicePage(title: snapshot.data.docs[index].data()["name"],index: index,)
                          ));
                    },
                    trailing: Container(
                      color: Colors.white.withOpacity(0.75),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: (){
                                DataBase().deleteService(index);
                              },
                              icon: Icon(Icons.delete)
                          ),
                          IconButton(
                              onPressed: ()async{
                                await _displayUpdatedTextInputDialog(context,
                                    snapshot.data.docs[index].data()["name"],
                                    snapshot.data.docs[index].data()["imgURL"],
                                index);
                              },
                              icon: Icon(Icons.update)
                          ),

                        ],
                      ),
                    )

                  ),
                ),
              ),
              Divider(thickness: 2,)
            ],
          );
        }
    );

  }
  Future<void> _displayUpdatedTextInputDialog(BuildContext context,String title,String img,int index) async {
    setState(() {
      imgFile=null;
      _textFieldController.text=title;
    });
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context,setState){
                return AlertDialog(
                  title: Text('Update Service'),
                  content: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            valueText=_textFieldController.text;
                          });
                        },
                        controller: _textFieldController,
                        decoration: InputDecoration(hintText: "Service Title"),
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          InkWell(
                            onTap: ()async{
                              final res = await FilePicker.platform.pickFiles(type: FileType.image);
                              final file = res.files.first;
                              setState(() {
                                imgFile=file;
                              });

                            },
                            child: Container(
                              height: 30,
                              width: 90,
                              decoration:
                              BoxDecoration(border: Border.all(color: Colors.grey)),
                              child: Center(
                                child: Text("Attach",style: TextStyle(
                                    color: Colors.grey
                                ),),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          if(imgFile!=null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(imgFile.name,style: TextStyle(fontSize: 12),),
                              ],
                            ),
                          Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(img),
                                fit: BoxFit.cover,
                              ),
                              //shape: BoxShape.circle,
                            ),
                          ),

                        ],
                      )
                    ],
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
                          //services.add(valueText);

                          if(imgFile!=null){
                            storeImage();
                          }
                          else{
                            DataBase().updateService(valueText, img, index);
                          }
                          Navigator.pop(context);
                          _textFieldController.clear();
                        });
                      },
                    ),
                  ],
                );
              }

          );
        });
  }
}
