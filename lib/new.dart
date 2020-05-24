import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Name12 extends StatefulWidget {
  static String tag = 'users-page';

  @override
  State<StatefulWidget> createState() {
    return new _UsersListState();
  }
}

class _UsersListState extends State<Name12> {
  Future<List<User>> _getUsers() async {
    List<User> users = [];
    var response = await get('https://simplifiedcoding.net/demos/view-flipper/heroes.php');

    //var jsonData = JSON.decode(response.body);
    var jsonData = jsonDecode(response.body);

    var usersData = jsonData["heroes"];

    for (var user in usersData) {
      User newUser = User(user["name"],user["imageurl"]);

      users.add(newUser);
    }

    return users;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          title: Text('Users',

              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),

      body: Container(
        child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return /*ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      UserDetailPage(snapshot.data[index])));
                        },
                        title: Text(snapshot.data[index].name),
                       subtitle: Text(snapshot.data[index].imageUrl),
                        leading: CircleAvatar(
                            backgroundImage:
                            NetworkImage(snapshot.data[index].imageUrl)),
                      );
                    });*/

                  GridView.builder(

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
padding: EdgeInsets.all(3),
                        height: double.minPositive,
                        child: Card(

                                        color: Colors.white,
                          elevation: 5,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(


                            children: <Widget>[


                              ListTile(
                                contentPadding: EdgeInsets.all(5.0),

                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              UserDetailPage(
                                                  snapshot.data[index])));
                                },
                                title: Text(snapshot.data[index].name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      textBaseline: TextBaseline.alphabetic,
                                      color: Colors.red

                                  ),),
                                subtitle: Text(snapshot.data[index].imageUrl,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      textBaseline: TextBaseline.alphabetic,
                                      color: Colors.red

                                  ),),

                                leading: CircleAvatar(

                                    radius: 30,
                                    backgroundImage:
                                    NetworkImage(
                                        snapshot.data[index].imageUrl)),
                              ),

                            ],


                          ),


                        ),


                      );

                    },
                  );


              }
            }),

      ),

    );
  }
}

class User {
  final String name;


  final String imageUrl;


  User(this.name,this.imageUrl);
}

class UserDetailPage extends StatelessWidget {
  final User user;

  UserDetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
    );
  }
}
