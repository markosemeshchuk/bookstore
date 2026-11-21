package com.ua.bookstore.service;

import com.ua.bookstore.web.dto.BookCardDto;
import com.ua.bookstore.web.dto.BookDetailDto;

import java.util.List;

/**
 * Контракт сервісу книг (бізнес-логіка).
 */
public interface BookService {

    List<BookCardDto> findAll();

    BookDetailDto findById(Long id);
}
