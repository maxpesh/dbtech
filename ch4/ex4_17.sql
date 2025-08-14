create table ticket_flights_history(
  ticket_no char(13),
  flight_id int not null,
  fare_conditions varchar(10) not null,
  amount numeric(10,2) not null,
  change_date timestamp not null,
  constraint ticket_flights_history_pkey primary key(ticket_no, flight_id),
  constraint ticket_flights_history_fkey foreign key(ticket_no, flight_id)
    references ticket_flights(ticket_no, flight_id)
);
