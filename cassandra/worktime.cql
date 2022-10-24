CREATE KEYSPACE IF NOT EXISTS worktime WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};

CREATE TABLE IF NOT EXISTS worktime.employee(number text PRIMARY KEY, sure_name text, first_name text, weekly_hours decimal);
CREATE TABLE IF NOT EXISTS worktime.worktime(id text PRIMARY KEY, number text, date date);
