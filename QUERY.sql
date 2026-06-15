-- 1. CREATE USERS TABLE
CREATE TABLE
    Users (
        user_id serial primary key,
        full_name varchar(255) not null,
        email varchar(255) unique not null,
        role varchar(20) check (role in ('Ticket Manager', 'Football Fan')) not null,
        phone_number varchar(14)
    );

-- 2. CREATE MATCHES TABLE
CREATE TABLE
    Matches (
        match_id serial primary key,
        fixture varchar(255) not null,
        tournament_category varchar(255) not null,
        base_ticket_price int check (base_ticket_price >= 0) not null,
        match_status varchar(20) check (
            match_status in (
                'Available',
                'Selling Fast',
                'Sold Out',
                'Postponed'
            )
        ) not null
    );

-- 3. CREATE BOOKINGS TABLE
CREATE TABLE
    Bookings (
        booking_id serial primary key,
        user_id smallint references users (user_id) not null,
        match_id smallint references matches (match_id) not null,
        seat_number varchar(10),
        payment_status varchar(10) check (
            payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
        ),
        total_cost int check (total_cost >= 0) not null
    );

----Queries
--query 1
select
    match_id,
    fixture,
    base_ticket_price
from
    matches
where
    tournament_category = 'Champions League'
    and match_status = 'Available';

--query 2
select
    user_id,
    full_name,
    email
from
    users
where
    full_name ilike 'Tanvir%'
    or full_name ilike '%Haque%';

--query 3
select
    booking_id,
    user_id,
    match_id,
    coalesce(payment_status, 'Action Required') as systematic_status
from
    Bookings
where
    payment_status isnull;

--query 4
select
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
from
    bookings b
    inner join users u on b.user_id = u.user_id
    inner join matches m on b.match_id = m.match_id
    --query 5
select
    u.user_id,
    u.full_name,
    b.booking_id
from
    users u
    left join bookings b on u.user_id = b.user_id;

---query 6
select
    booking_id,
    match_id,
    total_cost
from
    Bookings
where
    total_cost > (
        select
            avg(total_cost)
        from
            Bookings
    );

--query 7
select
    *
from
    Matches
order by
    base_ticket_price desc
offset
    1
limit
    2;