package com.ehotels.config;

import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;

@Configuration
public class DatabaseObjectsInitializer {

    @Bean
    public ApplicationRunner databaseObjectsRunner(JdbcTemplate jdbcTemplate) {
        return args -> {
            jdbcTemplate.execute("""
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
                $$ LANGUAGE plpgsql
                """);

            jdbcTemplate.execute("DROP TRIGGER IF EXISTS trg_no_overlap_booking ON booking");
            jdbcTemplate.execute("""
                CREATE TRIGGER trg_no_overlap_booking
                BEFORE INSERT OR UPDATE ON booking
                FOR EACH ROW EXECUTE FUNCTION check_booking_overlap()
                """);

            jdbcTemplate.execute("""
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
                $$ LANGUAGE plpgsql
                """);

            jdbcTemplate.execute("DROP TRIGGER IF EXISTS trg_booking_to_renting ON renting");
            jdbcTemplate.execute("""
                CREATE TRIGGER trg_booking_to_renting
                AFTER INSERT ON renting
                FOR EACH ROW EXECUTE FUNCTION on_renting_from_booking()
                """);

            jdbcTemplate.execute("""
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
                $$ LANGUAGE plpgsql
                """);

            jdbcTemplate.execute("DROP TRIGGER IF EXISTS trg_manager_same_hotel ON hotel");
            jdbcTemplate.execute("""
                CREATE TRIGGER trg_manager_same_hotel
                BEFORE INSERT OR UPDATE ON hotel
                FOR EACH ROW EXECUTE FUNCTION check_manager_works_at_hotel()
                """);

            jdbcTemplate.execute("""
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
                $$ LANGUAGE plpgsql
                """);

            jdbcTemplate.execute("DROP TRIGGER IF EXISTS trg_no_overlap_renting ON renting");
            jdbcTemplate.execute("""
                CREATE TRIGGER trg_no_overlap_renting
                BEFORE INSERT OR UPDATE ON renting
                FOR EACH ROW EXECUTE FUNCTION check_renting_overlap()
                """);

            jdbcTemplate.execute("""
                CREATE OR REPLACE FUNCTION check_booking_dates()
                RETURNS TRIGGER AS $$
                BEGIN
                    IF NEW.end_date <= NEW.start_date THEN
                        RAISE EXCEPTION 'end_date must be after start_date';
                    END IF;
                    RETURN NEW;
                END;
                $$ LANGUAGE plpgsql
                """);

            jdbcTemplate.execute("DROP TRIGGER IF EXISTS trg_booking_valid_dates ON booking");
            jdbcTemplate.execute("""
                CREATE TRIGGER trg_booking_valid_dates
                BEFORE INSERT OR UPDATE ON booking
                FOR EACH ROW EXECUTE FUNCTION check_booking_dates()
                """);

            jdbcTemplate.execute("""
                CREATE OR REPLACE FUNCTION check_renting_dates()
                RETURNS TRIGGER AS $$
                BEGIN
                    IF NEW.end_date <= NEW.start_date THEN
                        RAISE EXCEPTION 'end_date must be after start_date';
                    END IF;
                    RETURN NEW;
                END;
                $$ LANGUAGE plpgsql
                """);

            jdbcTemplate.execute("DROP TRIGGER IF EXISTS trg_renting_valid_dates ON renting");
            jdbcTemplate.execute("""
                CREATE TRIGGER trg_renting_valid_dates
                BEFORE INSERT OR UPDATE ON renting
                FOR EACH ROW EXECUTE FUNCTION check_renting_dates()
                """);

            jdbcTemplate.execute("""
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
                GROUP BY h.area
                """);

            jdbcTemplate.execute("""
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
                GROUP BY h.hotel_id, h.name
                """);

            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_hotel_area ON hotel(area)");
            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_booking_room_dates ON booking(room_id, start_date, end_date)");
            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_booking_status ON booking(status)");
            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_room_price ON room(price)");
            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_renting_room_dates ON renting(room_id, start_date, end_date)");
            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_renting_status ON renting(status)");
            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_hotel_chain_category ON hotel(chain_id, category)");
            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_renting_room ON renting(room_id)");
            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_payment_renting ON payment(renting_id)");
            jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_customer_reg_date ON customer(registration_date)");
        };
    }
}
