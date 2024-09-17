import processing.net.*;

Client cliente;
String servidorIP = "127.0.0.1";  // Substitua com o IP do servidor
float x, y;  // Posição do jogador
float velocidade = 2;  // Velocidade de movimento

void setup() {
  size(400, 400);
  cliente = new Client(this, servidorIP, 5204);  // Conecta ao servidor
  println("Conectando ao servidor...");
  
  // Posição inicial no centro
  x = width / 2;
  y = height / 2;
}

void draw() {
  background(100);
  fill(255);
  text("Use W, A, S, D para mover", 10, 20);
  
  // Movimenta o jogador com W, A, S, D
  if (keyPressed) {
    if (key == 'w' || key == 'W') y -= velocidade;
    if (key == 's' || key == 'S') y += velocidade;
    if (key == 'a' || key == 'A') x -= velocidade;
    if (key == 'd' || key == 'D') x += velocidade;
  }
  
  // Envia as novas coordenadas do jogador para o servidor
  cliente.write("posicao," + x + "," + y + "\n");
  
  // Verifica se há dados recebidos do servidor
  if (cliente.available() > 0) {
    String resposta = cliente.readString();
    if (resposta != null) {
      println("Mensagem do servidor: " + resposta.trim());
    }
  }

  // Desenha o jogador no cliente (circulo branco)
  fill(255);
  ellipse(x, y, 20, 20);
}
