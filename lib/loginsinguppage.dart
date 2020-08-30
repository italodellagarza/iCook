import 'package:flutter/material.dart';

import 'package:ICook/authentication.dart';
import 'package:ICook/model/user.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  String _nomeUsuario;
  String _sobrenomeUsuario;

  bool _isLoginForm;
  bool _isLoading;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          Usuario usuario = new Usuario(_nomeUsuario, _sobrenomeUsuario);
          userId = await widget.auth.signUp(_email, _password);
          // TODO cadastrar instância no firabase usand  userId e usuario.
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
    ;
    setState(() {
      _isLoading:
      false;
    });
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
    if (_isLoginForm) {
      setState(() {
        _nomeUsuario = " ";
        _sobrenomeUsuario = " ";
      });
    } else {
      setState(() {
        _nomeUsuario = null;
        _sobrenomeUsuario = null;
      });
    }
    resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _showForm(),
          _showCircularProgress(),
        ],
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showUserNameField() {
    if (!_isLoginForm) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: TextFormField(
            maxLines: 1,
            autofocus: false,
            decoration: InputDecoration(
                hintText: 'Seu nome',
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                )),
            validator: (value) =>
                value.isEmpty ? 'O seu nome não pode estar vazio.' : null,
            onSaved: (value) {
              setState(() {
                _nomeUsuario = value.trim();
              });
            }),
      );
    } else {
      return Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0));
    }
  }

  Widget _showUserSurnameField() {
    if (!_isLoginForm) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: TextFormField(
            maxLines: 1,
            autofocus: false,
            decoration: InputDecoration(
                hintText: 'Seu sobrenome',
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                )),
            validator: (value) =>
                value.isEmpty ? 'O seu sobrenome não pode estar vazio.' : null,
            onSaved: (value) {
              setState(() {
                _sobrenomeUsuario = value.trim();
              });
            }),
      );
    } else {
      return Container(
        color: Colors.white,
      );
    }
  }

  Widget _showForm() {
    return Container(
      color: Colors.red,
      child: Container(
          child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            showErrorMessage(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  ClipRRect(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.amber,
                      ),
                      child: Image.asset('imgs/icon.png'),
                    ),
                    borderRadius: BorderRadius.circular(150),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'iCook',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: const Offset(0, 0),
                          spreadRadius: 8,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height * .6,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 30.0, 0.0, 0.0),
                              child: Text('LOGIN',
                                  style: TextStyle(
                                      fontSize: 30.0, color: Colors.red)),
                            ),
                            _showUserNameField(),
                            _showUserSurnameField(),
                            Padding(
                              //Campo de email
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 15.0, 0.0, 0.0),
                              child: TextFormField(
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                decoration: InputDecoration(
                                    hintText: 'e-mail',
                                    icon: Icon(
                                      Icons.mail,
                                      color: Colors.grey,
                                    )),
                                validator: (value) => value.isEmpty
                                    ? 'O e-mail não pode ser vazio'
                                    : null,
                                onSaved: (value) {
                                  setState(() {
                                    _email = value.trim();
                                  });
                                },
                              ),
                            ),
                            Padding(
                              //Campo de senha
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 15.0, 0.0, 0.0),
                              child: TextFormField(
                                  maxLines: 1,
                                  obscureText: true,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                      hintText: 'Senha de 6 digitos',
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      )),
                                  validator: (value) => value.isEmpty
                                      ? 'A senha não pode ser vazia'
                                      : null,
                                  onSaved: (value) {
                                    setState(() {
                                      _password = value.trim();
                                    });
                                  }),
                            ),
                            Padding(
                                //Botão primário
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: Colors.blue,
                                    child: Text(
                                      _isLoginForm ? 'Login' : 'Criar conta',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                    onPressed: validateAndSubmit,
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                              child: FlatButton(
                                //Botão secundário
                                child: Text(
                                  _isLoginForm
                                      ? 'Criar uma conta'
                                      : 'Tem uma conta? Entrar',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                ),
                                onPressed: toggleFormMode,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 30.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }
}
