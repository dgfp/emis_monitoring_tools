package com.emis.beans;

/**
 *
 * @author Helal
 */
public class YearlyPopulationCount {
    public  int male;
    public  int female;
    public  int year;
    public  int total;

    public YearlyPopulationCount() {
        this.male =0;
        this.female =0;
        this.year = -1;
        this.total = 0;
    }

    public int getMale() {
        return male;
    }

    public void setMale(int male) {
        this.male = this.male+ male;
    }

    public int getFemale() {
        return  female;
    }

    public void setFemale(int female) {
        this.female = this.female+ female;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getTotal() {
        return male+female;
    }

    public void setTotal(int total) {
        this.total = this.total +total;
    }

    @Override
    public String toString() {
        return "YearlyPopulationCount{" + "male=" + male + ", female=" + female + ", year=" + year + ", total=" + total + '}';
    }
    
    
}
