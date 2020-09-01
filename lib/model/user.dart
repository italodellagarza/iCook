///
/// user.dart
/// Classe Usuário
/// Responsável por armazenar os dados do usuário, sendo interligado aos dados
/// de autenticação no Firebase.
///
class Usuario {
  String nome;
  String email;
  String sobrenome;
  String avatar;

  Usuario(String nome, String sobrenome, String email,
      {String avatar = "user_default.png"}) {
    this.nome = nome;
    this.sobrenome = sobrenome;
    this.email = email;
    this.avatar = avatar;
  }
}
