# 🎬 PirataFlix

O **PirataFlix** é uma aplicação web de streaming desenvolvida como projeto acadêmico. O sistema permite visualizar filmes cadastrados, realizar autenticação de usuários e administrar os conteúdos da plataforma.

O projeto utiliza uma arquitetura com frontend, backend e banco de dados separados, executados em containers Docker.

## 🚀 Tecnologias utilizadas

### Frontend
- React
- JavaScript
- Vite
- Axios
- Nginx

### Backend
- Python
- Flask
- Psycopg

### Banco de dados
- PostgreSQL 16

### Infraestrutura
- Docker
- Docker Compose
- Dockerfile com build multi-stage no frontend
- Rede Docker para comunicação entre os containers
- Volume Docker para persistência dos dados

## 📌 Funcionalidades

- Cadastro e autenticação de usuários.
- Login de administrador.
- Listagem e visualização de filmes.
- Cadastro e gerenciamento de filmes pelo administrador.
- Gerenciamento de usuários.
- Sistema de favoritos.
- Registro de filmes assistidos.

## 🏗️ Arquitetura

A aplicação é dividida em três serviços principais:

| Serviço | Tecnologia | Função |
|---|---|---|
| Frontend | React + Nginx | Interface da aplicação e disponibilização dos arquivos estáticos |
| Backend | Python + Flask | Processamento das requisições e regras da aplicação |
| Banco de dados | PostgreSQL | Armazenamento dos dados |

### Comunicação entre os serviços

O navegador acessa o frontend através da porta `8080`. O Nginx disponibiliza a aplicação React e encaminha as requisições iniciadas com `/api/` para o backend Flask.

O backend acessa o PostgreSQL pela rede interna do Docker, utilizando o nome do serviço `db`.

```text
                 NAVEGADOR
                     |
                     | http://localhost:8080
                     v
              FRONTEND - NGINX
                     |
              +------+------+
              |             |
          Arquivos       /api/*
          React             |
                            v
                     BACKEND - FLASK
                            |
                            v
                       POSTGRESQL
```

Os serviços são definidos no arquivo `docker-compose.yml`.

## 📂 Estrutura do projeto

```text
PirataFlix/
│
├── Backend/
│   ├── helpers/
│   │   ├── application/
│   │   └── database/
│   │       ├── schema.sql
│   │       ├── seed_filmes.sql
│   │       ├── seed_usuarios.sql
│   │       ├── connection.py
│   │       └── init_db.py
│   │
│   ├── Dockerfile.node
│   └── requirements.txt
│
├── Frontend/
│   ├── src/
│   ├── nginx.conf
│   ├── Dockerfile.node
│   └── package.json
│
└── docker-compose.yml
```

## 🗄️ Inicialização do banco de dados

Na primeira inicialização, o backend executa automaticamente o arquivo `schema.sql`, responsável pela criação das tabelas.

Em seguida, os arquivos de seed são utilizados para inserir os dados iniciais:

- `seed_filmes.sql`: cadastra os filmes de demonstração.
- `seed_usuarios.sql`: cadastra as contas de demonstração.

Os dados são inseridos somente quando as tabelas correspondentes estão vazias.

O PostgreSQL utiliza um volume Docker para manter os dados mesmo depois que os containers forem parados ou removidos.

## ⚙️ Como executar o projeto

### Pré-requisitos

Antes de executar o projeto, é necessário ter instalado:

- Git
- Docker
- Docker Compose (plugin `docker compose`)

### 1. Clonar o repositório

```bash
git clone https://github.com/RafaelSouza707/RepositorioProjetoGSM.git
```

Entre na pasta do projeto:

```bash
cd RepositorioProjetoGSM
```

### 2. Construir e iniciar os containers

Execute:

```bash
docker compose up -d --build
```

Esse comando realiza o build das imagens, cria a rede e o volume necessários e inicia os três serviços.

Na primeira execução, o Docker pode precisar baixar as imagens utilizadas pelo projeto.

### 3. Verificar os containers

```bash
docker compose ps
```

Os serviços devem aparecer em execução. O banco de dados deve apresentar o status `healthy`.

### 4. Acessar a aplicação

Abra o navegador e acesse:

**http://localhost:8080**

O banco de dados e os dados de demonstração são preparados automaticamente pelo backend.

## 🔐 Contas para demonstração

O projeto possui duas contas iniciais para facilitar os testes.

| Tipo | E-mail | Senha |
|---|---|---|
| Administrador | admin@pirataflix.com | Pirataflix@123 |
| Usuário comum | usuario@pirataflix.com | Pirataflix@123 |

Essas são credenciais destinadas exclusivamente à demonstração acadêmica.

## 🐳 Comandos úteis do Docker

**Verificar os containers:**

```bash
docker compose ps
```

**Visualizar os logs de todos os serviços:**

```bash
docker compose logs
```

**Visualizar os logs do backend:**

```bash
docker compose logs backend
```

**Parar os containers:**

```bash
docker compose stop
```

**Iniciar novamente:**

```bash
docker compose start
```

**Remover os containers e a rede, preservando os dados do banco:**

```bash
docker compose down
```

**Reconstruir as imagens e iniciar novamente:**

```bash
docker compose up -d --build
```

**Atenção:** o comando `docker compose down -v` também remove o volume do banco de dados, apagando os dados armazenados.

---

**Projeto acadêmico — PirataFlix**