/* @ | usando o processing.net

*/
import processing.net.*;  // importação da biblioteca Network

Server server;
ArrayList<Jogador> jogadores = new ArrayList<Jogador>();

void setup() {
  size(400, 400);
  server = new Server(this, 5204);  // Servidor escutando na porta 5204
  //println("Servidor rodando...");
}

void draw() {
  background(200);
  fill(0);
  text("Clientes conectados: " + jogadores.size(), 10, 20);

  // Verifica novas conexões
  Client novoCliente = server.available();
  if (novoCliente != null) {
    // Verifica se o cliente já existe
    boolean clienteExiste = false;
    for (Jogador jogador : jogadores) {
      if (jogador.cliente == novoCliente) {
        clienteExiste = true;
        break;
      }
    }

    // Se for um novo cliente, adiciona à lista de jogadores
    if (!clienteExiste) {
      Jogador novoJogador = new Jogador(novoCliente);
      jogadores.add(novoJogador);
      println("Novo jogador conectado.");
    }
  }

  // Verifica se os jogadores estão enviando dados
  for (int i = jogadores.size() - 1; i >= 0; i--) {
    Jogador jogador = jogadores.get(i);
    if (jogador.isConnected()) {
      String msg = jogador.receberDados();
      if (msg != null) {
        String[] dados = msg.split(",");
        if (dados.length == 3 && dados[0].equals("posicao")) {
          //Atualiza as posições
          jogador.x = float(dados[1]);
          jogador.y = float(dados[2]); 
          println("Jogador " + i + " posição: (" + jogador.x + ", " + jogador.y + ")"); //DEBUG Update Posição do Player
        }
      }
    } else {
      jogadores.remove(i);
      println("Jogador desconectado.");
    }
  }

  // Desenha os jogadores
  for (Jogador jogador : jogadores) {
    fill(0, 0, 255);
    ellipse(jogador.x, jogador.y, 20, 20);
  }
}
