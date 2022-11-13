package de.thaso.demo.examples.simplepayroll.employee.service;

import java.math.BigDecimal;

public class Employee {
    private String number;
    private String name;
    private String iban;
    private BigDecimal weeklyhours;
    private BigDecimal wagerate;

    public Employee() {}

    public Employee(
            final String number,
            final String name,
            final String iban,
            final BigDecimal weeklyhours,
            final BigDecimal wagerate) {
        this.number = number;
        this.name = name;
        this.iban = iban;
        this.weeklyhours = weeklyhours;
        this.wagerate = wagerate;
    }

    @Override
    public String toString() {
        return "Employee{" +
            "number='" + number + '\'' +
            ", name='" + name + '\'' +
            ", iban='" + iban + '\'' +
            ", weeklyhours='" + weeklyhours + '\'' +
            ", wagerate='" + wagerate + '\'' +
            '}';
    }

    public String getNumber() {
        return number;
    }
    public void setNumber(final String value) {
        this.number = value;
    }

    public String getName() {
        return name;
    }
    public void setName(final String value) {
        this.name = value;
    }

    public String getIban() {
        return iban;
    }
    public void setIban(final String value) {
        this.iban = value;
    }

    public BigDecimal getWeeklyhours() {
        return weeklyhours;
    }
    public void setWeeklyhours(final BigDecimal value) {
        this.weeklyhours = value;
    }

    public BigDecimal getWagerate() {
        return wagerate;
    }
    public void setWagerate(final BigDecimal value) {
        this.wagerate = value;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private Builder() {}

        private String number;
        private String name;
        private String iban;
        private BigDecimal weeklyhours;
        private BigDecimal wagerate;

        public Builder withNumber(final String value) {
            this.number = value;
            return this;
        }

        public Builder withName(final String value) {
            this.name = value;
            return this;
        }

        public Builder withIban(final String value) {
            this.iban = value;
            return this;
        }

        public Builder withWeeklyhours(final BigDecimal value) {
            this.weeklyhours = value;
            return this;
        }

        public Builder withWagerate(final BigDecimal value) {
            this.wagerate = value;
            return this;
        }

        public Employee build() {
            final Employee result = new Employee();
            result.number = number;
            result.name = name;
            result.iban = iban;
            result.weeklyhours = weeklyhours;
            result.wagerate = wagerate;
            return result;
        }
    }
}
