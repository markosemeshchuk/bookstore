# Приклади запитів — книгарня (самостійні 1.1 і 1.2)

Бек має бути запущений: `./mvnw spring-boot:run` (порт 8080).

У PowerShell використовуйте `curl.exe`, а не `curl` (це псевдонім іншої команди).

---

## 1. Перелік книг (картки)

```bash
curl.exe http://localhost:8080/api/books
```

## 2. Фільтр за жанром

```bash
curl.exe "http://localhost:8080/api/books?genre=Поезія"
```

Очікувано: лише книги жанру «Поезія» (Кобзар). Без параметра `genre` повертаються всі книги.

## 3. Одна книга з деталями

```bash
curl.exe http://localhost:8080/api/books/1
```

Очікувана відповідь:
```json
{
  "id": 1,
  "title": "Кобзар",
  "author": "Тарас Шевченко",
  "price": 250.00,
  "year": 1840,
  "coverUrl": "/covers/kobzar.svg",
  "description": "Збірка поетичних творів.",
  "genre": "Поезія"
}
```

## 4. Створити книгу → 201

```bash
curl.exe -i -X POST http://localhost:8080/api/books -H "Content-Type: application/json" -d "{\"title\":\"Нова книга\",\"author\":\"Автор\",\"price\":199.00,\"year\":2024,\"genre\":\"Проза\",\"coverUrl\":\"/covers/x.jpg\",\"description\":\"Опис\"}"
```

Очікувано: `HTTP/1.1 201`, у тілі — створена книга з новим `id` (наприклад, 6).

## 5. Оновити книгу → 200 / 404

```bash
curl.exe -i -X PUT http://localhost:8080/api/books/1 -H "Content-Type: application/json" -d "{\"title\":\"Оновлена\",\"author\":\"Автор\",\"price\":250.00,\"year\":2024,\"genre\":\"Проза\",\"coverUrl\":\"/covers/x.jpg\",\"description\":\"Опис\"}"
```

Очікувано: `HTTP/1.1 200`. Для неіснуючого id (наприклад, 999) — `HTTP/1.1 404`.

## 6. Видалити книгу → 204 / 404

```bash
curl.exe -i -X DELETE http://localhost:8080/api/books/2
```

Очікувано: `HTTP/1.1 204` без тіла. Повторний запит на той самий id дає `HTTP/1.1 404`.

---

## Перевірка 404 для неіснуючого id

```bash
curl.exe -i http://localhost:8080/api/books/999
curl.exe -i -X DELETE http://localhost:8080/api/books/999
```

Обидва запити мають повернути `HTTP/1.1 404`.
