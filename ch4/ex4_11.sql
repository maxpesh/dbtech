select fare_conditions, avg(amount)
from ticket_flights
group by fare_conditions;
