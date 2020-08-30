class Usuario {
  String nome;
  String email;
  String avatar;

  Usuario(String nome, String email, {String avatar = ""}) {
    this.nome = nome;
    this.email = email;
    this.avatar = avatar;
  }
}
