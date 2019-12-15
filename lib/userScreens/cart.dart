import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../userScreens/itemdetails.dart';

class myCart extends StatefulWidget {
  var currentId;
  

  @override
  _myCartState createState() => _myCartState();
  myCart({this.currentId});
}

class _myCartState extends State<myCart> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cart "),
        centerTitle: false,
      ),
      //body: Text("${widget.currentId}"),
      body:  _draw(),
    );
  }
 Widget _draw(){
    Color cartColor;

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('cart').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return Card(
                  child: new Column(
                    children: <Widget>[
                  ListTile(
                  title: new Text(document['itemTitle'],style: TextStyle(color: Colors.indigo,fontSize: 20)),
                  ),
                   
                   Container(
                     color: Colors.purple,
                     child: Center(

                       child: Row(

                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(16.0),
                             child: Text("${document['itemPrice'].toString()} EG",
                             style: TextStyle(color: Colors.red,fontSize: 20),),
                           ),
                       
                      
                         ],
                       ),
                     ),
                   ),
                    ],
                  ),
                );
              }).toList(),  
            );
        }
      },
      
    );
    
  }
}
