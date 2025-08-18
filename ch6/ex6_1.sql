begin;
insert into bookings(book_ref, book_date, total_amount) values('_1A73C', now(), 41000) returning *;
insert into tickets(ticket_no, book_ref, passenger_id, passenger_name, contact_data)
  values('0005435999874', '_1A73C', '0005435670663', 'VICTOR VASILIEV', '{"phone" : "+70013181914"}') returning *;
insert into tickets(ticket_no, book_ref, passenger_id, passenger_name, contact_data)
  values('0005435999875', '_1A73C', '0005435670664', 'MIKHAEL GROMOV', '{"phone" : "+704023013213"}') returning *;
rollback;
select * from bookings where book_ref = '_1A73C';
select * from tickets where ticket_no = '0005435999874' or ticket_no = '0005435999875';
