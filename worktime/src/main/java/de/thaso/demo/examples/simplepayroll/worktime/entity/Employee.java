package de.thaso.demo.examples.simplepayroll.worktime.entity;

import java.math.BigDecimal;

public class Employee {

    private String number;
    private String surename;
    private String firstname;
    private String street;
    private String plz;
    private String city;
    private String iban;
    private BigDecimal weeklyhours;
    private BigDecimal wagerate;

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getSurename() {
        return surename;
    }

    public void setSurename(String surename) {
        this.surename = surename;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getPlz() {
        return plz;
    }

    public void setPlz(String plz) {
        this.plz = plz;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getIban() {
        return iban;
    }

    public void setIban(String iban) {
        this.iban = iban;
    }

    public BigDecimal getWeeklyhours() {
        return weeklyhours;
    }

    public void setWeeklyhours(BigDecimal weeklyhours) {
        this.weeklyhours = weeklyhours;
    }

    public BigDecimal getWagerate() {
        return wagerate;
    }

    public void setWagerate(BigDecimal wagerate) {
        this.wagerate = wagerate;
    }


    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private Builder() {}

        private String number;
        private String surename;
        private String firstname;
        private String street;
        private String plz;
        private String city;
        private String iban;
        private BigDecimal weeklyhours;
        private BigDecimal wagerate;

        public Builder withNumber(final String number) {
            this.number = number;
            return this;
        }

        public Builder withSureName(final String surename) {
            this.surename = surename;
            return this;
        }

        public Builder withFirstName(final String firstName) {
            this.firstname = firstName;
            return this;
        }

        public Builder withStreet(final String street) {
            this.street = street;
            return this;
        }

        public Builder withPLZ(final String plz) {
            this.plz = plz;
            return this;
        }

        public Builder withCity(final String city) {
            this.city = city;
            return this;
        }

        public Builder withIBAN(final String iban) {
            this.iban = iban;
            return this;
        }

        public Builder withWeeklyHours(final BigDecimal weeklyhours) {
            this.weeklyhours = weeklyhours;
            return this;
        }

        public Builder withWageRate(final BigDecimal wagerate) {
            this.wagerate = wagerate;
            return this;
        }

        public Employee build() {
            final Employee employee = new Employee();
            employee.number = number;
            employee.surename = surename;
            employee.firstname = firstname;
            employee.street = street;
            employee.plz = plz;
            employee.city = city;
            employee.number = iban;
            employee.weeklyhours = weeklyhours;
            employee.wagerate = wagerate;
            return employee;
        }
    }
}
