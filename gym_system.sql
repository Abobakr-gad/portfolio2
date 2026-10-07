CREATE DATABASE if not exists gym_system;

USE gym_system;

CREATE TABLE if NOT EXISTS membership_plans (
	id INT AUTO_INCREMENT PRIMARY KEY,
	plan_name VARCHAR(255) NOT NULL,
	plan_price DECIMAL(10, 2) DEFAULT 0.0
);

CREATE TABLE if NOT EXISTS members(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	start_date DATE NOT NULL,
	plan_id INT NOT NULL,
	FOREIGN KEY (plan_id) REFERENCES membership_plans(id) ON DELETE RESTRICT
);

CREATE TABLE if NOT EXISTS lockers(
	id INT AUTO_INCREMENT PRIMARY KEY,
	locker_number INT NOT NULL,
	member_id INT NOT NULL UNIQUE,
	FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
);

CREATE TABLE if NOT EXISTS trainers (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	speciality ENUM('cardio', 'pilates', 'yoga', 'MMA') NOT NULL
);

CREATE TABLE if NOT EXISTS sessions (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	duration_minutes INT NOT NULL,
	start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	trainer_id INT,
	FOREIGN KEY (trainer_id) REFERENCES trainers(id) ON DELETE SET NULL
);

CREATE INDEX idx_duration_minutes ON sessions(duration_minutes);gym_systemlockers

-- B+ tree

CREATE TABLE if NOT EXISTS session_members (
	session_id INT NOT NULL,
	member_id INT NOT NULL,
	PRIMARY KEY (session_id, member_id),
	FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE CASCADE,
	FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE session_members;
TRUNCATE TABLE lockers;
TRUNCATE TABLE sessions;
TRUNCATE TABLE trainers;
TRUNCATE TABLE members;
TRUNCATE TABLE membership_plans;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO membership_plans (plan_name, plan_price) VALUES
('Basic', 29.99),
('Premium', 59.99),
('VIP', 99.99),
('Student', 19.99),
('Family', 79.99);

INSERT INTO trainers (name, speciality) VALUES
('Diego Torres', 'yoga'),
('Abobakr', 'cardio'),
('Mohamed', 'pilates'),
('Ali', 'MMA'),
('Diego Torres', 'yoga'), 
('Asmaa', 'cardio'),
('Aml', 'pilates'),
('Samir', 'MMA');

INSERT INTO members (name, email, start_date, plan_id) VALUES
('Ahmed','ahmed@mail.com','2024-9-15',1),
('mahmoud','mahmoud@mail.com','2024-8-01',2),
('Eyad','eyad@mail.com','2024-7-10',3),
('Ismail','ava.thompson@mail.com','2024-02-20',1),
('Mostafa','mostafa@mail.com','2024-03-01',4),
('sayed','sayed@mail.com','2024-03-05',2),
('Gamal','gamal@mail.com','2024-03-12',3),
('Omar','omar@mail.com','2024-03-18',5),
('youssef','youssef@mail.com','2024-03-25',1),
('Hamada','hamada@mail.com','2024-04-01',2),
('Mousa ','mousa@mail.com','2024-04-08',3),
('Abdo','abdo@mail.com','2024-04-14',1),
('karim','karim@mail.com','2024-04-20',4),
('Taha','taha@mail.com','2024-04-27',2),
('Henry Dubois','henry.dubois@mail.com','2024-05-02',3),
('Grace Whitfield','grace.whitfield@mail.com','2024-05-09',1),
('Daniel Osei','daniel.osei@mail.com','2024-05-15',5),
('Zoe Andersen','zoe.andersen@mail.com','2024-05-22',2),
('Owen Castillo','owen.castillo@mail.com','2024-06-01',3),
('Lily Chen','lily.chen@mail.com','2024-06-08',1),
('Jack Morrison','jack.morrison@mail.com','2024-06-15',4),
('Ella Kowalski','ella.kowalski@mail.com','2024-06-22',2),
('Leo Martinez','leo.martinez@mail.com','2024-07-01',3),
('Hannah Schmidt','hannah.schmidt@mail.com','2024-07-09',1),
('Wyatt Johansson','wyatt.johansson@mail.com','2024-07-16',5),
('Aria Delgado','aria.delgado@mail.com','2024-07-23',2),
('Caleb Foster','caleb.foster@mail.com','2024-08-01',3),
('Layla Hassan','layla.hassan@mail.com','2024-08-08',1),
('David Park','david.park@mail.com','2024-08-15',4),
('Nora Lindgren','nora.lindgren@mail.com','2024-08-22',3);

INSERT INTO sessions (name, duration_minutes, start_time, trainer_id) VALUES
('Morning Yoga',60,'2024-09-01 07:00:00',1),
('Sunrise Cardio Blast',45,'2024-09-01 06:30:00',2),
('Pilates Core',50,'2024-09-01 09:00:00',NULL),
('MMA Fundamentals',60,'2024-09-01 18:00:00',4),
('Evening Yoga Flow',60,'2024-09-01 19:00:00',5),
('HIIT Bootcamp',45,'2024-09-02 06:00:00',2),
('Pilates Stretch',40,'2024-09-02 10:00:00',Null),
('MMA Sparring',75,'2024-09-02 19:00:00',4),
('Power Yoga',60,'2024-09-03 07:00:00',NULL),
('Cardio Circuit',50,'2024-09-03 17:30:00',6),
('Pilates Advanced',55,'2024-09-03 11:00:00',7),
('Restorative Yoga',45,'2024-09-04 20:00:00',5),
('Kickboxing Basics',50,'2024-09-04 18:30:00',NULL),
('Cardio Dance Party',45,'2024-09-05 07:30:00',6),
('Beginner Pilates',40,'2024-09-05 09:30:00',7);

INSERT INTO session_members (session_id, member_id) VALUES
(1,1),(1,4),(1,9),(1,12),(1,16),(1,20),(1,24),(1,28),
(2,2),(2,6),(2,10),(2,14),(2,18),
(3,3),(3,7),(3,11),(3,15),(3,19),(3,23),
(4,6),(4,13),(4,21),(4,27),
(5,1),(5,8),(5,17),(5,25),
(6,2),(6,6),(6,10),(6,14),(6,18),(6,22),(6,26),(6,30),
(7,3),(7,7),(7,11),
(8,6),(8,13),(8,21),
(9,1),(9,4),(9,9),(9,16),(9,20),(9,24),
(10,2),(10,6),(10,10),
(11,15),(11,19),(11,23),
(12,8),(12,17),(12,25),(12,29),
(13,7),(13,27),
(14,14),(14,18),(14,22),(14,26),(14,30),
(15,3),(15,7),(15,11),(15,19);

INSERT INTO lockers (locker_number, member_id)
SELECT 100 + id, id FROM members;


SELECT name 
FROM trainers 
WHERE speciality = 'cardio';

SELECT name, start_date 
FROM members 
WHERE start_date BETWEEN '2026-07-01' AND '2026-07-31';

SELECT plan_name, plan_price 
FROM membership_plans 
ORDER BY plan_price DESC 
LIMIT 1;

SELECT COUNT(*) AS total_without_speciality 
FROM trainers 
WHERE speciality IS NULL;

SELECT s.name AS session_name, t.name AS trainer_name 
FROM sessions s
JOIN trainers t ON s.trainer_id = t.id
WHERE t.name = 'Diego Torres';

SELECT p.plan_name, COUNT(m.id) AS member_count
FROM membership_plans p
 JOIN members m ON p.id = m.plan_id
GROUP BY p.id, p.plan_name
ORDER BY member_count DESC;

SELECT s.name AS session_name, COUNT(sm.member_id) AS total_bookings
FROM sessions s
JOIN session_members sm ON s.id = sm.session_id
GROUP BY s.id, s.name
ORDER BY total_bookings DESC;

SELECT m.name AS member_name, l.locker_number
FROM members m
JOIN lockers l ON m.id = l.member_id
JOIN membership_plans p ON m.plan_id = p.id
WHERE p.plan_name = 'Premium';

SELECT NAME  
FROM trainers 
WHERE id = (
    SELECT trainer_id 
    FROM sessions 
    WHERE name = 'HIIT Bootcamp');
    
    SELECT s.name AS session_name, COUNT(sm.member_id) AS total_bookings
FROM sessions s
JOIN session_members sm ON s.id = sm.session_id
GROUP BY s.id, s.name
HAVING COUNT(sm.member_id) > 4
ORDER BY total_bookings DESC;

SELECT t.name AS trainer_name, COUNT(sm.member_id) AS total_bookings
FROM trainers t
JOIN sessions s ON t.id = s.trainer_id
JOIN session_members sm ON s.id = sm.session_id
GROUP BY t.id, t.name
HAVING COUNT(DISTINCT s.id) > 1 AND COUNT(sm.member_id) > 10;

SELECT s.name AS session_name
FROM sessions s
JOIN session_members sm ON s.id = sm.session_id
GROUP BY s.id, s.name
HAVING COUNT(sm.member_id) = (
    SELECT COUNT(member_id) 
    FROM session_members 
    GROUP BY session_id 
    ORDER BY COUNT(member_id) DESC 
    LIMIT 1
);

SELECT name 
FROM trainers 
WHERE id IN (
    SELECT trainer_id 
    FROM sessions 
    WHERE trainer_id IS NOT NULL
    GROUP BY trainer_id
    HAVING COUNT(id) = (
        SELECT COUNT(id) 
        FROM sessions 
        WHERE trainer_id IS NOT NULL
        GROUP BY trainer_id 
        ORDER BY COUNT(id) DESC 
        LIMIT 1
    )
);

SELECT name 
FROM sessions 
WHERE id NOT IN (
    SELECT DISTINCT session_id 
    FROM session_members 
    WHERE member_id IN (
        SELECT m.id 
        FROM members m
        JOIN membership_plans p ON m.plan_id = p.id
        WHERE p.plan_name = 'VIP'
    )
);

// I used some AI questions

