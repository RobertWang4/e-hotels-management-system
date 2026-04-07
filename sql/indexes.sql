-- I1: Users frequently search rooms by area
CREATE INDEX idx_hotel_area ON hotel(area);

-- I2: Checking room availability requires looking up bookings by room and date range
CREATE INDEX idx_booking_room_dates ON booking(room_id, start_date, end_date);

-- I3: Users filter rooms by price range
CREATE INDEX idx_room_price ON room(price);

-- I4: Queries frequently filter bookings by status (active, cancelled, rented)
CREATE INDEX idx_booking_status ON booking(status);

-- I5: Renting lookups by room_id for availability checks and revenue calculations
CREATE INDEX idx_renting_room ON renting(room_id);

-- I6: Payment lookups by renting_id for revenue aggregation queries
CREATE INDEX idx_payment_renting ON payment(renting_id);

-- I7: Customer lookup by registration date for reporting
CREATE INDEX idx_customer_reg_date ON customer(registration_date);

-- I8: Hotel lookup by chain_id and category for filtered searches
CREATE INDEX idx_hotel_chain_category ON hotel(chain_id, category);
