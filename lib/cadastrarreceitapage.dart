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
  final picker = ImagePicker();

  bool loading = false;
  File _image;

  void cadastrar(Receita receita, BuildContext context) async {
    var firebaseUser = await auth.getCurrentUser();
    firestore.cadastrarReceita(receita, firebaseUser.uid).then((value) {
      exibirConfirmacao(context);
    });
  }

  void exibirConfirmacao(BuildContext context) {
    setState(() {
      loading = false;
    });
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sucesso!'),
            content: Text('Sua receita foi publicada com sucesso!'),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok'),
                  onPressed: () =>
                      {Navigator.of(context).pop(), Navigator.pop(context)})
            ],
          );
        });
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
      cadastrar(receita, context);
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
                      onPressed: loading
                          ? null
                          : () {
                              setState(() {
                                loading = true;
                              });
                              String nomeReceita = _nomeReceitaController.text;
                              String ingredientes =
                                  _ingredientesController.text;
                              String modoDeFazer = _modoDeFazerController.text;
                              String rendimento = _rendimentoController.text;
                              String tempoPreparo =
                                  _tempoPreparoController.text;
                              Receita receita = new Receita(
                                  nomeReceita,
                                  ingredientes,
                                  modoDeFazer,
                                  rendimento,
                                  tempoPreparo);

                              if (_image != null) {
                                uploadImage(context, receita);
                              } else {
                                cadastrar(receita, context);
                              }
                            },
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: loading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    backgroundColor: Colors.white,
                                  ),
                                )
                              : Text('POSTAR')),
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
