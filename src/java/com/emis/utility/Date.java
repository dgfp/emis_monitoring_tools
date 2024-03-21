package com.emis.utility;

import java.time.LocalDate;

/**
 *
 * @author Helal
 */
public class Date {

    public static String convertToISO(String date) {
        String[] d = date.split("/");
        return (d[2] + "-" + d[1] + "-" + d[0]);
    }
    
    public static int  getCurrentDay() {
        return LocalDate.now().getDayOfMonth();
    }
    
    public static int  getCurrentMonth() {
        return LocalDate.now().getMonthValue();
    }
    
    public static int  getCurrentYear() {
        return LocalDate.now().getYear();
    }
}