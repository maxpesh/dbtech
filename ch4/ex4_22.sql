select dep.airport, sum(avg_day_dep_passengers + avg_day_arr_passengers) as avg_day_passengers
from (
  select airport, sum(dep_passengers) / count(1) as avg_day_dep_passengers
  from (
    select departure_airport airport, extract(doy from scheduled_departure) as day, count(1) as dep_passengers
    from flights
    inner join ticket_flights on flights.flight_id = ticket_flights.flight_id
    inner join tickets on ticket_flights.ticket_no = tickets.ticket_no
    group by departure_airport, extract(doy from scheduled_departure)
  )
  group by airport
) as dep
inner join
(
  select airport, sum(arr_passengers) / count(1) as avg_day_arr_passengers
  from (
    select arrival_airport airport, count(1) as arr_passengers
    from flights
    inner join ticket_flights on flights.flight_id = ticket_flights.flight_id
    inner join tickets on ticket_flights.ticket_no = tickets.ticket_no
    group by arrival_airport, extract(doy from scheduled_arrival)
  )
  group by airport
) as arr on dep.airport = arr.airport
group by dep.airport
order by avg_day_passengers desc
limit 10;
