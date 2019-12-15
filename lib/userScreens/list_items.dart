import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../userScreens/itemdetails.dart';
import '../userScreens/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AllProudct extends StatefulWidget {
  var currentId;
  @override
  _Allproductstate createState() => _Allproductstate();
  AllProudct({this.currentId});
}

class _Allproductstate extends State<AllProudct> {
  // final db = Firestore.instance;
  // FirebaseUser currentUser;
   
  

  @override
  Widget build(BuildContext context) {
    print("from file");
                            print(widget.currentId);
    return Scaffold(
      appBar: AppBar(
        title: Text(' My Proudct'),
      ),
      body: _draw(),
      //  Column(
      //   children: <Widget>[
      //     _draw(),
      //     RaisedButton(child: Text("All products"),
      //           onPressed: (){
      //             Navigator.push(context, MaterialPageRoute(builder: (context)=> myCart(currentId: widget.currentId,)));
      //           },
      //           color: Colors.red,
      //           textColor: Colors.yellow,
      //           padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      //           splashColor: Colors.grey,
      //         )
      //   ],
      // ),
      
    );
  }
  Widget _draw(){
    Color cartColor;

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
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
                  title: new Text(document['title'],style: TextStyle(color: Colors.indigo,fontSize: 20)),
                  subtitle: new Text(document['description'],style: TextStyle(color: Colors.black87,fontSize: 15)),
                  ),
                   Container(

                    //    width: 320.0,
                    //    height: 100.0,
                    //  color: Colors.indigo,
                    height: 170.0,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(document['image']),
                    fit: BoxFit.fitHeight),
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(120.0),
                  bottomLeft: new Radius.circular(120.0),
                )),
                   ) ,
                   Container(
                     color: Colors.blue[100],
                     child: Center(

                       child: Row(

                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(16.0),
                             child: Text("${document['price'].toString()} EG",
                             style: TextStyle(color: Colors.red,fontSize: 20),),
                           ),
                       IconButton(icon: Icon(Icons.delete,color: Colors.red,),
                         onPressed: (){
                           Firestore.instance.collection('products').document(document.documentID).delete();
                         },),
                         IconButton(icon: Icon(Icons.shopping_cart,color: cartColor,),
                         onPressed: (){
                           setState(() {
                              cartColor = Colors.yellow; // Change icon and setState to rebuild
                          });
                            print("from on pr");
                            print(widget.currentId);
                            Firestore.instance.collection('cart')..add(
                              {
                                "userId":widget.currentId,
                                "itemTitle": document['title'],
                                "itemPrice": document['price'],
                              }
                            );
                         },),
                         IconButton(icon:
                         
                          Icon(Icons.details,color: Colors.blue,),
                         onPressed: (){
                           Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new ItemDetail(
                              itemImage: document['image'],
                              itemName: document['title'],
                              itemDescription: document['description'],
                              itemPrice: document['price'],
                              
                            )));
                         },),
                          RaisedButton(child: Text("my cart"),
                onPressed: (){
                  print("object");
                  print( widget.currentId);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> myCart(currentId: widget.currentId,)));
                },
                color: Colors.red,
                textColor: Colors.yellow,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
              )
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