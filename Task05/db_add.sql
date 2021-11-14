INSERT INTO users(first_name, last_name, email, gender, register_date, occupation_id)
VALUES
('Nikita', 'Utkin', 'nikita_utkin@mrsu.ru', 'male', date('now'), (SELECT id FROM occupations o WHERE o.occupation == 'student')),
('Alexandr', 'Taynov', 'alexandr_taynov@mrsu.ru', 'male', date('now'), (SELECT id FROM occupations o WHERE o.occupation == 'student')),
('Danila', 'Svetilnikov', 'danila_svetilnikov@mrsu.ru', 'male', date('now'), (SELECT id FROM occupations o WHERE o.occupation == 'student')),
('Alexandra', 'Chernova', 'alexandra_chernova@mrsu.ru', 'female', date('now'), (SELECT id FROM occupations o WHERE o.occupation == 'student')),
('Danila', 'Shabanov', 'danila_shabanov@mrsu.ru', 'male', date('now'), (SELECT id FROM occupations o WHERE o.occupation == 'student'));

INSERT INTO movies(title, year) 
VALUES
('The Lord of the Rings: The Fellowship of the Ring', 2001),
('The Lord of the Rings: The Two Towers', 2002),
('Lord of the Rings: The Return of the King', 2003);

INSERT INTO ratings(user_id, movie_id, rating, timestamp)
VALUES
((SELECT id FROM users WHERE users.email = 'nikita_utkin@mrsu.ru'), (SELECT id FROM movies WHERE movies.title = 'The Lord of the Rings: The Fellowship of the Ring' and movies.year = 2001), 4.8, strftime('%s','now')),
((SELECT id FROM users WHERE users.email = 'nikita_utkin@mrsu.ru'), (SELECT id FROM movies WHERE movies.title = 'The Lord of the Rings: The Two Towers' and movies.year = 2002), 4.9, strftime('%s','now')),
((SELECT id FROM users WHERE users.email = 'nikita_utkin@mrsu.ru'), (SELECT id FROM movies WHERE movies.title = 'Lord of the Rings: The Return of the King' and movies.year = 2003), 5.0, strftime('%s','now'));