package com.ua.bookstore.web.dto;

import java.math.BigDecimal;

/**
 * Вхідний DTO для створення та оновлення книги.
 * Без id: його призначає сервер (на створенні) або бере з URL (на оновленні).
 */
public record BookRequest(
        String title,
        String author,
        BigDecimal price,
        Integer year,
        String genre,
        String coverUrl,
        String description
) {
}
