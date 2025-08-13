select avg(amount)
from ticket_flights
  inner join flights using (flight_id)
where departure_airport = 'VOZ' and arrival_airport = 'LED';
