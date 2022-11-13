-- liquibase formatted sql

-- changeset liquibase:1
CREATE KEYSPACE IF NOT EXISTS payroll WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};
