-- 1.
select model, range
from aircrafts
where range > 10000 or range < 4000;

-- 2.
select model, range
from aircrafts
where range > 6000 and model not like '%100';
