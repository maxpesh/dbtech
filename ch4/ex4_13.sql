select airport_name
from airports
  inner join flights on airports.airport_code = flights.arrival_airport
where status = 'Arrived'
group by airport_name
having count(*) > 500;
