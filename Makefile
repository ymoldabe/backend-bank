# Запустить контейнер PostgreSQL
postgres:
	docker run --name postgres16 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -p 5432:5432 -d postgres:16.0-alpine3.18

# Создать базу данных
createdb:
	docker exec -it postgres16 createdb --username=root --owner=root bank

# Удалить базу данных
dropdb:
	docker exec -it postgres16 dropdb bank

# Генерировать код SQLC
sqlc:
	sqlc generate --no-remote

# Запустить приложение
run:
	go run ./cmd/
#Запустить приложение
test:
	go test -v -cover ./...

# Выполнить миграции вверх
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/bank?sslmode=disable" -verbose up

# Выполнить миграции вниз
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/bank?sslmode=disable" -verbose down

# Цели, которые не представляют файлы
.PHONY: postgres createdb dropdb sqlc run migrateup migratedown
