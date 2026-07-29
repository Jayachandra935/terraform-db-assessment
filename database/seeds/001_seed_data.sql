INSERT INTO hotel_bookings
(
    booking_reference,
    org_id,
    hotel_id,
    guest_name,
    guest_email,
    hotel_name,
    city,
    room_type,
    booking_status,
    amount,
    check_in,
    check_out
)
SELECT
    'BOOK' || LPAD(gs::text,5,'0'),

    CASE
        WHEN gs % 5 = 0 THEN '11111111-1111-1111-1111-111111111111'::uuid
        WHEN gs % 5 = 1 THEN '22222222-2222-2222-2222-222222222222'::uuid
        WHEN gs % 5 = 2 THEN '33333333-3333-3333-3333-333333333333'::uuid
        WHEN gs % 5 = 3 THEN '44444444-4444-4444-4444-444444444444'::uuid
        ELSE '55555555-5555-5555-5555-555555555555'::uuid
    END,

    CASE
        WHEN gs % 5 = 0 THEN 'HOTEL001'
        WHEN gs % 5 = 1 THEN 'HOTEL002'
        WHEN gs % 5 = 2 THEN 'HOTEL003'
        WHEN gs % 5 = 3 THEN 'HOTEL004'
        ELSE 'HOTEL005'
    END,

    'Guest ' || gs,

    'guest' || gs || '@gmail.com',

    CASE
        WHEN gs % 5 = 0 THEN 'Taj Hotel'
        WHEN gs % 5 = 1 THEN 'Novotel'
        WHEN gs % 5 = 2 THEN 'Marriott'
        WHEN gs % 5 = 3 THEN 'Hyatt'
        ELSE 'Radisson'
    END,

    CASE
        WHEN gs % 5 = 0 THEN 'Hyderabad'
        WHEN gs % 5 = 1 THEN 'Bangalore'
        WHEN gs % 5 = 2 THEN 'Chennai'
        WHEN gs % 5 = 3 THEN 'Mumbai'
        ELSE 'Delhi'
    END,

    CASE
        WHEN gs % 3 = 0 THEN 'Suite'
        WHEN gs % 3 = 1 THEN 'Deluxe'
        ELSE 'Standard'
    END,

    CASE
        WHEN gs % 4 = 0 THEN 'CONFIRMED'
        WHEN gs % 4 = 1 THEN 'COMPLETED'
        WHEN gs % 4 = 2 THEN 'CANCELLED'
        ELSE 'PENDING'
    END,

    ROUND((1000 + random()*9000)::numeric,2),

    CURRENT_DATE + (gs % 30),

    CURRENT_DATE + (gs % 30) + 2

FROM generate_series(1,100) gs;

INSERT INTO booking_events
(
    booking_id,
    event_type,
    remarks
)
SELECT
    booking_id,
    'BOOKING_CREATED',
    'Booking created successfully'
FROM hotel_bookings;

UPDATE booking_events
SET payload =
jsonb_build_object(
    'status','created',
    'source','api',
    'version','1.0'
);