-- 1. CREATE USERS TABLE
CREATE TABLE Users (
    user_id serial primary key,
    full_name varchar(255) not null,
    email varchar(255) unique not null,
    role varchar(20) check (role in ('Ticket Manager', 'Football Fan')),
    phone_number varchar(14)
);

-- 2. CREATE MATCHES TABLE
CREATE TABLE Matches (
    match_id serial primary key,
    fixture varchar(255) not null,
    tournament_category varchar(255) not null,
    base_ticket_price int check(base_ticket_price >= 0) not null,
    match_status varchar(20) check ( match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed')) not null
);

-- 3. CREATE BOOKINGS TABLE
CREATE TABLE Bookings (
    booking_id serial primary key,
    user_id smallint references users(user_id) not null,
    match_id smallint references matches(match_id) not null,
    seat_number varchar(10),
    payment_status varchar(10) check(payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost int check(total_cost >= 0) not null
);

