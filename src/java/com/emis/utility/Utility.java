package com.emis.utility;

import com.emis.entity.PRS;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Helal
 */
public class Utility {

    private static final String CUSTOM_LOG_FILE = "/resources/app.log";

    public static String getLogFile() {
        return CUSTOM_LOG_FILE;
    }

    public static String getDateNow() {
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date date = new Date();
        return dateFormat.format(date);
    }

    public static String getDateNowFormated(String format) {
        DateFormat dateFormat = new SimpleDateFormat(format);
        Date date = new Date();
        return dateFormat.format(date);
    }

    public static boolean isEmpty(final String s) {
        return s == null || s.trim().isEmpty();
    }

    public static String getParam(String k, String v, HttpServletRequest request) {
        String p = request.getParameter(k);
        return isEmpty(p) ? v : p;
    }

    public static boolean inArray(String[] haystack, String needle) {
        Set<String> set = new HashSet<>(Arrays.asList(haystack));
        return set.contains(needle);
    }

    public static <T> boolean contains(final T[] array, final T v) {
        Set<T> set = new HashSet<>(Arrays.asList(array));
        return set.contains(v);
    }

    public static Timestamp now() {
        Date now = new java.util.Date();
        return new java.sql.Timestamp(now.getTime());
    }

    public String errorResponse() {
        return "{\"success\": false,\"data\": null, \"message\": \"Somthing went wrong\"}";
    }

    public static boolean isNumeric(String str) {
        for (char c : str.toCharArray()) {
            if (!Character.isDigit(c)) {
                return false;
            }
        }
        return true;
    }

    public static boolean isAjax(HttpServletRequest request) {
        String heardeName = request.getHeader("x-requested-with");
        return heardeName != null;
    }

    public static void customLogWriter(String content, String dirname) {

//        String content = "This is the content to write into file";
//
//        System.out.println(getServletContext());
//        String dirname = getServletContext().getRealPath("/resources/app.log");
//        System.out.println(dirname);
        BufferedWriter out = null;

        try {
            out = new BufferedWriter(new FileWriter(dirname, true));
            out.append(content + "\n");
        } catch (IOException e) {
            e.printStackTrace();
        } finally {

            try {
                if (out != null) {
                    out.close();
                } else {
                    System.out.println("Buffer has not been initialized!");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static PRS setStartDate(PRS prs) {
        if (prs.getStartDate().equals("")) {
            prs.setStartDate("01/01/2015");
        }
        return prs;
    }

    public static String changeFormat(String date) {
        String d[] = date.split("/");
        return d[2] + "-" + len(d[1]) + "-" + len(d[0]);
    }

    public static String changeDateFormat(String date) {
        String d[] = date.split("-");
        return len(d[2]) + "/" + len(d[1]) + "/" + d[0];
    }

    public static String getUserId(HttpServletRequest request) {
        return request.getSession().getAttribute("username").toString();
    }

    private static String len(String str) {
        if (str.length() == 1) {
            return "0" + str;
        }
        return str;
    }
}
