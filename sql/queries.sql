-- Q1: Number of hotels per area, showing only areas with more than 2 hotels
SELECT area, COUNT(*) AS hotel_count
FROM hotel
GROUP BY area
HAVING COUNT(*) > 2;

-- Q2: Rooms priced above their chain's average room price
SELECT r.room_number, r.price, h.name AS hotel_name
FROM room r
JOIN hotel h ON r.hotel_id = h.hotel_id
WHERE r.price > (
    SELECT AVG(r2.price)
    FROM room r2
    JOIN hotel h2 ON r2.hotel_id = h2.hotel_id
    WHERE h2.chain_id = h.chain_id
);

-- Q3: Available rooms in Ottawa from 2026-07-01 to 2026-07-10
SELECT r.room_id, r.room_number, r.price, r.capacity, r.view_type
FROM room r
JOIN hotel h ON r.hotel_id = h.hotel_id
WHERE h.area = 'Ottawa'
AND NOT EXISTS (
    SELECT 1 FROM booking b
    WHERE b.room_id = r.room_id
    AND b.status = 'active'
    AND b.start_date < '2026-07-10'
    AND b.end_date > '2026-07-01'
);

-- Q4: Total revenue per hotel, sorted by revenue descending
SELECT h.name AS hotel_name, SUM(p.amount) AS total_revenue
FROM hotel h
JOIN room r ON h.hotel_id = r.hotel_id
JOIN renting rt ON r.room_id = rt.room_id
JOIN payment p ON rt.renting_id = p.renting_id
GROUP BY h.hotel_id, h.name
ORDER BY total_revenue DESC;

-- Q5: All customers and their number of bookings (including customers with 0 bookings)
SELECT c.customer_id, c.full_name, COUNT(b.booking_id) AS booking_count
FROM customer c
LEFT JOIN booking b ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY booking_count DESC;

-- Q6: Contact info from all hotel chains and hotels combined
SELECT name, contact_email, contact_phone, 'chain' AS type
FROM hotel_chain
UNION
SELECT name, contact_email, contact_phone, 'hotel' AS type
FROM hotel;

-- Q7: Hotels that have at least one room with problems
SELECT DISTINCT h.name AS hotel_name, h.area, h.category
FROM hotel h
JOIN room r ON h.hotel_id = r.hotel_id
WHERE r.problems IS NOT NULL;

-- Q8: Average room price per star category, and the number of rooms in each category
SELECT h.category, COUNT(r.room_id) AS total_rooms, ROUND(AVG(r.price), 2) AS avg_price
FROM hotel h
JOIN room r ON h.hotel_id = r.hotel_id
GROUP BY h.category
ORDER BY h.category;
