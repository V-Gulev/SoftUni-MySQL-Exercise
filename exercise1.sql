SELECT *
FROM books;

SELECT SUBSTRING(title, author_id, 30)
FROM books;

SELECT title
FROM books
WHERE SUBSTRING(title, 1, 3) = 'The'
ORDER BY id ASC;

SELECT REPLACE(title, 'The', '***')
FROM books
WHERE 'The' = SUBSTRING(title, 1, 3)
ORDER  BY id ASC;

SELECT
    CONCAT(first_name, ' ', last_name) AS 'Full Name',
    TIMESTAMPDIFF(DAY, born, died) AS 'Days Lived'
FROM authors;

SELECT title
FROM books
WHERE title LIKE 'Harry Potter%'
ORDER  BY id ASC;

