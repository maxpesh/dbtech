select count(1)
from (
  select flight_no, actual_departure
  from flights
  where departure_airport = 'SVO'
  order by actual_departure
) as prev
inner join (
  select flight_no, actual_departure
  from flights
  where departure_airport = 'SVO'
  order by actual_departure
) as next on next.actual_departure > prev.actual_departure
  and next.actual_departure - prev.actual_departure < '5 minutes';
