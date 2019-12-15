import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Pages/productCard.dart';
import '../Pages/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Home extends StatefulWidget{

  // const Home({
  //   Key key, 
  //   @required this.user
  //   }) : super(key: key);
  //  final FirebaseUser user;

            
  
  @override
 _HomeState createState() =>_HomeState();

}

class _HomeState extends State<Home>{


  @override
  Widget build(BuildContext context) {
    var products = Firestore.instance.collection('products')
            .orderBy('timeStamp',descending: true).getDocuments();
    getData() async {
      return await Firestore.instance.collection('products').getDocuments();
    }

    getData().then((val){
        if(val.documents.length > 0){
            print(val.documents[0].data["title"]);
        }
        else{
            print("Not Found");
        }
    });
    getData();
    print('after');
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
//           Custom App bar
            CustomAppBar(),

//          Search Text field
            //Search(),

            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Recent products')),
                ),
              ],
            ),
            
            ProductCard(
              brand: 'SantosBrand',
              name: 'Lux Blazer',
              price: 24.00,
              onSale: true,
              picture: '',
            ),
            
          ],
        ),
      ),
    );
  
    
  }
  // ${widget.user.email}

} 