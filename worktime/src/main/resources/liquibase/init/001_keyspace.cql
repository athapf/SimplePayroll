-- liquibase formatted sql

-- changeset liquibase:1
CREATE KEYSPACE IF NOT EXISTS worktime WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};
