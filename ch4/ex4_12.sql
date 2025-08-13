select model, count(seat_no)
from aircrafts
  inner join seats using(aircraft_code)
group by model;
