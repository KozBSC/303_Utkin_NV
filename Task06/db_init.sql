DROP TABLE IF EXISTS dentists;
DROP TABLE IF EXISTS employee_statuses;
DROP TABLE IF EXISTS specilizations;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS appointment_statuses;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS dentists_statistics;
DROP TABLE IF EXISTS salaries;

CREATE TABLE employee_statuses(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    status TEXT NOT NULL
);


CREATE TABLE specilizations(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    specilization TEXT NOT NULL
);

CREATE TABLE dentists(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    birthday TEXT NOT NULL,
    specialization_id INTEGER NOT NULL,
    employee_status_id INTEGER NOT NULL,
    earning_in_percent REAL NOT NULL,
    CHECK(earning_in_percent >= 0)
    FOREIGN KEY(specialization_id)
            REFERENCES specilizations(id) ON DELETE RESTRICT ON UPDATE CASCADE
    FOREIGN KEY(employee_status_id)
            REFERENCES employee_statuses(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE categories(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    category TEXT NOT NULL
);

CREATE TABLE services(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT NOT NULL,
    cathegory_id INTEGER NOT NULL,
    duration_in_minutes REAL NOT NULL,
    price REAL NOT NULL,
    CHECK(duration_in_minutes > 0 and price >= 0),
    FOREIGN KEY(cathegory_id)
            REFERENCES categories(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE appointment_statuses(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    status TEXT NOT NULL
);

CREATE TABLE clients(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    birthday TEXT NOT NULL,
    phone_number TEXT CHECK(phone_number LIKE "+%"),
    passport TEXT
);

CREATE TABLE appointments(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    client_id INTEGER NOT NULL,
    dentist_id INTEGER NOT NULL,
    appointment_time TEXT NOT NULL,
    start_time TEXT,
    end_time TEXT,
    appointment_status_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    FOREIGN KEY(client_id)
            REFERENCES clients(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY(dentist_id)
            REFERENCES dentists(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY(service_id)
            REFERENCES services(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY(appointment_status_id)
            REFERENCES appointment_statuses(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE dentists_statistics(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    dentist_id INTEGER NOT NULL,
    count_appointments INTEGER NOT NULL,
    first_work_day TEXT,
    CHECK(count_appointments >= 0),
    FOREIGN KEY(dentist_id)
            REFERENCES dentists(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE salaries(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    dentist_id INTEGER NOT NULL,
    pay_day TEXT NOT NULL,
    origin_salary REAL NOT NULL,
    salary_with_percent REAL NOT NULL,
    CHECK(origin_salary > 0 and salary_with_percent >= 0),
    FOREIGN KEY(dentist_id)
            REFERENCES dentists(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO employee_statuses (status)
VALUES
('работает'),
('уволен'),
('в отпуске');

INSERT INTO specilizations (specilization)
VALUES
('терапевт'),
('хирург'),
('ортодонт');

INSERT INTO dentists (last_name, first_name, middle_name, birthday, specialization_id, employee_status_id, earning_in_percent)
VALUES 
('Владимир', 'Дубинский', 'Александрович', '05.12.1988', 1, 1, 95),
('Иван', 'Космина', 'Владимирович', '29.06.1998', 2, 1, 90),
('Данилов', 'Тимур', 'Станиславович', '29.12.1995', 2, 1, 80),
('Зеленина', 'Мария', 'Андреевна', '16.06.1991', 2, 3, 70),
('Болдырева', 'Ева', 'Станиславовна', '17.03.1989', 1, 1, 85);

INSERT INTO categories (category)
VALUES
('имплантация'),
('терапевтическая стоматология'),
('хирургическая стоматология');

INSERT INTO clients (last_name, first_name, middle_name, birthday, phone_number, passport)
VALUES 
('Уткин', 'Александр', null, '29.12.2000', '+79871209056', '0000000000'),
('Шубина', 'Кристина', null, '31.12.2000', '+79871212056', '1234567891'),
('Сахаров', 'Артём', null, '29.12.1990', '+79251209156', '4521567891'),
('Крылова ', 'Кристина', null, '15.01.2000', '+79871229357', '5348913651'),
('Соколов', 'Никита', 'Григорьевич', '06.05.1970', '+79571219253', '0000000001');

INSERT INTO services (title, cathegory_id, duration_in_minutes, price)
VALUES
('Лечение периодонтита', 2, 160, 10800),
('Зубосохраняющие операция', 3, 180, 12400),
('Имплантация одного зуба', 1, 60, 16500),
('Лечение пульпита', 2, 40, 9000);

INSERT INTO appointment_statuses (status)
VALUES
('завершена'),
('актуальна'),
('отменена');

INSERT INTO appointments (client_id, dentist_id, appointment_time, start_time, end_time, appointment_status_id, service_id)
VALUES
(1, 3, '2018-03-24 10:00:00', '2018-03-24 10:01:00', '2018-03-24 13:00:00', 1, 2),
(4, 4, '2021-06-27 12:00:00', null, null, 2, 4),
(2, 1, '2021-12-27 13:00:00', null, null, 2, 1),
(3, 2, '2021-12-12 14:00:00', null, null, 2, 4),
(5, 5, '2021-12-13 16:00:00', null, null, 2, 3);

INSERT INTO dentists_statistics (dentist_id, count_appointments, first_work_day)
VALUES 
(1, 1,'2021-11-15'),
(2, 22, '2021-02-15'),
(3, 90, '2017-11-20'),
(4, 0, '2021-11-20'),
(5, 1, '2021-11-17');

INSERT INTO salaries (dentist_id, pay_day, origin_salary, salary_with_percent)
VALUES 
(1, date('now'), 10000, 9500),
(2, date('now'), 30000, 27000),
(3, date('now'), 40000, 32000),
(5, date('now'), 7000, 5950);
