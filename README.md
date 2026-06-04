# 📱 Plus Notes App

O **Plus Notes (PN)** é uma aplicação mobile desenvolvida com **Flutter** que permite aos usuários criar, visualizar, editar e remover anotações de forma simples e intuitiva.

O projeto foi criado com o objetivo de praticar conceitos fundamentais do desenvolvimento mobile, incluindo gerenciamento de estado, persistência de dados local, arquitetura modular e experiência do usuário, simulando funcionalidades presentes em aplicações reais de produtividade.

</br >

## 🚀 Funcionalidades

### 🔐 Autenticação de Usuários

* Cadastro de novos usuários;
* Login com validação de credenciais;
* Controle de sessão do usuário.

### 📝 Gerenciamento de Anotações

* Criação de anotações;
* Edição de anotações existentes;
* Exclusão de anotações;
* Listagem de anotações cadastradas;
* Visualização detalhada de anotações;
* Registro de data de criação das anotações.

</br >

## 🛠️ Tecnologias Utilizadas

* Flutter
* Dart
* SQLite
* Provider
* Material Design

</br >

## 🏗️ Arquitetura

O projeto segue uma arquitetura modular baseada em **Features**, promovendo separação de responsabilidades, escalabilidade e facilidade de manutenção.

```text
lib/
├── core/                 # Serviços e configurações globais
├── shared/               # Componentes, utilitários e recursos compartilhados
└── features/
     ├── auth/            # Funcionalidades de autenticação
     └── notes/           # Funcionalidades de anotações
```

Cada feature é organizada em camadas para separar responsabilidades da aplicação.

</br >

## 💾 Persistência de Dados

A aplicação utiliza **SQLite** para armazenamento local dos dados, permitindo que as informações permaneçam disponíveis mesmo após o fechamento do aplicativo.

### Operações implementadas

#### Usuários

* Criar usuário;
* Buscar usuário;
* Validar credenciais de login;

#### Anotações

* Criar anotação;
* Listar anotações;
* Atualizar anotação;
* Remover anotação.

</br >

## 🎯 Objetivos do Projeto

Este projeto foi desenvolvido com foco em:

* Desenvolvimento de aplicações mobile com Flutter;
* Implementação de arquitetura modular baseada em features;
* Persistência de dados utilizando SQLite;
* Aplicação de boas práticas de organização de código;
* Gerenciamento de estado com Provider;
* Simulação de funcionalidades encontradas em aplicações reais.

</br >

## 👨‍💻 Autor

Desenvolvido por **Renan Lopes Lima Teles**.

- GitHub: https://github.com/renan-teles

</br >

<!-- 
# plus_notes_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference. 
-->
