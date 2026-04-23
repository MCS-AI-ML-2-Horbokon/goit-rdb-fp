-- Завдання 1. Завантаження даних
-- Створюємо схему pandemic та імпортуємо дані з CSV-файлу

DROP SCHEMA IF EXISTS pandemic;

-- Створюємо схему pandemic
CREATE SCHEMA pandemic
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

-- Обираємо схему pandemic як схему за замовчуванням
USE pandemic;

-- Створюємо таблицю infectious_cases для зберігання даних
CREATE TABLE infectious_cases (
    id INT NOT NULL AUTO_INCREMENT,
    entity VARCHAR(255) NOT NULL,
    code VARCHAR(20),
    year YEAR NOT NULL,
    number_yaws DOUBLE,
    polio_cases DOUBLE,
    cases_guinea_worm DOUBLE,
    number_rabies DOUBLE,
    number_malaria DOUBLE,
    number_hiv DOUBLE,
    number_tuberculosis DOUBLE,
    number_smallpox DOUBLE,
    number_cholera DOUBLE,
    PRIMARY KEY (id)
);

SET foreign_key_checks = 0;

-- Імпортуємо дані з CSV-файлу; порожні рядки замінюємо на NULL
LOAD DATA LOCAL INFILE '/Homework/goit-rdb-fp/infectious_cases.csv'
INTO TABLE infectious_cases
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(entity, code, year, @v1, @v2, @v3, @v4, @v5, @v6, @v7, @v8, @v9)
SET
    number_yaws         = NULLIF(@v1, ''),
    polio_cases         = NULLIF(@v2, ''),
    cases_guinea_worm   = NULLIF(@v3, ''),
    number_rabies       = NULLIF(@v4, ''),
    number_malaria      = NULLIF(@v5, ''),
    number_hiv          = NULLIF(@v6, ''),
    number_tuberculosis = NULLIF(@v7, ''),
    number_smallpox     = NULLIF(@v8, ''),
    number_cholera      = NULLIF(@v9, '');

SET foreign_key_checks = 1;

-- Перевіряємо кількість завантажених записів
SELECT COUNT(*) AS row_count FROM infectious_cases;
