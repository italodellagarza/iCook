import 'package:ICook/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:ICook/authentication.dart';
import 'package:ICook/model/user.dart';
import 'package:path/path.dart';

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
  final firestore = new Database();
  String imageReference;
  bool loading = false;

  TextEditingController campoNomeUsuarioController;
  TextEditingController campoSobrenomeUsuarioController;
  TextEditingController campoEmailUsuarioController;

  final _novaSenhaController = TextEditingController();
  final _repetirNovaSenhaController = TextEditingController();

  File _image;

  void getImagePath(String fileName) async {
    if (fileName != null) {
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      imageReference = await firebaseStorageRef.getDownloadURL();
    }
  }

  void carregarImagem(String fileName) async {
    if (fileName != null) {
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      firebaseStorageRef
          .getDownloadURL()
          .then((value) => setState(() => imageReference = value));
    }
  }

  @override
  void initState() {
    campoNomeUsuarioController = TextEditingController(text: widget.user.nome);
    campoSobrenomeUsuarioController =
        TextEditingController(text: widget.user.sobrenome);
    campoEmailUsuarioController =
        TextEditingController(text: widget.user.email);
    super.initState();
    carregarImagem(widget.user.avatar);
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

  Future uploadImage() async {
    String fileName = basename(_image.path);
    StorageReference fStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = fStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    if (uploadTask.isComplete) {
      print('Image uploaded');
      widget.user.avatar = fileName;
    }
  }

  void updateUser() {}

  void removeImage() {
    setState(() {
      _image = null;
    });
  }

  void atualizarDados() async {
    User firebaseUser = await widget.auth.getCurrentUser();

    if (_novaSenhaController.text.isNotEmpty) {
      // Atualizar senha do usuário no Firebase
      // await atualiza senha
      await firebaseUser.updatePassword(_novaSenhaController.text);
    }

    if (_image != null) {
      // Atualizar imagem no firebase
      await uploadImage();
    }
    widget.user.nome = campoNomeUsuarioController.text;
    widget.user.email = campoEmailUsuarioController.text;
    firestore.cadastrarUsuario(widget.user, firebaseUser.uid);
    // String displayName = "${widget.user.nome} ${widget.user.sobrenome}";
    // firebaseUser.updateProfile(<String, String>{
    //   "displayName": displayName,
    //   "photoURL": widget.user.avatar
    // });
    firebaseUser.updateEmail(campoEmailUsuarioController.text);
    firebaseUser.reload();
  }

  Widget _showCircularProgress() {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
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
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
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
                          if (_image != null || imageReference != null) ...[
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
                                          : Image.network(imageReference,
                                              fit: BoxFit.fill)),
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
                          controller: campoSobrenomeUsuarioController,
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
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                atualizarDados();
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _showCircularProgress(),
        ],
      ),
    );
  }
}
