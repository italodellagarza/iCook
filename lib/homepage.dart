import 'package:ICook/model/user.dart';
import 'package:ICook/recipe_tile.dart';
import 'package:flutter/material.dart';

import 'cadastrarreceitapage.dart';
import 'circularButton.dart';
import 'drawer_menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.auth}) : super(key: key);
  final auth;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Usuario user;

  AnimationController animationController;
  Animation degOneTranslationAnimation, degTwoTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
    getUserInfo();
  }

  void getUserInfo() async {
    var firebaseUser = await widget.auth.getCurrentUser();
    print(firebaseUser);
    setState(() {
      user = new Usuario(
          firebaseUser.email, firebaseUser.email, firebaseUser.email);
    });
    // TODO: ajutar os dados do usuario
    print(user);
  }

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
                      image: AssetImage("imgs/icon.png"),
                      fit: BoxFit.fitHeight),
                ),
              ),
              SizedBox(width: 5),
              Text("iCook"),
            ],
          ),
          backgroundColor: Colors.black54,
        ),
        drawer: MainDrawerPage(user: user, auth: widget.auth),
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.grey[300],
                child: ListView(
                  children: <Widget>[
                    RecipeTile(),
                    RecipeTile(),
                    RecipeTile(),
                    RecipeTile(),
                  ],
                ),
              ),
              Positioned(
                  right: 30,
                  bottom: 30,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      IgnorePointer(
                        child: Container(
                          color: Colors.white.withOpacity(
                              0.100), // comment or change to transparent color
                          height: 150.0,
                          width: 150.0,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(270),
                            degOneTranslationAnimation.value * 100),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degOneTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            color: Colors.green,
                            width: 50,
                            height: 50,
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onClick: () {
                              print('First Button');
                              animationController.reverse();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CadastrarReceitasPage()),
                              );
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(180),
                            degTwoTranslationAnimation.value * 100),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degTwoTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            color: Colors.black,
                            width: 50,
                            height: 50,
                            icon: Icon(
                              Icons.list,
                              color: Colors.white,
                            ),
                            onClick: () {
                              print('Third Button');
                              animationController.reverse();
                            },
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value)),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.red,
                          width: 60,
                          height: 60,
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onClick: () {
                            if (animationController.isCompleted) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                          },
                        ),
                      )
                    ],
                  )),
            ],
          ),
        )
        //ListView.builder(
        //  itemCount: items.count,
        //  itemBuilder: (ctx, i) => ItemTile(items.byIndex(i)),
        //),
        );
  }
}
