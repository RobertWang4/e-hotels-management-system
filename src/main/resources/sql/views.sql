CREATE OR REPLACE VIEW available_rooms_per_area AS
SELECT h.area, COUNT(r.room_id) AS available_rooms
FROM hotel h
JOIN room r ON h.hotel_id = r.hotel_id
WHERE NOT EXISTS (
    SELECT 1
    FROM booking b
    WHERE b.room_id = r.room_id
      AND b.status = 'active'
)
AND NOT EXISTS (
    SELECT 1
    FROM renting rt
    WHERE rt.room_id = r.room_id
      AND rt.status = 'active'
)
GROUP BY h.area;

CREATE OR REPLACE VIEW hotel_aggregated_capacity AS
SELECT h.hotel_id,
       h.name AS hotel_name,
       COUNT(r.room_id) AS total_rooms,
       SUM(CASE r.capacity
           WHEN 'single' THEN 1
           WHEN 'double' THEN 2
           WHEN 'triple' THEN 3
           WHEN 'quad' THEN 4
           ELSE 1
       END) AS total_capacity
FROM hotel h
JOIN room r ON h.hotel_id = r.hotel_id
GROUP BY h.hotel_id, h.name;
