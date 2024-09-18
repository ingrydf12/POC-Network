# Network PDE

O objetivo desse repositório é guardar códigos que possibilitem o desenvolvimento de jogos multiplayer em Processing utilizando a biblioteca Network e protocolo TCP/IP.

# Overview
- **TCP (Transmission Control Protocol)**: Protocolo de comunicação que garante a entrega dos pacotes de dados na ordem correta e sem erros.
- **Socket**: Um ponto final de uma comunicação entre duas máquinas. Em TCP, um socket é usado para enviar e receber dados entre um cliente e um servidor, e cada um deles é associado a um endereço IP e porta.

## Configurando o servidor

### 1. Criação
É necessário criar dois arquivos .pde: um para o servidor e um para cliente (é possível testar com mais uma máquina). Dentro do arquivo server ou servidor.pde:

```java
import processing.net.*;  // Importa a biblioteca de rede

Server server;

void setup() {
  size(400, 400);
  server = new Server(this, 5204);  // Cria um servidor escutando na porta 5204, pode ser aleatória nesse momento*
}
```

### 2. Enviar e receber dados
No draw() do nosso arquivo, setamos funções pra enviar e receber dados do cliente.

```
void draw() {
  background(100); // Define o fundo da tela
  
  // Envia dados/mensagem para o servidor
  try {
    cliente.write("mensagem\n");
  } catch (Exception e) {
    println("Erro ao enviar mensagem: " + e.getMessage());
  }

  
  // Recebe dados do servidor
  // o available() -> verificar se há dados disponíveis para leitura do servidor, se for > 0 ->
   if (cliente.available() > 0) {
    String resposta = cliente.readString(); // Lê a resposta do server
    if (resposta != null) {
      println("Resposta do servidor: " + resposta.trim()); 
    }
  }
}
```

### Exemplo sem adicionais game

<b>Server.pde</b>
```import processing.net.*;

Server server;

void setup() {
  size(400, 400);
  server = new Server(this, 5204);
}

void draw() {
  background(200);
  
  Client novoCliente = server.available();
  if (novoCliente != null) {
    println("Novo cliente conectado.");
  }
  
  for (Client cliente : server.list()) {
    if (cliente.available() > 0) {
      String mensagem = cliente.readString();
      if (mensagem != null) {
        println("Mensagem recebida: " + mensagem.trim());
        cliente.write("Mensagem recebida: " + mensagem.trim() + "\n");
      }
    }
  }
}
```