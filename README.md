# Blog de exemplo

Esse projeto é um exemplo de Blog construído utilizando Node/TypeScript/GraphQL/Prisma.

Dentro dessa stack cada ferramenta tem sua própria responsabilidade:

- **Node**: Lidar com as requisições HTTP provindas do front-end;
- **Typescript**: Adicionar tipagem estática e intellisense ao editor para autocomplete do GraphQL;
- **GraphQL**: Prover a linguagem de comunicação entre front-end e back-end fornecendo a habilidade de definir campos, filtros, paginação, entre outros para o cliente;
- **Prisma**: Fornecer uma camada de abtração da comunicação do servidor com o banco de dados unificando a Query Language independente do tipo de base (Mongo, SQL, ElasticSearch, etc...) e habilitando a utilização de GraphQL para conversação com a camada da database.

## Rodando o Prisma

Clone o projeto e instale suas dependências:

```
git clone https://github.com/diego3g/blog-graphql-prisma
cd blog-graphql-prisma
npm install
```

A partir daqui você precisará do [https://www.docker.com/](Docker) instalado.

Criar arquivo com variáveis ambiente:

```
touch .env
```

Dentro desse arquivo adicione algumas configurações estáticas:

```
DEBUG=true

# Utilizado para criptografia do token de autenticação entre node -> prisma
APP_SECRET=secret123

# Utilizado para possibilitar deploy para o servidor prisma criado
PRISMA_MANAGEMENT_API_SECRET=prisma123

# Credenciais do banco de dados, não precisa ter banco nenhum rodando
DB_USER=blogrocket
DB_PASSWORD=blogrocket
DB_DATABASE=blog

# URL final do playground do Prisma (não altere esse endereço)
PRISMA_ENDPOINT=http://localhost:4466/
```

Agora com o Docker vamos subir nossos containers:

```
docker-compose up -d
```

Com o servidor criado executaremos nossas migrations para o Prisma montar a base de dados:

```
prisma deploy
```

Agora se tudo ocorreu bem você poderá acessar o playgroud do GraphQL em http://localhost:4466

Faça um teste de Query para criar um novo usuário no DB utilizando:

```graphql
mutation {
  createUser(
    data: { name: "John Doe", email: "johndoe@example.com", password: "123456" }
  ) {
    id
    name
  }
}
```

Agora para listar os usuários criados:

```graphql
query {
  users {
    name
  }
}
```

## Rodando back-end NodeJS

Com o Prisma rodando você já pode executar seu projeto em NodeJS que poderá consumir os dados do Prisma e se comunicar com seu front-end:

```
npm run dev
```

Esse comando além de iniciar o servidor na porta 4000 irá abrir um playgroud parecido com o do Prisma que lhe dará acesso à API GraphQL do seu servidor e também do Prisma em outra aba navegável pelo menu lateral.

Agora, no playground você poderá criar um novo usuário e receber seu token JWT por exemplo com:

```graphql
mutation {
  signup(name: "Diego", email: "diego@rocketseat.com.br", password: "123456") {
    token
  }
}
```

Todas as queries/mutations/subscriptions possíveis estão disponíveis no menu "SCHEMA" dentro do playground.

## Realizando operações no playground do Prisma

Para executar operações no playground do Prisma você precirará um token JWT gerado por:

```
prisma token
```

Com esse token adicione na aba HTTP Headers do Playground do Prisma o seguinte:

```
{
  "Authorization": "Bearer __TOKEN__"
}
```
