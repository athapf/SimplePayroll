package de.thaso.demo.examples.simplepayroll.monthvalue.service;

import java.math.BigDecimal;
import java.util.Date;

public class Monthvalue{
    private String number;
    private BigDecimal hour;
    private Integer month;
    private Integer year;
    private Date createdon;

    public Monthvalue() {}

    public Monthvalue(
            final String number,
            final BigDecimal hour,
            final Integer month,
            final Integer year,
            final Date createdon) {
        this.number = number;
        this.hour = hour;
        this.month = month;
        this.year = year;
        this.createdon = createdon;
    }

    @Override
    public String toString() {
        return "Monthvalue{" +
            "number='" + number + '\'' +
            ", hour='" + hour + '\'' +
            ", month='" + month + '\'' +
            ", year='" + year + '\'' +
            ", createdon='" + createdon + '\'' +
            '}';
    }

    public String getNumber() {
        return number;
    }
    public void setNumber(final String value) {
        this.number = value;
    }

    public BigDecimal getHour() {
        return hour;
    }
    public void setHour(final BigDecimal value) {
        this.hour = value;
    }

    public Integer getMonth() {
        return month;
    }
    public void setMonth(final Integer value) {
        this.month = value;
    }

    public Integer getYear() {
        return year;
    }
    public void setYear(final Integer value) {
        this.year = value;
    }

    public Date getCreatedon() {
        return createdon;
    }
    public void setCreatedon(final Date value) {
        this.createdon = value;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private Builder() {}

        private String number;
        private BigDecimal hour;
        private Integer month;
        private Integer year;
        private Date createdon;

        public Builder withNumber(final String value) {
            this.number = value;
            return this;
        }

        public Builder withHour(final BigDecimal value) {
            this.hour = value;
            return this;
        }

        public Builder withMonth(final Integer value) {
            this.month = value;
            return this;
        }

        public Builder withYear(final Integer value) {
            this.year = value;
            return this;
        }

        public Builder withCreatedon(final Date value) {
            this.createdon = value;
            return this;
        }

        public Monthvalue build() {
            final Monthvalue result = new Monthvalue();
            result.number = number;
            result.hour = hour;
            result.month = month;
            result.year = year;
            result.createdon = createdon;
            return result;
        }
    }
}
