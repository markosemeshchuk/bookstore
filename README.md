# Книгарня — Spring Boot (backend)

Самостійна робота до заняття 1.1. Стек: Spring Boot 3.4.x, Java 21, Maven.

## Запуск

```bash
./mvnw spring-boot:run
```

Ендпоінти та приклади `curl` — у файлі [requests.md](requests.md).

## Структура

- `domain` — доменна модель `Book`
- `repository` — інтерфейс `BookRepository` і реалізація в пам'яті
- `config` — `BookSeeder` з початковими книгами
- `service` — `BookService` + `BookServiceImpl`, маппер у `service/mapper`
- `web` — `BookController` і DTO (`BookCardDto`, `BookDetailDto`)
- `exception` — `BookNotFoundException` (404)
