import 'dart:io';

import 'package:ICook/authentication.dart';
import 'package:ICook/services/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ICook/receita.dart';
import 'package:path/path.dart';

class CadastrarReceitasPage extends StatefulWidget {
  @override
  _CadastrarReceitasPageState createState() => _CadastrarReceitasPageState();
}

class _CadastrarReceitasPageState extends State<CadastrarReceitasPage> {
  final _formKey = GlobalKey<FormState>();
  final firestore = new Database();
  final auth = new Auth();

  final _nomeReceitaController = TextEditingController();
  final _ingredientesController = TextEditingController();
  final _modoDeFazerController = TextEditingController();
  final _rendimentoController = TextEditingController();
  final _tempoPreparoController = TextEditingController();

  File _image;
  final picker = ImagePicker();

  void cadastrar(Receita receita) async {
    var firebaseUser = await auth.getCurrentUser();
    firestore
        .cadastrarReceita(receita, firebaseUser.uid)
        .then((value) => showDialog('sucesso'));
  }

  void showDialog(String msg) {
    print(msg);
    acaoAposSalvar();
  }

  void acaoAposSalvar() {
    //TODO: fazer alguma coisa depois de salvar
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

  Future uploadImage(BuildContext context, Receita receita) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    if (uploadTask.isComplete) {
      receita.setImage(fileName);
      cadastrar(receita);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("iCook")),
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
                        "Postar Receita",
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
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _nomeReceitaController,
                      decoration: InputDecoration(
                        labelText: "Nome da Receita",
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
                      controller: _ingredientesController,
                      decoration: InputDecoration(
                        labelText: "Ingredientes",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _modoDeFazerController,
                      decoration: InputDecoration(
                        labelText: "Modo de fazer",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _rendimentoController,
                      decoration: InputDecoration(
                        labelText: "Rendimento",
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
                      controller: _tempoPreparoController,
                      decoration: InputDecoration(
                        labelText: "Tempo de preparo",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      onPressed: () {
                        String nomeReceita = _nomeReceitaController.text;
                        String ingredientes = _ingredientesController.text;
                        String modoDeFazer = _modoDeFazerController.text;
                        String rendimento = _rendimentoController.text;
                        String tempoPreparo = _tempoPreparoController.text;
                        Receita receita = new Receita(nomeReceita, ingredientes,
                            modoDeFazer, rendimento, tempoPreparo);

                        if (_image != null) {
                          uploadImage(context, receita);
                        } else {
                          cadastrar(receita);
                        }
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(child: Text('POSTAR')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
