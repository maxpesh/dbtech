select flight_no, actual_departure
from flights
where actual_departure != scheduled_departure;
