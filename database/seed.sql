-- SkillHub sample data (PostgreSQL / Neon)
-- Run AFTER skillhub.sql. Safe to re-run: clears all data first.
--
-- Test logins:
--   admin@skillhub.com  / Admin123!   (admin)
--   dana@example.com    / User123!    (user)
--   yossi@example.com   / User123!    (user)
--   noa@example.com     / User123!    (user)
--   avi@example.com     / User123!    (user)
--   maya@example.com    / User123!    (user)

TRUNCATE registrations, workshops, categories, users RESTART IDENTITY CASCADE;

-- Categories (6)
INSERT INTO categories (category_name) VALUES
('Cooking'),          -- 1
('Photography'),      -- 2
('Ceramics'),         -- 3
('Programming'),      -- 4
('Yoga & Wellness'),  -- 5
('Music');            -- 6

-- Users: 1 admin + 5 regular (passwords are bcrypt hashes)
INSERT INTO users (first_name, last_name, email, password, role) VALUES
('Admin', 'SkillHub', 'admin@skillhub.com', '$2b$10$4bTzm3BbvnA9ResuIHv0w.qQuOqJosNrKZXsL3FiAa6Q.h7Vbv/Ze', 'admin'), -- 1
('Dana',  'Cohen',    'dana@example.com',   '$2b$10$jcjP0tKnrOhM8R16TbiS4.JcQpuSV6lSUD9OTXi38U8sUqUbdrK1u', 'user'),  -- 2
('Yossi', 'Levi',     'yossi@example.com',  '$2b$10$CmWQxJzpsfrgxvkuSkpJbelPE5U8/8WdkSitu7ohWI7fBypdzk7Hu', 'user'),  -- 3
('Noa',   'Mizrahi',  'noa@example.com',    '$2b$10$30VAKpeAl/4xFcayDDMoO.KuJk9Yz0yCpG6twLCoKBkro.zjlGlKa', 'user'),  -- 4
('Avi',   'Peretz',   'avi@example.com',    '$2b$10$xKJvq4eyG7GDhgNaHkJi5urwrkdty148XNdhmMVCywDr7p8VEaVCa', 'user'),  -- 5
('Maya',  'Friedman', 'maya@example.com',   '$2b$10$lgo2YXn6MSuddZmJ8BnPqumwrhEVs7YrM5nAYJ6bh2.LdDA2/gPGC', 'user');  -- 6

-- Workshops (12): past, active now and future, relative to Nov 2026
INSERT INTO workshops (category_id, title, description, city, start_date, end_date, price, capacity, image_name) VALUES
(1, 'Italian Pasta from Scratch', 'Learn to make fresh pasta dough and three classic Italian sauces.', 'Tel Aviv', '2026-12-03', '2026-12-03', 280, 12, 'italian-pasta.jpg'),            -- 1  future
(2, 'Street Photography Walk', 'A guided walk through the Old City capturing candid street moments.', 'Jerusalem', '2026-11-20', '2026-11-22', 450, 15, 'street-photography.jpg'),  -- 2  future
(3, 'Pottery Wheel Basics', 'A month-long course on centering, throwing and trimming on the wheel.', 'Haifa', '2026-11-01', '2026-11-29', 900, 8, 'pottery-wheel.jpg'),           -- 3  active
(4, 'React in One Weekend', 'Build and deploy a complete React app in two intensive days.', 'Tel Aviv', '2027-01-08', '2027-01-09', 650, 30, 'react-weekend.jpg'),                 -- 4  future
(5, 'Sunrise Yoga on the Beach', 'Five mornings of sunrise yoga and breathing practice by the sea.', 'Eilat', '2026-10-05', '2026-10-09', 520, 20, 'sunrise-yoga.jpg'),           -- 5  past
(6, 'Intro to Djembe Drums', 'Rhythm basics and group drumming on traditional djembe drums.', 'Beer Sheva', '2027-02-14', '2027-02-14', 150, 25, 'djembe-drums.jpg'),             -- 6  future
(1, 'Sourdough Bread Workshop', 'From starter to crusty loaf: everything about sourdough baking.', 'Haifa', '2026-09-14', '2026-09-14', 220, 10, 'sourdough.jpg'),                 -- 7  past
(2, 'Night Sky Photography', 'Shoot the Milky Way and star trails in the Ramon Crater.', 'Mitzpe Ramon', '2026-12-18', '2026-12-19', 700, 5, 'night-sky.jpg'),                    -- 8  future, FULL
(3, 'Hand-Built Ceramics', 'Pinch, coil and slab techniques for handmade bowls and vases.', 'Jerusalem', '2026-08-03', '2026-08-07', 750, 10, 'hand-built-ceramics.jpg'),         -- 9  past
(4, 'TypeScript for Beginners', 'A free hands-on intro to TypeScript types, interfaces and generics.', 'Haifa', '2026-11-09', '2026-11-13', 0, 40, 'typescript-beginners.jpg'), -- 10 active
(5, 'Mindful Pilates', 'A relaxing Pilates session focused on posture and core strength.', 'Netanya', '2026-12-28', '2026-12-28', 120, 15, 'mindful-pilates.jpg'),                -- 11 future
(6, 'Guitar Basics', 'First chords, strumming patterns and your first full song.', 'Jerusalem', '2026-10-20', '2026-10-21', 350, 12, 'guitar-basics.jpg');                       -- 12 past

-- Registrations (registered_at is always before the workshop start)
INSERT INTO registrations (user_id, workshop_id, registered_at) VALUES
-- Workshop 8 is FULL: 5 registrations = capacity 5
(2, 8, '2026-11-01 10:00'), (3, 8, '2026-11-02 12:30'), (4, 8, '2026-11-03 09:15'),
(5, 8, '2026-11-04 18:40'), (6, 8, '2026-11-05 20:05'),
-- Past workshops
(2, 5, '2026-09-20 08:00'), (3, 5, '2026-09-22 14:00'),
(4, 7, '2026-09-01 11:00'),
(5, 9, '2026-07-15 16:30'),
(2, 12, '2026-10-01 19:00'), (6, 12, '2026-10-05 10:45'),
-- Active now
(3, 3, '2026-10-20 13:00'), (4, 3, '2026-10-25 17:20'),
(2, 10, '2026-11-02 09:00'), (5, 10, '2026-11-06 21:10'),
-- Future
(2, 1, '2026-11-08 12:00'), (3, 1, '2026-11-10 15:30'),
(4, 2, '2026-11-09 10:10'),
(3, 4, '2026-11-07 08:45'), (5, 4, '2026-11-10 22:00'), (6, 4, '2026-11-11 07:30'),
(6, 6, '2026-11-11 19:00');
