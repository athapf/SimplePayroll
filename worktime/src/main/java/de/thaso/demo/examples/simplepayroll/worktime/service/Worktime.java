package de.thaso.demo.examples.simplepayroll.worktime.service;

import java.math.BigDecimal;
import java.util.Date;

public class Worktime{
    private String number;
    private BigDecimal hour;
    private Date date;
    private Date createdon;

    public Worktime() {}

    public Worktime(
            final String number,
            final BigDecimal hour,
            final Date date,
            final Date createdon) {
        this.number = number;
        this.hour = hour;
        this.date = date;
        this.createdon = createdon;
    }

    @Override
    public String toString() {
        return "Worktime{" +
            "number='" + number + '\'' +
            ", hour='" + hour + '\'' +
            ", date='" + date + '\'' +
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

    public Date getDate() {
        return date;
    }
    public void setDate(final Date value) {
        this.date = value;
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
        private Date date;
        private Date createdon;

        public Builder withNumber(final String value) {
            this.number = value;
            return this;
        }

        public Builder withHour(final BigDecimal value) {
            this.hour = value;
            return this;
        }

        public Builder withDate(final Date value) {
            this.date = value;
            return this;
        }

        public Builder withCreatedon(final Date value) {
            this.createdon = value;
            return this;
        }

        public Worktime build() {
            final Worktime result = new Worktime();
            result.number = number;
            result.hour = hour;
            result.date = date;
            result.createdon = createdon;
            return result;
        }
    }
}
