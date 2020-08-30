class Usuario {
  String nome;
  String email;
  String sobrenome;
  String avatar;

  Usuario(String nome, String sobrenome, String email, {String avatar = ""}) {
    this.nome = nome;
    this.sobrenome = sobrenome;
    this.email = email;
    this.avatar = avatar;
  }
}
