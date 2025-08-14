select passenger_name
from tickets
  inner join ticket_flights using(ticket_no)
where fare_conditions = 'Economy' and amount > 70000;
