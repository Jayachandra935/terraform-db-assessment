CREATE TABLE hotel_bookings (

    booking_id SERIAL PRIMARY KEY,

    booking_reference VARCHAR(30) UNIQUE NOT NULL,

    org_id UUID NOT NULL,
    
    hotel_id VARCHAR(100) NOT NULL,

    guest_name VARCHAR(100) NOT NULL,

    guest_email VARCHAR(150),

    hotel_name VARCHAR(100) NOT NULL,

    city VARCHAR(100) NOT NULL,

    room_type VARCHAR(50),

    booking_status VARCHAR(30) NOT NULL,

    amount DECIMAL(10,2) NOT NULL,

    check_in DATE NOT NULL,

    check_out DATE NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

CREATE TABLE booking_events (

    event_id SERIAL PRIMARY KEY,

    booking_id INTEGER NOT NULL,

    event_type VARCHAR(50) NOT NULL,
    
    payload JSONB,

    event_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    remarks TEXT,

    CONSTRAINT fk_booking
        FOREIGN KEY (booking_id)
        REFERENCES hotel_bookings(booking_id)
        ON DELETE CASCADE


);