create temp table users(id bigserial, group_id bigint);
insert into users(group_id) values (1),(1),(1),(2),(1),(3);

select array_agg(id) as user_ids, COUNT(id) as count_of_ids, MIN(id) as min_in_group
from (
  select * ,
  lead(group_id) over (ORDER BY id ASC) as lead_group_id,
  lag(group_id) over (ORDER BY id ASC) as lag_group_id,
  lead(id) over (ORDER BY id ASC) as lead_id,
  lag(id) over (ORDER BY id ASC) as lag_id
  from users u1
) as t
group by (t.group_id = t.lead_group_id and (t.lead_id - t.id) = 1) OR
         (t.group_id = t.lag_group_id and (t.id - t.lag_id) = 1);


-- QUERY RESULTS:

-- user_ids | count_of_ids | min_in_group
-- ----------+--------------+--------------
-- {6}      |            1 |            6
-- {4,5}    |            2 |            4
-- {1,2,3}  |            3 |            1
