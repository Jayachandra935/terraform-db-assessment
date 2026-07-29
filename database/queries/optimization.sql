CREATE INDEX idx_hotel_bookings_city
ON hotel_bookings(city);

CREATE INDEX idx_hotel_bookings_status
ON hotel_bookings(booking_status);

CREATE INDEX idx_hotel_bookings_checkin
ON hotel_bookings(check_in);

CREATE INDEX idx_booking_events_booking_id
ON booking_events(booking_id);

CREATE INDEX idx_hotel_bookings_city_status
ON hotel_bookings(city, booking_status);

CREATE INDEX idx_hotel_bookings_city_created_org_status
ON hotel_bookings
(
    city,
    created_at,
    org_id,
    booking_status
);