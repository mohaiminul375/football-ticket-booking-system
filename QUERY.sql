-- 1. CREATE USERS TABLE
CREATE TABLE Users (
    user_id serial primary key,
    full_name varchar(255) not null,
    email varchar(255) unique not null,
    role varchar(20) check (role in ('Ticket Manager', 'Football Fan')),
    phone_number varchar(14)
    -- Write your constraint to make 'user_id' the Primary Key
    -- Write your constraint to ensure 'email' values are never duplicated
    -- Write your check constraint to restrict 'role' to specific allowed strings

);
