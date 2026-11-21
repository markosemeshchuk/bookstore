# Книгарня — Spring Boot (backend)

Самостійні роботи 1.1 і 1.2. Стек: Spring Boot 3.4.x, Java 21, Maven.

## Запуск

```bash
./mvnw spring-boot:run
```

Ендпоінти та приклади `curl` — у файлі [requests.md](requests.md).

## Ендпоінти

| Метод  | Шлях                      | Опис                              | Коди          |
|--------|---------------------------|-----------------------------------|---------------|
| GET    | `/api/books?genre=...`    | Список карток, фільтр за жанром   | 200           |
| GET    | `/api/books/{id}`         | Одна книга з деталями             | 200 / 404     |
| POST   | `/api/books`              | Створити книгу                    | 201           |
| PUT    | `/api/books/{id}`         | Оновити книгу                     | 200 / 404     |
| DELETE | `/api/books/{id}`         | Видалити книгу                    | 204 / 404     |

## Структура

- `domain` — доменна модель `Book`
- `repository` — інтерфейс `BookRepository` і реалізація в пам'яті
- `config` — `BookSeeder` з початковими книгами
- `service` — `BookService` + `BookServiceImpl`, маппер у `service/mapper`
- `web` — `BookController` і DTO (`BookCardDto`, `BookDetailDto` для виходу, `BookRequest` для входу)
- `exception` — `BookNotFoundException` (404)
