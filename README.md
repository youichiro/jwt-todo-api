# jwt-todo-api

JSON Web Token(JWT)でユーザ承認するテスト用APIです

## versions
ruby: 2.6.5
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
JWTトークンの発行
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
