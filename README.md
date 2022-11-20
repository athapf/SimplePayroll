
# Beispiel

``` bash
  curl --header "Content-Type: application/json" --request PUT --data '{"number":5421,"hour":4.3,"date":"2022-05-16"}' http://localhost:8082/worktime
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
