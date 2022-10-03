package de.thaso.demo.examples.simplepayroll.employee.data;

import com.datastax.oss.driver.api.mapper.annotations.Entity;
import com.datastax.oss.driver.api.mapper.annotations.PartitionKey;

import java.math.BigDecimal;

@Entity
public class EmployeeEntity {
    @PartitionKey
    private String number;
    private String surename;
    private String firstname;
    private String street;
    private String plz;
    private String city;
    private String iban;
    private BigDecimal weeklyhours;
    private BigDecimal wagerate;

    public EmployeeEntity() {
    }

    public EmployeeEntity(final String number, final String surename, final String firstname,
                          final String street, final String plz, final String city,
                          final String iban,
                          final BigDecimal weeklyhours, final BigDecimal wagerate) {
        this.number = number;
        this.surename = surename;
        this.firstname = firstname;
        this.street = street;
        this.plz = plz;
        this.city = city;
        this.iban = iban;
        this.weeklyhours = weeklyhours;
        this.wagerate = wagerate;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(final String number) {
        this.number = number;
    }

    public String getSurename() {
        return surename;
    }

    public void setSurename(final String surename) {
        this.surename = surename;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(final String firstname) {
        this.firstname = firstname;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(final String street) {
        this.street = street;
    }

    public String getPlz() {
        return plz;
    }

    public void setPlz(final String plz) {
        this.plz = plz;
    }

    public String getCity() {
        return city;
    }

    public void setCity(final String city) {
        this.city = city;
    }

    public String getIban() {
        return iban;
    }

    public void setIban(final String iban) {
        this.iban = iban;
    }

    public BigDecimal getWeeklyhours() {
        return weeklyhours;
    }

    public void setWeeklyhours(final BigDecimal weeklyhours) {
        this.weeklyhours = weeklyhours;
    }

    public BigDecimal getWagerate() {
        return wagerate;
    }

    public void setWagerate(final BigDecimal wagerate) {
        this.wagerate = wagerate;
    }
}
