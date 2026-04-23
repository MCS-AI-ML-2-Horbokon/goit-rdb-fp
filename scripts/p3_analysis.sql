-- Завдання 3. Аналіз даних
-- Для кожної унікальної комбінації Entity та Code рахуємо середнє, мінімальне,
-- максимальне значення та суму для атрибута Number_rabies.
-- Порожні значення (NULL) агрегатні функції ігнорують автоматично.
-- Результат відсортовано за середнім значенням у порядку спадання; виводимо 10 рядків.

USE pandemic;

SELECT
    e.entity,
    e.code,
    AVG(n.number_rabies) AS avg_rabies,
    MIN(n.number_rabies) AS min_rabies,
    MAX(n.number_rabies) AS max_rabies,
    SUM(n.number_rabies) AS sum_rabies
FROM infectious_cases_normalized n
JOIN entities e ON e.id = n.entity_id
WHERE n.number_rabies IS NOT NULL
GROUP BY e.entity, e.code
ORDER BY avg_rabies DESC
LIMIT 10;
