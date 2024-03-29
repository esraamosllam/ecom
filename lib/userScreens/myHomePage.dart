import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import '../userScreens/list_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'favorites.dart';
import 'messages.dart';
import 'cart.dart';
import 'notifications.dart';
import 'history.dart';
import 'profile.dart';
import 'delivery.dart';
import 'aboutUs.dart';
//import 'login.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  var currentId;
  @override
  _MyHomePageState createState() => _MyHomePageState();
  //MyHomePage({this.currentId});
}

class _MyHomePageState extends State<MyHomePage> {
  BuildContext context;
  String acctName = "";
  String acctEmail = "";
  String acctPhotoURL = "";
  bool isLoggedIn;
  @override
  void initState() {
    print("from init");
    print(widget.currentId);
    // TODO: implement initState
    //getCurrentUser();
    super.initState();
  }

  // Future getCurrentUser() async {
  //   acctName = await getStringDataLocally(key: acctFullName);
  //   acctEmail = await getStringDataLocally(key: userEmail);
  //   acctPhotoURL = await getStringDataLocally(key: photoURL);
  //   isLoggedIn = await getBoolDataLocally(key: loggedIN);
  //   //print(await getStringDataLocally(key: userEmail));
  //   acctName == null ? acctName = "Guest User" : acctName;
  //   acctEmail == null ? acctEmail = "guestUser@email.com" : acctEmail;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    var userID;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;
   initUser() async{
    firebaseUser = await _firebaseAuth.currentUser();
    userID = firebaseUser.uid;
    print("this is user id");
    print(userID);
    setState(() {});
  }
  @override
  void initState(){
    super.initState();
    initUser();
  }
  
    this.context = context;
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: GestureDetector(
          //onLongPress: openAdmin,
          child: new Text("Girlies${userID}"),
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        new GirliesFavorities()));
              }),
          new Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            new GirliesMessages()));
                  }),
              new CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.red,
                child: new Text(
                  "0",
                  style: new TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            ],
          )
        ],
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new AllProudct(currentId: userID,)));
              },
              child: new Text("View all products"),
            )
            
          ],
        ),
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {
              initState();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> myCart(currentId: userID,)));
            },
            child: new Icon(Icons.shopping_cart),
          ),
          new CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: new Text(
              "0",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(acctName),
              accountEmail: new Text(acctEmail),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(Icons.person),
              ),
            ),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Order Notifications"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        new GirliesNotifications()));
              },
            ),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Order History"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new GirliesHistory()));
              },
            ),
            new Divider(),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Profile Settings"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new GirliesProfile()));
              },
            ),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Delivery Address"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new GirliesDelivery()));
              },
            ),
            new Divider(),
            new ListTile(
              trailing: new CircleAvatar(
                child: new Icon(
                  Icons.help,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("About Us"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new GirliesAboutUs()));
              },
              //
            ),
            
            RaisedButton(child: Text("All products"),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProudct(currentId: widget.currentId,)));
                },
                color: Colors.red,
                textColor: Colors.yellow,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
              )
          ],
        ),
      ),
    );
  }

  // checkIfLoggedIn() async {
  //   if (isLoggedIn == false) {
  //     bool response = await Navigator.of(context).push(new CupertinoPageRoute(
  //         builder: (BuildContext context) => new GirliesLogin()));
  //     if (response == true) getCurrentUser();
  //     return;
  //   }
  //   bool response = await appMethods.logOutUser();
  //   if (response == true) getCurrentUser();
  // }

  
}
