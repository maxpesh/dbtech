select split_part(passenger_name, ' ', 1) as surname, split_part(passenger_name, ' ', 2) as name,
  departure_airport, arrival_airport, scheduled_departure, scheduled_arrival, seat_no
from tickets
  inner join ticket_flights using(ticket_no)
  inner join boarding_passes using(ticket_no, flight_id)
  inner join flights using(flight_id)
where flights.status = 'Scheduled';
