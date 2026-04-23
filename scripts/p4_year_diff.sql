-- Завдання 4. Колонка різниці в роках
-- Для колонки Year будуємо три нові атрибути:
-- year_start — дата першого січня відповідного року (наприклад, '1996-01-01')
-- current_date — поточна дата
-- years_diff — різниця в роках між поточною датою та датою початку року

USE pandemic;

SELECT
    `year`,
    MAKEDATE(`year`, 1) AS `year_start`,
    CURDATE() AS `current_date`,
    TIMESTAMPDIFF(YEAR, MAKEDATE(`year`, 1), CURDATE()) AS `years_diff`
FROM infectious_cases_normalized;
