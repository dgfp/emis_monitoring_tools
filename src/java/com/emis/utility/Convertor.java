package com.emis.utility;

import org.json.JSONArray;
import org.json.JSONObject;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Locale;
import org.json.JSONException;

/**
 * Utility for converting ResultSets into some Output formats
 *
 * @author marlonlom
 */
public class Convertor {

    /**
     * Convert a result set into a JSON Array
     *
     * @param resultSet
     * @return a JSONArray
     * @throws Exception
     */
    public static JSONArray toJSON(ResultSet resultSet, Object nullValue) throws Exception {
        JSONArray jsonArray = new JSONArray();
        while (resultSet.next()) {
            int total_rows = resultSet.getMetaData().getColumnCount();
            JSONObject obj = new JSONObject();
            for (int i = 0; i < total_rows; i++) {
                String columnName = resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase();
                Object columnValue = null;
                try {
                    columnValue = resultSet.getObject(i + 1);
                } catch (Exception e) {
                    System.out.println(columnName + "=" + columnValue);
                }

                if (columnValue == null) {
                    columnValue = nullValue;
                    //columnValue =  "null";
                }
                obj.put(columnName, columnValue);
            }
            jsonArray.put(obj);
        }
        //System.out.println("Json String: " + jsonArray.toString());//for debug purpuse
        return jsonArray;
    }

    public static JSONArray toJSON(ResultSet resultSet) throws Exception {
        return toJSON(resultSet, JSONObject.NULL);
    }

    public static JSONArray convertResultSetIntoJSON(ResultSet resultSet) throws Exception {
        return toJSON(resultSet, "null");
    }

    public static JSONArray convertResultSetIntoJSONEPI(ResultSet resultSet) throws Exception {
        return toJSON(resultSet, "");
    }

    public static JSONArray convertJSONResultSetIntoJSON(ResultSet resultSet, Object nullValue) throws Exception {
        JSONArray jsonArray = new JSONArray();
        ResultSetMetaData rsmd = resultSet.getMetaData();
        while (resultSet.next()) {
            int total_rows = resultSet.getMetaData().getColumnCount();
            String c = null;
            Object columnValue = null;
            JSONObject obj = new JSONObject();
            for (int i = 0; i < total_rows; i++) {
                String columnName = resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase();
                try {
                    if (columnName.equals("json")) {
                        c = resultSet.getString(i + 1);
                        JSONArray obj1 = new JSONArray(c);
                        obj.put(columnName, obj1);
                    } else {
                        columnValue = resultSet.getObject(i + 1);
                        obj.put(columnName, columnValue);
                    }
                } catch (Exception e) {
                    System.out.println(e.toString());
                }
//                if (c == null) {
//                    obj = null;
                //columnValue =  "null";
//                }
            }
            jsonArray.put(obj);
        }
        //System.out.println("Json String: " + jsonArray.toString());//for debug purpuse
        return jsonArray;
    }

    public static JSONArray convertResultSetIntoJSONWithDash(ResultSet resultSet) throws Exception {
        JSONArray jsonArray = new JSONArray();
        while (resultSet.next()) {
            int total_rows = resultSet.getMetaData().getColumnCount();
            JSONObject obj = new JSONObject();
            for (int i = 0; i < total_rows; i++) {
                String columnName = resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase();
                Object columnValue = resultSet.getObject(i + 1);
                // if value in DB is null, then we set it to default value
                if (columnValue == null) {
                    // columnValue = "null";
                    columnValue = "-";
                }
                /*
                Next if block is a hack. In case when in db we have values like price and price1 there's a bug in jdbc - 
                both this names are getting stored as price in ResulSet. Therefore when we store second column value,
                we overwrite original value of price. To avoid that, i simply add 1 to be consistent with DB.
                 */
                if (obj.has(columnName)) {
                    columnName += "1";
                }
                obj.put(columnName, columnValue);
            }
            jsonArray.put(obj);
        }

        System.out.println("Json String: " + jsonArray.toString());//for debug purpuse

        return jsonArray;
    }

    public static JSONArray convertResultSetIntoJSONWithZero(ResultSet resultSet) throws Exception {
        JSONArray jsonArray = new JSONArray();
        while (resultSet.next()) {
            int total_rows = resultSet.getMetaData().getColumnCount();
            JSONObject obj = new JSONObject();
            for (int i = 0; i < total_rows; i++) {
                String columnName = resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase();
                Object columnValue = resultSet.getObject(i + 1);
                // if value in DB is null, then we set it to default value
                if (columnValue == null) {
                    // columnValue = "null";
                    columnValue = "-";
                }
                /*
                Next if block is a hack. In case when in db we have values like price and price1 there's a bug in jdbc - 
                both this names are getting stored as price in ResulSet. Therefore when we store second column value,
                we overwrite original value of price. To avoid that, i simply add 1 to be consistent with DB.
                 */
                if (obj.has(columnName)) {
                    columnName += "1";
                }
                obj.put(columnName, columnValue);
            }
            jsonArray.put(obj);
        }

        System.out.println("Json String: " + jsonArray.toString());//for debug purpuse

        return jsonArray;
    }

    public static JSONArray convertResultSetIntoJSON_MIS(ResultSet resultSet) throws Exception {
        JSONArray jsonArray = new JSONArray();
        while (resultSet.next()) {
            int total_rows = resultSet.getMetaData().getColumnCount();
            JSONObject obj = new JSONObject();
            for (int i = 0; i < total_rows; i++) {
                String columnName = resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase();
                Object columnValue = resultSet.getObject(i + 1);
                // if value in DB is null, then we set it to default value
                if (columnValue == null) {
                    // columnValue = "null";
                    columnValue = "-";
                }
                /*
                Next if block is a hack. In case when in db we have values like price and price1 there's a bug in jdbc - 
                both this names are getting stored as price in ResulSet. Therefore when we store second column value,
                we overwrite original value of price. To avoid that, i simply add 1 to be consistent with DB.
                 */
                if (obj.has(columnName)) {
                    columnName += "1";
                }
                obj.put(columnName, columnValue);
            }
            jsonArray.put(obj);
        }

        System.out.println("Json String: " + jsonArray.toString());//for debug purpuse

        return jsonArray;
    }

    public static JSONArray convertResultSetIntoJSON_LMIS(ResultSet resultSet) throws Exception {
        JSONArray jsonArray = new JSONArray();
        while (resultSet.next()) {
            int total_rows = resultSet.getMetaData().getColumnCount();
            JSONObject obj = new JSONObject();
            for (int i = 0; i < total_rows; i++) {
                String columnName = resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase();
                Object columnValue = resultSet.getObject(i + 1);
                // if value in DB is null, then we set it to default value
                if (columnValue == null) {
                    // columnValue = "null";
                    columnValue = "null";
                }
                /*
                Next if block is a hack. In case when in db we have values like price and price1 there's a bug in jdbc - 
                both this names are getting stored as price in ResulSet. Therefore when we store second column value,
                we overwrite original value of price. To avoid that, i simply add 1 to be consistent with DB.
                 */
                if (obj.has(columnName)) {
                    columnName += "1";
                }
                Object miscol = null;

                if (resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase().equals("miscolumnno")) {
                    miscol = resultSet.getObject(i + 1);
                } else {
                    miscol = "";
                }

                obj.put(miscol + "_" + columnName, columnValue);
            }

            jsonArray.put(obj);
        }

        System.out.println("Json String: " + jsonArray.toString());//for debug purpuse

        return jsonArray;
    }

    public static int converBooleanIntoInt(boolean bool) {
        if (bool) {
            return 1;
        } else {
            return 0;
        }
    }

    public static int convertBooleanStringIntoInt(String bool) {
        if (bool.equals("false")) {
            return 0;
        } else if (bool.equals("true")) {
            return 1;
        } else {
            throw new IllegalArgumentException("wrong value is passed to the method. Value is " + bool);
        }
    }

    public static double getDoubleOutOfString(String value, String format, Locale locale) {
        DecimalFormatSymbols otherSymbols = new DecimalFormatSymbols(locale);
        otherSymbols.setDecimalSeparator('.');
        DecimalFormat f = new DecimalFormat(format, otherSymbols);
        String formattedValue = f.format(Double.parseDouble(value));
        double number = Double.parseDouble(formattedValue);
        return Math.round(number * 100.0) / 100.0;
    }

    public static String convertToCustomDateFormat(String date) {
        String[] parts = date.split("/");
        String day = parts[0];
        String month = parts[1];
        String year = parts[2];
        return (year + "-" + month + "-" + day);
    }

    public static String convertDateToUserFormat(String date) {
        String[] parts = date.split("-");
        String day = parts[2];
        String month = parts[1];
        String year = parts[0];
        return (day + "/" + month + "/" + year);
    }

    public static JSONArray getMergeJsonArrays(ArrayList<JSONArray> jsonArrays) throws JSONException {
        JSONArray MergedJsonArrays = new JSONArray();
        for (JSONArray tmpArray : jsonArrays) {
            for (int i = 0; i < tmpArray.length(); i++) {
                MergedJsonArrays.put(tmpArray.get(i));
            }
        }
        return MergedJsonArrays;
    }

    public static String dateTimeNow() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        return dtf.format(now);
    }

}
