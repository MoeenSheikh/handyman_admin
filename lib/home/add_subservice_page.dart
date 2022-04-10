import 'package:flutter/material.dart';
class AddSubServicePage extends StatefulWidget {
  String title;
  List subService;
  AddSubServicePage({Key key, this.title,this.subService}) : super(key: key);

  @override
  _AddSubServicePageState createState() => _AddSubServicePageState();
}

class _AddSubServicePageState extends State<AddSubServicePage> {
  String valueText = "";
  String valueprice = "";
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textPriceFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Sub Service'),
            content: Column(
              children: [

                TextField(
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    });
                  },
                  controller: _textFieldController,
                  decoration: InputDecoration(hintText: "Sub Service Title"),
                ),
                SizedBox(height: 10,),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      valueprice = value;
                    });
                  },
                  controller: _textPriceFieldController,
                  decoration: InputDecoration(hintText: "Price"),
                ),
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
                    widget.subService.add({
                      "name":valueText,
                      "price":valueprice
                    });
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
          child: Text(widget.title,
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
                    itemCount: widget.subService.length,
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          ListTile(
                            title: Text(widget.subService[index]["name"]),
                            leading: Icon(Icons.design_services),
                            trailing: Text("Rs. ${widget.subService[index]["price"]}"),
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
