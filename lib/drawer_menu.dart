import 'package:flutter/material.dart';


class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.black87,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(
                          'https://previews.123rf.com/images/dxinerz/dxinerz1508/dxinerz150800924/43773803-chef-cooking-cook-icon-vector-image-can-also-be-used-for-activities-suitable-for-use-on-web-apps-mob.jpg'
                        ),
                        fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Text("Usuário 1", 
                    style: TextStyle(
                      fontSize: 22, 
                      color: Colors.white
                    ),
                  ),
                  Text("usuário1@gmail.com", 
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Minha conta", style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: (){
              //Navigator.push(
              //  context, 
              //  MaterialPageRoute(builder: (BuildContext context) => CadastrarReceitasPage()),
              //);
              //Navigator.of(context).pop();
              print("AAAAAAAAAAAAAAAAAAAAAAAA");
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text("Logout", style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: (){
              
            },
          ),
        ],
      ),
    );
  }
}