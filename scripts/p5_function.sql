-- Завдання 5. Власна функція
-- Створюємо функцію years_since, яка приймає значення року та повертає різницю
-- в роках між поточною датою та датою 'рік-01-01'.

USE pandemic;

DROP FUNCTION IF EXISTS years_since;

DELIMITER //

CREATE FUNCTION years_since(input_year YEAR)
RETURNS INT
DETERMINISTIC
NO SQL
BEGIN
    -- Будуємо дату першого січня переданого року та рахуємо різницю з поточною датою
    RETURN TIMESTAMPDIFF(YEAR, MAKEDATE(input_year, 1), CURDATE());
END //

DELIMITER ;

-- Використовуємо функцію на даних нормалізованої таблиці
SELECT
    `year`,
    MAKEDATE(`year`, 1) AS `year_start`,
    CURDATE() AS `current_date`,
    years_since(`year`) AS `years_diff`
FROM infectious_cases_normalized;
