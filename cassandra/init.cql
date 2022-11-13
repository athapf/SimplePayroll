
CREATE KEYSPACE IF NOT EXISTS employee WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};
CREATE KEYSPACE IF NOT EXISTS worktime WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};
CREATE KEYSPACE IF NOT EXISTS monthvalue WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};
CREATE KEYSPACE IF NOT EXISTS payroll WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};
