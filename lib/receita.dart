class Receita {
  String nomeReceita;
  String modoDeFazer;
  String rendimento;
  String ingredientes;
  String tempoPreparo;
  String imagem;

  Receita(nomeReceita, ingredientes, modoDeFazer, rendimento, tempoPreparo) {
    this.nomeReceita = nomeReceita;
    this.ingredientes = ingredientes;
    this.modoDeFazer = modoDeFazer;
    this.rendimento = rendimento;
    this.tempoPreparo = tempoPreparo;
  }

  void setImage(String fileName) {
    this.imagem = fileName;
  }
}
