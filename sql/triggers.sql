-- T1: Prevent overlapping bookings for the same room
CREATE OR REPLACE FUNCTION check_booking_overlap()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM booking
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

-- T2: When a renting is created from a booking, automatically set booking status to 'rented'
CREATE OR REPLACE FUNCTION on_renting_from_booking()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.booking_id IS NOT NULL THEN
        UPDATE booking SET status = 'rented'
        WHERE booking_id = NEW.booking_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_booking_to_renting
AFTER INSERT ON renting
FOR EACH ROW EXECUTE FUNCTION on_renting_from_booking();

-- T3: Ensure hotel manager is an employee of that hotel
CREATE OR REPLACE FUNCTION check_manager_works_at_hotel()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.manager_employee_id IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1 FROM employee
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

-- T4: Prevent overlapping rentings for the same room
CREATE OR REPLACE FUNCTION check_renting_overlap()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM renting
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

-- T5: Ensure booking end_date is after start_date
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

-- T6: Ensure renting end_date is after start_date
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
