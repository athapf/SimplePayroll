CREATE KEYSPACE IF NOT EXISTS employee WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};

CREATE TABLE IF NOT EXISTS employee.employee(
    number text PRIMARY KEY,
     sure_name text,
      first_name text,
       street text,
        p_l_z text,
         city text,
 i_b_a_n text,
  weekly_hours decimal,
   wage_rate decimal);
