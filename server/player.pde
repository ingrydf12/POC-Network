class Jogador {
  Client cliente;
  float x, y;  // Posição do jogador
  
  Jogador(Client c) {
    cliente = c;
    x = width / 2;  // Posição inicial no centro
    y = height / 2;
  }
  
  boolean isConnected() {
    return cliente.active();
  }
  
  String receberDados() {
    if (cliente.available() > 0) {
      String input = cliente.readString();
      return (input != null) ? input.trim() : null;
    }
    return null;
  }

  void enviarDados(String dados) {
    cliente.write(dados + "\n");
  }
}
