package com.ua.bookstore.web.dto;

import java.math.BigDecimal;

/**
 * DTO для переліку книг: лише поля для однієї картки.
 */
public record BookCardDto(Long id, String title, String author,
                          BigDecimal price, String coverUrl) {
}
