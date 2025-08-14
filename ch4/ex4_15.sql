update seats set fare_conditions = 'Business'
where aircraft_code = '319' and left(seat_no, 1) in ('6', '7', '8')
returning *;
