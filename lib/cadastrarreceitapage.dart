import 'package:flutter/material.dart';
import 'package:ICook/receita.dart';

class CadastrarReceitasPage extends StatefulWidget {
  @override
  _CadastrarReceitasPageState createState() => _CadastrarReceitasPageState();
}

class _CadastrarReceitasPageState extends State<CadastrarReceitasPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeReceitaController = TextEditingController();
  final _ingredientesController = TextEditingController();
  final _modoDeFazerController = TextEditingController();
  final _rendimentoController = TextEditingController();

  void cadastrar(Receita receita) {
    // TODO postar no banco de dados
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
                    child: RaisedButton(
                      onPressed: () {
                        String nomeReceita = _nomeReceitaController.text;
                        String ingredientes = _ingredientesController.text;
                        String modoDeFazer = _modoDeFazerController.text;
                        String rendimento = _rendimentoController.text;
                        cadastrar(new Receita(nomeReceita, ingredientes,
                            modoDeFazer, rendimento));
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
