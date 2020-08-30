import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:ICook/authentication.dart';
import 'package:ICook/model/user.dart';

class MinhaContaPage extends StatefulWidget {
  MinhaContaPage({this.user, this.auth});
  final Usuario user;
  final Auth auth;
  @override
  _MinhaContaPageState createState() => _MinhaContaPageState();
}

class _MinhaContaPageState extends State<MinhaContaPage> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  TextEditingController campoNomeUsuarioController;
  TextEditingController campoSobrenomeUsuarioController;
  TextEditingController campoEmailUsuarioController;

  final _novaSenhaController = TextEditingController();
  final _repetirNovaSenhaController = TextEditingController();

  File _image;

  @override
  void initState() {
    campoNomeUsuarioController = TextEditingController(text: widget.user.nome);
    campoSobrenomeUsuarioController =
        TextEditingController(text: widget.user.nome);
    campoEmailUsuarioController = TextEditingController(text: widget.user.nome);
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile.path != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // uploadImage(context, receita);
    }
  }

  void removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO
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
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Minha conta",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      if (_image != null) ...[
                        Center(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.red,
                            child: ClipOval(
                              child: SizedBox(
                                width: 190,
                                height: 190,
                                child: (_image != null)
                                    ? Image.file(_image, fit: BoxFit.fill)
                                    : Image.network(
                                        'gs://icook-gcc144.appspot.com/image_picker5940230501014420480.jpg',
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.add_a_photo),
                            onPressed: getImage,
                            tooltip: 'Escolher imagem',
                          ),
                          if (_image != null) ...[
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: removeImage,
                              tooltip: 'Apagar imagem',
                            )
                          ]
                        ],
                      )),
                    ],
                  ),
                  //Nome
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: campoNomeUsuarioController,
                      decoration: InputDecoration(
                        labelText: "Nome",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: campoNomeUsuarioController,
                      decoration: InputDecoration(
                        labelText: "Sobrenome",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: campoEmailUsuarioController,
                      decoration: InputDecoration(
                        labelText: "e-mail",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _novaSenhaController,
                      obscureText: true,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Nova senha",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _repetirNovaSenhaController,
                      obscureText: true,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Repetir nova senha",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: (value) =>
                          (value.trim() == _novaSenhaController.text)
                              ? 'As senhas precisam estar iguais'
                              : null,
                    ),
                  ),

                  Padding(
                      //Botão primário
                      padding: EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.green,
                          child: Text(
                            'Atualizar Dados',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          onPressed: () {
                            // TODO Atualizar os dados no Firebase
                            // ATENÇÃO: Se o campo senha estiver nulo,
                            // desconsiderá-lo na hora de modificar os dados
                          },
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
