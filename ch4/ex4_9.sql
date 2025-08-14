select seats.seat_no, flight_no, scheduled_departure
from flights
  inner join aircrafts using(aircraft_code)
  inner join seats using(aircraft_code)
  inner join ticket_flights using(flight_id)
  left join boarding_passes using(ticket_no, flight_id)    
where departure_airport = 'AAQ' and arrival_airport = 'SVO'
  and boarding_passes.seat_no is null;
