select passenger_name, flight_no
from tickets
inner join ticket_flights using(ticket_no)
inner join flights using(flight_id)
left outer join boarding_passes using(ticket_no, flight_id)
where boarding_passes.ticket_no is null;
