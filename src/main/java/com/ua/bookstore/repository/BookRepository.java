package com.ua.bookstore.repository;

import com.ua.bookstore.domain.Book;

import java.util.List;
import java.util.Optional;

/**
 * Контракт сховища книг (ПОРТ). Сервіс залежить від нього, а не від реалізації — DIP.
 */
public interface BookRepository {

    List<Book> findAll();

    Optional<Book> findById(Long id);

    Book save(Book book);
}
