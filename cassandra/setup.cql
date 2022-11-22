
CREATE TABLE IF NOT EXISTS
careamount.careamount(
    number text PRIMARY KEY, 
    month int, 
    year int, 
    total decimal, 
    careamount decimal, 
    difference decimal);

CREATE TABLE IF NOT EXISTS
caredata.employee(
    number text PRIMARY KEY, 
    name text);
CREATE TABLE IF NOT EXISTS
caredata.payroll(
    number text PRIMARY KEY, 
    name text, 
    month int, 
    year int, 
    transferamount decimal, 
    monthelementlist text);
CREATE TABLE IF NOT EXISTS
caredata.caredata(
    number text PRIMARY KEY, 
    name text, 
    month int, 
    year int, 
    careamount decimal, 
    difference decimal);

CREATE TABLE IF NOT EXISTS
carereport.caredata(
    number text PRIMARY KEY, 
    name text, 
    month int, 
    year int, 
    careamount decimal, 
    difference decimal);

CREATE TABLE IF NOT EXISTS
employee.employee(
    number text PRIMARY KEY, 
    name text, 
    iban text, 
    weeklyhours decimal, 
    wagerate decimal);

CREATE TABLE IF NOT EXISTS
maintenance.maintenance(
    id text PRIMARY KEY, 
    month int, 
    year int, 
    createdon text);

CREATE TABLE IF NOT EXISTS
monthvalue.worktime(
    id text PRIMARY KEY, 
    number text, 
    date text, 
    month int, 
    year int, 
    hour decimal, 
    difference decimal, 
    createdon text);
CREATE TABLE IF NOT EXISTS
monthvalue.monthvalue(
    id text PRIMARY KEY, 
    number text, 
    month int, 
    year int, 
    hour decimal, 
    difference decimal, 
    grosssalery decimal, 
    createdon text);
CREATE TABLE IF NOT EXISTS
monthvalue.employee(
    number text PRIMARY KEY, 
    weeklyhours decimal, 
    wagerate decimal);

CREATE TABLE IF NOT EXISTS
payroll.payroll(
    number text PRIMARY KEY, 
    name text, 
    month int, 
    year int, 
    transferamount decimal, 
    monthelementlist text);
CREATE TABLE IF NOT EXISTS
payroll.employee(
    number text PRIMARY KEY, 
    name text, 
    iban text);

CREATE TABLE IF NOT EXISTS
transferdata.employee(
    number text PRIMARY KEY, 
    name text, 
    iban text);
CREATE TABLE IF NOT EXISTS
transferdata.payroll(
    number text PRIMARY KEY, 
    name text, 
    month int, 
    year int, 
    transferamount decimal, 
    monthelementlist text);
CREATE TABLE IF NOT EXISTS
transferdata.transferdata(
    number text PRIMARY KEY, 
    name text, 
    month int, 
    year int, 
    amount decimal, 
    iban text);

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
