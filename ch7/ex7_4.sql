begin;

select flight_id
from flights
where scheduled_departure = :scheduled_departure
  and departure_airport = :departure_airport;

insert into bookings(book_ref, book_date, amount) values(:book_ref, now(), 0);
-- for all passengers
insert into tickets(ticket_no, book_ref, passenger_id, passenger_name, contact_data) values(:ticket_no, :book_ref, :passenger_id, :passenger_name, :contact_data);
insert into ticket_flights(ticket_no, flight_id, fare_conditions, amount) values(:ticket_no, flight_id, :fare_conditions, amount);
update bookings set total_amount = (
  select sum(amount)
  from bookings b
  inner join tickets t on t.book_ref = b.book_ref
  inner join ticket_flights tf on tf.ticket_no = t.ticket_no
);

commit;
