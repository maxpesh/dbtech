select count(*)
from flights
where departure_airport = 'LED' and status = 'Cancelled'
  and extract(dow from scheduled_departure) = 4 -- thursday
  and extract(dow from scheduled_arrival) = 4; -- thursday
