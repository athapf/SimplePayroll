
# Build

```
  mvn clean install
```

## Start and Cleanup Docker

```
docker-compose up --build
```

```
docker-compose stop ; docker-compose rm -f ; docker image prune -f ; docker volume prune -f
```

```
docker-compose -f docker-cassandra.yaml up
```

```
docker-compose -f docker-cassandra.yaml rm -f ; docker volume rm simplepayroll_app_data -f
```

## Init Cassandra

```
grep -h "CREATE KEYSPACE" ./*/target/generated-sources/cassandra/*.cql > cassandra/init.cql
grep -h -v "CREATE KEYSPACE" ./*/target/generated-sources/cassandra/*.cql > cassandra/setup.cql
```

```
docker cp cassandra/init.cql simplepayroll_database_1:/tmp/
sleep 1
docker cp cassandra/setup.cql simplepayroll_database_1:/tmp/
sleep 1
docker exec simplepayroll_database_1 cqlsh -f /tmp/init.cql
sleep 3
docker exec simplepayroll_database_1 cqlsh -f /tmp/setup.cql
```

# Examples

``` bash
  curl --header "Content-Type: application/json" -X PUT --data '{"number":"7412","name":"Horst Buchmann","iban":"DE943865987236","weeklyhours":7.35,"wagerate":27.73}' http://localhost:8081/employee
  
  curl -X GET http://localhost:8081/employee

  curl --header "Content-Type: application/json" -X PUT --data '{"number":7412,"hour":4.3,"date":"2022-05-16"}' http://localhost:8082/worktime
  
  curl -X GET http://localhost:8082/worktime
  
```

# Description

## employee

createEmployee (Rest)

number : text
name : text
iban : text
weeklyhours : decimal
wagerate : decimal

## worktime

employee (Message)
createWorktime (Rest)

number : text
date : date
hour : decimal
difference : decimal

## monthvalue

employee (Message)
worktime (Message)

number : text
month : number
year : number
totalhours : decimal
difference : decimal
grosssalary : decimal

## careamount

monthvalue (Message)

number : text
month : number
year : number
total : decimal
careamount : decimal
difference : decimal

## maintenance

startPayroll (Rest)

month : number
year : number
createdon : date

## payroll

employee (Message)
maintenance (Message)
monthvalue (Message)
careinsuranceamount (Message)

number : text
name : text
billingmonth : number
billingyear : number
  <list>
  month : number
  year : number
  totalhoure : decimal
  difference : decimal
  careamount : decimal
  caredifference : decimal
transferamount : decimal

## caredata

createReport (Rest)
employee (Message)
payroll (Message)

<list>
name : text
amount : decimal
difference : decimal
month : number
year : number

## transferdata

employee (Message)
employee (Message)
createTransfer (Rest)

number : text
name : text
amount : decimal
month : number
year : number

## carereport

careinsurancedata (Message)

name : text
amount : decimal
month : number
year : number
