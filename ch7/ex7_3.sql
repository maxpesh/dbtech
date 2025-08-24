select arr.city, count(1)
from flights f
inner join airports dep on dep.airport_code = f.departure_airport
inner join airports arr on arr.airport_code = f.arrival_airport
inner join ticket_flights tf on tf.flight_id = f.flight_id
where dep.city in ('Moscow', 'Москва') and extract(dow from scheduled_arrival) = 4
group by arr.city;
