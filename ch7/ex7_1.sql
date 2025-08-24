create type supported_langs as enum('ru', 'en');

DROP VIEW IF EXISTS bookings.flights_v;
DROP VIEW IF EXISTS bookings.routes;
DROP VIEW IF EXISTS bookings.airports;

alter table airports_data drop column city;
alter table airports_data add column city_transl_id int generated always as identity unique not null;

create table translations (
  transl_id int not null,
  translation text not null,
  language supported_langs not null,
  constraint translations_transl_id_fkey foreign key(transl_id)
    references airports_data(city_transl_id)
);

CREATE VIEW bookings.airports AS
 SELECT airport_code,
    (airport_name ->> bookings.lang()) AS airport_name,
    t.translation AS city,
    coordinates,
    timezone
   FROM bookings.airports_data ml
   INNER JOIN translations t on t.transl_id = ml.city_transl_id
   WHERE t.language::text = bookings.lang();

CREATE VIEW bookings.flights_v AS
 SELECT f.flight_id,
    f.flight_no,
    f.scheduled_departure,
    timezone(dep.timezone, f.scheduled_departure) AS scheduled_departure_local,
    f.scheduled_arrival,
    timezone(arr.timezone, f.scheduled_arrival) AS scheduled_arrival_local,
    (f.scheduled_arrival - f.scheduled_departure) AS scheduled_duration,
    f.departure_airport,
    dep.airport_name AS departure_airport_name,
    dep.city AS departure_city,
    f.arrival_airport,
    arr.airport_name AS arrival_airport_name,
    arr.city AS arrival_city,
    f.status,
    f.aircraft_code,
    f.actual_departure,
    timezone(dep.timezone, f.actual_departure) AS actual_departure_local,
    f.actual_arrival,
    timezone(arr.timezone, f.actual_arrival) AS actual_arrival_local,
    (f.actual_arrival - f.actual_departure) AS actual_duration
   FROM bookings.flights f,
    bookings.airports dep,
    bookings.airports arr
  WHERE ((f.departure_airport = dep.airport_code) AND (f.arrival_airport = arr.airport_code));

CREATE VIEW bookings.routes AS
 WITH f3 AS (
         SELECT f2.flight_no,
            f2.departure_airport,
            f2.arrival_airport,
            f2.aircraft_code,
            f2.duration,
            array_agg(f2.days_of_week) AS days_of_week
           FROM ( SELECT f1.flight_no,
                    f1.departure_airport,
                    f1.arrival_airport,
                    f1.aircraft_code,
                    f1.duration,
                    f1.days_of_week
                   FROM ( SELECT flights.flight_no,
                            flights.departure_airport,
                            flights.arrival_airport,
                            flights.aircraft_code,
                            (flights.scheduled_arrival - flights.scheduled_departure) AS duration,
                            (to_char(flights.scheduled_departure, 'ID'::text))::integer AS days_of_week
                           FROM bookings.flights) f1
                  GROUP BY f1.flight_no, f1.departure_airport, f1.arrival_airport, f1.aircraft_code, f1.duration, f1.days_of_week
                  ORDER BY f1.flight_no, f1.departure_airport, f1.arrival_airport, f1.aircraft_code, f1.duration, f1.days_of_week) f2
          GROUP BY f2.flight_no, f2.departure_airport, f2.arrival_airport, f2.aircraft_code, f2.duration
        )
 SELECT f3.flight_no,
    f3.departure_airport,
    dep.airport_name AS departure_airport_name,
    dep.city AS departure_city,
    f3.arrival_airport,
    arr.airport_name AS arrival_airport_name,
    arr.city AS arrival_city,
    f3.aircraft_code,
    f3.duration,
    f3.days_of_week
   FROM f3,
    bookings.airports dep,
    bookings.airports arr
  WHERE ((f3.departure_airport = dep.airport_code) AND (f3.arrival_airport = arr.airport_code));
