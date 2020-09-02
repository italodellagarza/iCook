/// homepage.dart
/// classes MyHomePage e _MyHomePageState.
/// Responsável pela tela de página principal do aplicativo

import 'package:ICook/model/user.dart';
import 'package:ICook/view/personal_list.dart';
import 'package:ICook/view/recipe_tile.dart';
import 'package:ICook/control/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cadastrar_receitas_page.dart';
import 'drawer_menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.auth, this.logoutCallback})
      : super(key: key);
  final auth;
  final logoutCallback;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Usuario user;
  final firestore = new Database();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  void getUserInfo() async {
    var firebaseUser = await widget.auth.getCurrentUser();
    var userSaved =
        await firestore.getCollection('usuario').doc(firebaseUser.uid).get();
    setState(() {
      user = new Usuario(userSaved.data()['nome'],
          userSaved.data()['sobrenome'], userSaved.data()['email'],
          avatar: userSaved.data()['avatar']);
    });
  }

  static int currItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("imgs/icon.png"), fit: BoxFit.fitHeight),
              ),
            ),
            SizedBox(width: 5),
            Text("iCook"),
          ],
        ),
        backgroundColor: Colors.black54,
      ),
      drawer: MainDrawerPage(
          user: user, auth: widget.auth, logoutCallback: widget.logoutCallback),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currItem,
        //fixedColor: Colors.red,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: Colors.green,
              size: 50,
            ),
            title: Text(
              "Cadastrar Receita",
              style: TextStyle(color: Colors.green),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.black,
              size: 50,
            ),
            title: Text(
              "Minhas Receitas",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        onTap: (int i) {
          if (i == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CadastrarReceitasPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => PersonalListPage(
                        auth: widget.auth,
                      )),
            );
          }
        },
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.grey[300],
              child: StreamBuilder(
                  stream: firestore.getCollection('receita').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print('Error');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return LinearProgressIndicator();
                      default:
                        return Container(
                          child: ListView(
                              children: snapshot.data.documents
                                  .map<Widget>((DocumentSnapshot doc) {
                            return RecipeTile(
                              receita: doc.data(),
                            );
                          }).toList()),
                        );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
