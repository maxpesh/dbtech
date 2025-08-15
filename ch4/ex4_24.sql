create view departed_flights_per_day as
  select departure_airport, extract(doy from actual_departure) as day, count(1) as departed_flights
  from flights
  group by departure_airport, extract(doy from actual_departure)
  order by departure_airport, extract(doy from actual_departure);

select * from departed_flights_per_day
where departure_airport = 'BAX';
