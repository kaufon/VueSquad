# Vue Squad

Vue Squad é um projeto pessoal que permite criar usuários, squads, autenticação e tarefas (tasks). O projeto utiliza Ruby on Rails para o backend e Vue.js para o frontend, oferecendo uma interface moderna e eficiente para o gerenciamento de squads e tarefas.

## Funcionalidades

### Funcionalidades Principais

- **Cadastro e Autenticação de Usuários**:
  - Usuários podem se registrar com nome, e-mail e senha.
  - Autenticação via token JWT para garantir segurança.
  - Sistema de login com validação de credenciais.

- **Criação e Gerenciamento de Squads**:
  - Usuários podem criar e editar squads.
  - Cada squad pode ter múltiplos membros, com permissão para adicionar e remover membros.

- **Criação e Gerenciamento de Tarefas (Tasks)**:
  - Usuários podem criar tarefas dentro dos squads.
  - Tarefas podem ser atribuídas a membros específicos do squad.
  - Cada tarefa pode ter um status (ex.: pendente, em progresso, concluída).
  - Possibilidade de editar e excluir tarefas.

- **Interface Intuitiva e Responsiva**:
  - O frontend é desenvolvido com Vue.js, proporcionando uma interface dinâmica e de fácil navegação.
  - A interface é responsiva e otimizada para dispositivos móveis.

- **Notificações em Tempo Real**:
  - Notificações para alterações em tarefas ou squads (em progresso).

- **Filtros e Ordenação de Tarefas**:
  - Filtros por status, data de criação e data de conclusão.
  - Ordenação de tarefas por data ou prioridade.

## Requisitos Funcionais

1. **Cadastro de Usuário**: O sistema deve permitir que novos usuários se registrem.
2. **Login de Usuário**: O sistema deve permitir que usuários autenticados façam login utilizando e-mail e senha.
3. **Criação de Squad**: O sistema deve permitir que usuários criem squads e adicione membros.
4. **Criação de Tarefas**: O sistema deve permitir a criação de tarefas dentro de um squad.
5. **Gerenciamento de Tarefas**: O sistema deve permitir a edição, remoção e atribuição de tarefas a membros do squad.
6. **Visualização de Tarefas**: O sistema deve permitir a visualização de todas as tarefas de um squad.

## Requisitos Não Funcionais

1. **Segurança**:
   - A autenticação deve ser realizada por meio de tokens JWT.
   - Senhas devem ser criptografadas antes de serem armazenadas.
2. **Responsividade**:
   - A interface deve ser responsiva, funcionando bem em diferentes tamanhos de tela, incluindo dispositivos móveis.
3. **Testes**:
   - Backend deve estar totalmente testado com rSpec

## Tecnologias Utilizadas

- **Backend**: Ruby on Rails, JWT para autenticação
- **Frontend**: Vue.js, Vuex, Vue Router
- **Banco de Dados**: SQLite (ou outro banco de sua escolha)
- **Autenticação**: JWT (JSON Web Token)

## Como Rodar o Projeto
### Pre-requisitos:
- Rails 8.0.0
- Ruby 3.3.6
- Node

1. Clone o repositório:
   ```bash
   git clone https://github.com/kaufon/VueSquad.git
    ```
2. Instale as dependencias do backend
    ```bash
    cd apps/server && bundler install
    ```
2. Instale as dependencias do frontend
    ```bash
    cd apps/web && npm install
    ```
3. Rode o projeto dentro da pasta `apps`
     ```bash
    npm run dev
    ```
