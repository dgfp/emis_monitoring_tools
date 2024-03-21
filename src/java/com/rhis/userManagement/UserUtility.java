/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rhis.userManagement;

import com.emis.beans.LoginUser;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.security.spec.KeySpec;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import org.json.JSONArray;

/**
 *
 * @author nar_r
 */
public class UserUtility {

    private static final String SECRET_KEY = "my_super_secret_key_ho_ho_ho";
    private static final String SALT = "ssshhhhhhhhhhh!!!!";

    public static boolean checkUserExist(String userid) throws SQLException {
        String sql = "select * from public.loginuser where uname='" + userid + "';";
        DBManagerMonitoring db = new DBManagerMonitoring();
        ResultSet rs = db.select(sql);
        if (!rs.next()) {
            return false;
        }
        return true;
    }

    public static boolean checkPasswordFromFilter(String userid) throws Exception {
        String sql = "select * from public.loginuser where uname='" + userid + "';";
        String sql2 = "SELECT u.userid, r.rolename,l.name FROM public.web_userrole u\n"
                + "inner join public.loginuser l on l.userid=u.userid\n"
                + "inner join public.web_role r on u.roleid=r.roleid where u.userid='" + userid + "'";
        String password = "";
        String role = "";
        DBManagerMonitoring db = new DBManagerMonitoring();
        DBManagerMonitoring db2 = new DBManagerMonitoring();

        ResultSet result = db.select(sql);
        while (result.next()) {
            password = result.getString("pass");
        }
        ResultSet result2 = db2.select(sql2);
        while (result2.next()) {
            role = result2.getString("rolename");
        }
//        JSONArray json = Convertor.convertResultSetIntoJSONWithDash(result);
        boolean passwordStrength = redirectUserafterlogin(password, "", role);
        return passwordStrength;
    }

    public static boolean redirectUserafterlogin(String passwordhere, String slug, String role) {
        boolean passwordStrength = !UserUtility.isValidPassword(passwordhere, "");
        String[] forceRoleToChangePassword = {"Super admin", "Admin"};
        boolean isAdmin = Arrays.asList(forceRoleToChangePassword).contains(role);
        if (passwordStrength && isAdmin) {
            slug = "/profile-change-password";
            return true;
        }
        return false;
    }

    public static boolean checkUserEmailExists(String userid) throws Exception {
        String sql = "select * from public.loginuser where uname='" + userid + "';";
        String email = "";
        DBManagerMonitoring db = new DBManagerMonitoring();
        boolean emailExists = false;
        ResultSet result = db.select(sql);
        while (result.next()) {
            email = result.getString("email");
        }
        if (email == null || email.isEmpty()) {
            emailExists = false;
        } else {
            emailExists = true;
        }
        return emailExists;
    }

    public static String getUserEmail(String userid) throws Exception {
        String sql = "select * from public.loginuser where uname='" + userid + "';";
        String email = "";
        DBManagerMonitoring db = new DBManagerMonitoring();
        ResultSet result = db.select(sql);
        while (result.next()) {
            email = result.getString("email");
        }
        if (email.isEmpty()) {
            email = null;
        }
        return email;
    }

    public static boolean isValidPassword(String passwordhere, String confirmhere) {

        Pattern specailCharPatten = Pattern.compile("[^a-z0-9 ]", Pattern.CASE_INSENSITIVE);
        Pattern UpperCasePatten = Pattern.compile("[A-Z ]");
        Pattern lowerCasePatten = Pattern.compile("[a-z ]");
        Pattern digitCasePatten = Pattern.compile("[0-9 ]");
        List<String> errorList = new ArrayList<String>();
        errorList.clear();

        boolean flag = true;

//        if (!passwordhere.equals(confirmhere)) {
//            errorList.add("password and confirm password does not match");
//            flag = false;
//        }
        if (passwordhere.length() < 8) {
            errorList.add("Password lenght must have alleast 8 character !!");
            flag = false;
        }
        if (!specailCharPatten.matcher(passwordhere).find()) {
            errorList.add("Password must have atleast one specail character !!");
            flag = false;
        }
        if (!UpperCasePatten.matcher(passwordhere).find()) {
            errorList.add("Password must have atleast one uppercase character !!");
            flag = false;
        }
        if (!lowerCasePatten.matcher(passwordhere).find()) {
            errorList.add("Password must have atleast one lowercase character !!");
            flag = false;
        }
        if (!digitCasePatten.matcher(passwordhere).find()) {
            errorList.add("Password must have atleast one digit character !!");
            flag = false;
        }

        return flag;

    }

    /**
     * Encrypt a string using AES encryption algorithm.
     *
     * @param pwd the password to be encrypted
     * @return the encrypted string
     */
    public static String encrypt(String strToEncrypt) {
        try {
            byte[] iv = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
            IvParameterSpec ivspec = new IvParameterSpec(iv);

            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            KeySpec spec = new PBEKeySpec(SECRET_KEY.toCharArray(), SALT.getBytes(), 65536, 256);
            SecretKey tmp = factory.generateSecret(spec);
            SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES");

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivspec);

            return Base64.getEncoder()
                    .encodeToString(cipher.doFinal(strToEncrypt.getBytes(StandardCharsets.UTF_8)));
        } catch (Exception e) {
            System.out.println("Error while encrypting: " + e.toString());
        }
        return null;
    }

    /**
     * Decrypt a string with AES encryption algorithm.
     *
     * @param encryptedData the data to be decrypted
     * @return the decrypted string
     */
    public static String decrypt(String strToDecrypt) {
        try {
            byte[] iv = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
            IvParameterSpec ivspec = new IvParameterSpec(iv);

            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            KeySpec spec = new PBEKeySpec(SECRET_KEY.toCharArray(), SALT.getBytes(), 65536, 256);
            SecretKey tmp = factory.generateSecret(spec);
            SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES");

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.DECRYPT_MODE, secretKey, ivspec);
            return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
        } catch (Exception e) {
            System.out.println("Error while decrypting: " + e.toString());
        }
        return null;
    }

    public static String generateResetPasswordURL(HttpServletRequest request, String encryptUsername) {
        String url = "http://" + request.getServerName() + ":" + request.getServerPort() + "/emis-monitoringtools"
                + "/profile-online-change-password?u=" + encryptUsername;
//        String url = "http://emis.icddrb.org:8080" + "/emis-monitoringtools"
//                + "/profile-online-change-password?u=" + encryptUsername;
        System.out.println(url);
        return url;
    }

    public static String executePost(String targetURL, String urlParameters) {
        HttpURLConnection connection = null;

        try {
            //Create connection
            URL url = new URL(targetURL);
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type",
                    "application/x-www-form-urlencoded");

            connection.setRequestProperty("Content-Length",
                    Integer.toString(urlParameters.getBytes().length));
            connection.setRequestProperty("Content-Language", "en-US");

            connection.setUseCaches(false);
            connection.setDoOutput(true);
//            urlParameters = escapeMetaCharacters(urlParameters);

            //Send request
            Writer wr = new OutputStreamWriter(
                    connection.getOutputStream(), StandardCharsets.UTF_8);
            wr.write(urlParameters);
            wr.flush();
            wr.close();

            System.out.println("urlParameters" + URLEncoder.encode(urlParameters, StandardCharsets.UTF_8.toString()));
            //Get Response
            InputStream is = connection.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
            StringBuilder response = new StringBuilder(); // or StringBuffer if Java version 5+
            String line;
            while ((line = rd.readLine()) != null) {
                response.append(line);
                response.append('\r');
            }
            rd.close();
            return response.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }

    public static String escapeMetaCharacters(String inputString) {
        final String[] metaCharacters = {"\\", "^", "$", "{", "}", "[", "]", "(", ")", ".", "*", "+", "?", "|", "<", ">", "-", "&", "%"};

        for (int i = 0; i < metaCharacters.length; i++) {
            if (inputString.contains(metaCharacters[i])) {
                inputString = inputString.replace(metaCharacters[i], "\\" + metaCharacters[i]);
            }
        }
        return inputString;
    }

    public static Map<String, String> getQueryMap(String query) {
        String[] params = query.split("&");
        Map<String, String> map = new HashMap<String, String>();
        for (String param : params) {
            String[] p = param.split("=");
            String name = p[0];
            if (p.length > 1) {
                String value = p[1];
                map.put(name, value);
            }
        }
        return map;
    }
}
