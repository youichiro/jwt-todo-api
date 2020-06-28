# jwt-todo-api

JSON Web Token(JWT)でユーザ承認するテスト用APIです

## versions
ruby: 2.6.5<br>
rails: 6.0.3.2

## usage

```bash
git clone https://github.com/youichiro/jwt-todo-api.git
cd jwt-todo-api
echo "export MYSQL_USER='<MySQLのユーザ名>'" >> ~/.bashrc
echo "export MYSQL_PASSWORD='<MySQLのパスワード>'" >> ~/.bashrc
source ~/.bashrc
bin/rails db:create
bin/rails db:migrate
bin/rails s
```

## endpoints

```
JWTの発行
  POST   /api/sessions(.:format)    sessions#create

ユーザの作成・取得
  POST   /api/users(.:format)       users#create
  GET    /api/users/:id(.:format)   users#show

タスクのCRUD
  GET    /api/tasks(.:format)       tasks#index
  POST   /api/tasks(.:format)       tasks#create
  GET    /api/tasks/:id(.:format)   tasks#show
  PATCH  /api/tasks/:id(.:format)   tasks#update
  PUT    /api/tasks/:id(.:format)   tasks#update
  DELETE /api/tasks/:id(.:format)   tasks#destroy
```

## データベース設計

### users

|カラム名|型|説明|オプション|
|---|---|---|---|
|id|integer|id|primary_key|
|name|string|ユーザ名|null: false, limit: 100|
|email|string|メールアドレス|null: false, limit: 100, index: true, unique: true|
|password_digest|string|暗号化されたパスワード|null: false|
|created_at|datetime|作成日時||
|updated_at|datetime|更新日時||

### tasks

|カラム名|型|説明|オプション|
|---|---|---|---|
|id|integer|id|primary_key|
|user_id|integer|usersテーブルの外部キー||
|title|integer|タスクタイトル|null: false, limit: 100|
|done|boolena|完了済みどうか|null: false, default: false|
|created_at|datetime|作成日時||
|updated_at|datetime|更新日時||


## curlで確認

### JWTを発行する

```
$ curl -X POST -H "Content-Type: application/json" -i
  -d '{"email": "admin@gmail.com", "password": "password"}' http://localhost:3000/api/sessions

HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
X-Authentication-Token: <JWT>
Content-Type: application/json; charset=utf-8
ETag: W/"8dea9e62ac9535911b109a06654fa3f0"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: f4e9a14b-74a0-460e-a8ab-7c43609f0360
X-Runtime: 0.206253
Vary: Origin
Transfer-Encoding: chunked

{"id":1,"name":"admin","email":"admin@gmail.com","created_at":"2020-06-28T21:43:46.344Z",
"updated_at":"2020-06-28T21:43:46.344Z"}
```

レスポンスヘッダの`X-Authentication-Token`にJWTが乗っている<br>
これをリクエストヘッダの`Authorization`に指定することでユーザ承認できる

### JWTでユーザを取得する

```
$ curl -H "Authorization: Bearer <JWT>" http://localhost:3000/api/users/1

{"id":1,"name":"admin","email":"admin@gmail.com","created_at":"2020-06-28T21:43:46.344Z",
"updated_at":"2020-06-28T21:43:46.344Z"}%
```

### JWTでタスクを作成する

```
$ curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer <JWT>"
  -d '{"title": "hoge"}' http://localhost:3000/api/tasks

{"id":7,"user_id":2,"title":"hoge","done":false,"created_at":"2020-06-28T23:06:47.857Z",
"updated_at":"2020-06-28T23:06:47.857Z"}
```

### JWTでタスク一覧を取得する

```
$ curl -H "Authorization: Bearer <JWT>" http://localhost:3000/api/tasks

[
  {"id":1,"user_id":2,"title":"Task0","done":true,"created_at":"2020-06-28T21:43:46.360Z","updated_at":"2020-06-28T21:43:46.360Z"},
  {"id":2,"user_id":2,"title":"Task1","done":false,"created_at":"2020-06-28T21:43:46.365Z","updated_at":"2020-06-28T21:43:46.365Z"},
  {"id":3,"user_id":2,"title":"Task2","done":true,"created_at":"2020-06-28T21:43:46.370Z","updated_at":"2020-06-28T21:43:46.370Z"},
  {"id":4,"user_id":2,"title":"Task3","done":false,"created_at":"2020-06-28T21:43:46.375Z","updated_at":"2020-06-28T21:43:46.375Z"},
  {"id":5,"user_id":2,"title":"Task4","done":true,"created_at":"2020-06-28T21:43:46.381Z","updated_at":"2020-06-28T21:43:46.381Z"},
  {"id":7,"user_id":2,"title":"hoge","done":false,"created_at":"2020-06-28T23:06:47.857Z","updated_at":"2020-06-28T23:06:47.857Z"}
]
```
