
CREATE TABLE IF NOT EXISTS
employee.employee(
    number text PRIMARY KEY, 
    name text, 
    iban text, 
    weeklyhours decimal, 
    wagerate decimal);

CREATE TABLE IF NOT EXISTS
worktime.employee(
    number text PRIMARY KEY, 
    name text, 
    weeklyhours decimal, 
    wagerate decimal);
CREATE TABLE IF NOT EXISTS
worktime.worktime(
    id text PRIMARY KEY, 
    number text, 
    date text, 
    hour decimal, 
    difference decimal, 
    createdon text);
