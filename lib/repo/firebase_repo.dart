import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DataBase{
  FirebaseFirestore db=FirebaseFirestore.instance;
  Future<void> addService(String serviceName,String imgURL) async
  {
    try{
      await db.collection("Services").add({
        'name': serviceName,
        'imgURL':imgURL
      });
    }catch(e){
      print(e);
    }
  }
  Future<Stream> getServices()async
  {
    return db.collection("Services").snapshots();
  }
  Future<void> updateService(String name,String imgURL,int i)async{
    try{
      String id=await docId(i);
      await db.collection("Services").doc(id).update(
          {
            'name': name,
            'imgURL':imgURL
          }
      );
    }catch(e){
      print(e);
    }
  }
  Future<void> deleteService(int i)async
  {
    try{
      String id=await docId(i);
      await db.collection("Services").doc(id).delete();
    }catch(e){
      print(e);
    }
  }
  Future<String> docId(int i)async
  {
    QuerySnapshot querySnapshot= await db.collection("Services").get();
    if(querySnapshot.docs.isNotEmpty){
      List list=querySnapshot.docs.toList();
      return list[i].id;
    }
    return "0";
  }
  Future<void> addSubService(String subServiceName,String price,String description,String imgURL,int i) async
  {
    try{
      String id=await docId(i);
      await db.collection("Services").doc(id).collection("SubServices").add({
        'name': subServiceName,
        'price': price,
        'description':description,
        'imgURL':imgURL
      });
    }catch(e){
      print(e);
    }
  }
  Future<Stream> getSubService(int i)async
  {
    String id=await docId(i);
    return db.collection("Services").doc(id).collection("SubServices").snapshots();
  }
  Future<void> updateSubService(String subServiceName,String price,String description,String imgURL,int mainid,int subid)async{
    try{
      String id1=await docId(mainid);
      String id2=await getSubdocId(mainid,subid);

      await db.collection("Services").doc(id1).collection("SubServices").doc(id2).update(
          {
            'name': subServiceName,
            'price': price,
            'description':description,
            'imgURL':imgURL
          }
      );
    }catch(e){
      print(e);
    }
  }
  Future<void> deleteSubService(int mainid,int subid)async
  {
    try{
      String id1=await docId(mainid);
      String id2=await getSubdocId(mainid,subid);
      await db.collection("Services").doc(id1).collection("SubServices").doc(id2).delete();
    }catch(e){
      print(e);
    }
  }
  Future<String> getSubdocId(int mainid,int subid)async
  {
    String id=await docId(mainid);
    print(id);
    QuerySnapshot querySnapshot= await db.collection("Services").doc(id).collection("SubServices").get();
    if(querySnapshot.docs.isNotEmpty){
      List list=querySnapshot.docs.toList();
      print(list[subid].id);
      return list[subid].id;
    }
    return "0";
  }


}