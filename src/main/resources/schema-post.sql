CREATE OR REPLACE FUNCTION check_booking_overlap()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM booking
        WHERE room_id = NEW.room_id
          AND status = 'active'
          AND booking_id != COALESCE(NEW.booking_id, -1)
          AND start_date < NEW.end_date
          AND end_date > NEW.start_date
    ) THEN
        RAISE EXCEPTION 'Room already booked for this period';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_no_overlap_booking
BEFORE INSERT OR UPDATE ON booking
FOR EACH ROW EXECUTE FUNCTION check_booking_overlap();

CREATE OR REPLACE FUNCTION on_renting_from_booking()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.booking_id IS NOT NULL THEN
        UPDATE booking
        SET status = 'rented'
        WHERE booking_id = NEW.booking_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_booking_to_renting
AFTER INSERT ON renting
FOR EACH ROW EXECUTE FUNCTION on_renting_from_booking();

CREATE OR REPLACE FUNCTION check_manager_works_at_hotel()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.manager_employee_id IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1
            FROM employee
            WHERE employee_id = NEW.manager_employee_id
              AND hotel_id = NEW.hotel_id
        ) THEN
            RAISE EXCEPTION 'Manager must be an employee of this hotel';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_manager_same_hotel
BEFORE INSERT OR UPDATE ON hotel
FOR EACH ROW EXECUTE FUNCTION check_manager_works_at_hotel();

CREATE OR REPLACE FUNCTION check_renting_overlap()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM renting
        WHERE room_id = NEW.room_id
          AND status = 'active'
          AND renting_id != COALESCE(NEW.renting_id, -1)
          AND start_date < NEW.end_date
          AND end_date > NEW.start_date
    ) THEN
        RAISE EXCEPTION 'Room already rented for this period';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_no_overlap_renting
BEFORE INSERT OR UPDATE ON renting
FOR EACH ROW EXECUTE FUNCTION check_renting_overlap();

CREATE OR REPLACE FUNCTION check_booking_dates()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.end_date <= NEW.start_date THEN
        RAISE EXCEPTION 'end_date must be after start_date';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_booking_valid_dates
BEFORE INSERT OR UPDATE ON booking
FOR EACH ROW EXECUTE FUNCTION check_booking_dates();

CREATE OR REPLACE FUNCTION check_renting_dates()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.end_date <= NEW.start_date THEN
        RAISE EXCEPTION 'end_date must be after start_date';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_renting_valid_dates
BEFORE INSERT OR UPDATE ON renting
FOR EACH ROW EXECUTE FUNCTION check_renting_dates();

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

CREATE INDEX idx_hotel_area ON hotel(area);
CREATE INDEX idx_booking_room_dates ON booking(room_id, start_date, end_date);
CREATE INDEX idx_booking_status ON booking(status);
CREATE INDEX idx_room_price ON room(price);
CREATE INDEX idx_renting_room_dates ON renting(room_id, start_date, end_date);
CREATE INDEX idx_renting_status ON renting(status);
CREATE INDEX idx_hotel_chain_category ON hotel(chain_id, category);
