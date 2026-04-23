-- Завдання 2. Нормалізація таблиці infectious_cases до 3НФ
-- Атрибути Entity та Code повторюються у кожному рядку — виносимо їх в окрему таблицю

USE pandemic;

DROP TABLE IF EXISTS infectious_cases_normalized;
DROP TABLE IF EXISTS entities;

-- Перевіряємо кількість записів перед нормалізацією
SELECT COUNT(*) FROM infectious_cases;

-- Таблиця-довідник сутностей (entity + code)
CREATE TABLE entities (
    id INT NOT NULL AUTO_INCREMENT,
    entity VARCHAR(255) NOT NULL,
    code VARCHAR(20),
    PRIMARY KEY (id),
    UNIQUE KEY uq_entity_code (entity, code)
);

-- Заповнюємо довідник унікальними комбінаціями entity та code
INSERT INTO entities (entity, code)
SELECT DISTINCT entity, code
FROM infectious_cases;

-- Перевіряємо кількість записів у довіднику
SELECT COUNT(*) FROM entities;

-- Нормалізована таблиця фактів; посилається на entities через entity_id
CREATE TABLE IF NOT EXISTS infectious_cases_normalized (
    id INT NOT NULL AUTO_INCREMENT,
    entity_id INT NOT NULL,
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
    PRIMARY KEY (id),
    FOREIGN KEY (entity_id) REFERENCES entities(id)
);

-- Переносимо дані з оригінальної таблиці до нормалізованої
INSERT INTO infectious_cases_normalized
(
    entity_id,
    year,
    number_yaws,
    polio_cases,
    cases_guinea_worm,
    number_rabies,
    number_malaria,
    number_hiv,
    number_tuberculosis,
    number_smallpox,
    number_cholera
)
SELECT
    e.id,
    ic.year,
    ic.number_yaws,
    ic.polio_cases,
    ic.cases_guinea_worm,
    ic.number_rabies,
    ic.number_malaria,
    ic.number_hiv,
    ic.number_tuberculosis,
    ic.number_smallpox,
    ic.number_cholera
FROM infectious_cases ic
JOIN entities e ON e.entity = ic.entity AND (e.code <=> ic.code);

-- Перевіряємо кількість записів після нормалізації
SELECT COUNT(*) FROM infectious_cases_normalized;
