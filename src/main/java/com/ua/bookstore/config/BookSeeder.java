package com.ua.bookstore.config;

import com.ua.bookstore.domain.Book;
import com.ua.bookstore.repository.BookRepository;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

/**
 * Наповнює сховище початковими книгами під час запуску.
 * Окремо від репозиторію (SRP): репозиторій зберігає, сидер наповнює.
 */
@Component
public class BookSeeder implements ApplicationRunner {

    private final BookRepository repository;

    public BookSeeder(BookRepository repository) {
        this.repository = repository;
    }

    @Override
    public void run(ApplicationArguments args) {
        repository.save(new Book(null, "Кобзар", "Тарас Шевченко",
                new BigDecimal("250.00"), 1840, "/covers/kobzar.svg",
                "Збірка поетичних творів.", "Поезія"));

        repository.save(new Book(null, "Тіні забутих предків", "Михайло Коцюбинський",
                new BigDecimal("310.50"), 1911, "/covers/tini.svg",
                "Повість про кохання, традиції та гуцульське життя.", "Проза"));

        repository.save(new Book(null, "Захар Беркут", "Іван Франко",
                new BigDecimal("280.00"), 1883, "/covers/zakhar.svg",
                "Історичне оповідання про боротьбу карпатських гуцулів із монголо-татарами.", "Історичний роман"));

        repository.save(new Book(null, "Лісова пісня", "Леся Українка",
                new BigDecimal("199.90"), 1911, "/covers/lisova.svg",
                "Драма-феєрія про Мавку, Лукаша та світ лісу.", "Драма"));

        repository.save(new Book(null, "Місто", "Валер'ян Підмогильний",
                new BigDecimal("399.00"), 1928, "/covers/misto.svg",
                "Роман про молодого лікаря та життя Києва 1920-х років.", "Роман"));
    }
}
