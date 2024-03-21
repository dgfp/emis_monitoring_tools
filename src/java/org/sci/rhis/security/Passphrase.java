package org.sci.rhis.security;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Rahen
 */
public class Passphrase {

    private static final String UTF_8 = "UTF-8";
    static final String SALT = "rhis_unified_monitoring";

    public static void main(String[] args) {
        String encryptedString = Passphrase.encrypt("sadmin", "a");
        String decryptedString = Passphrase.decrypt(encryptedString).toString();
        System.out.println(encryptedString);
        System.out.println(decryptedString);
//        String p = "c9smz3xGh S9r/Qp8QYUwT97cN1Mh6 i6ca4MYplvms=";
//        String e = Passphrase.decrypt(p).toString();
//        System.out.println(p);
//        System.out.println(e);
    }

    public static String encrypt(String u, String p) {
        JSONObject obj = new JSONObject();
        try {
            obj.put("uid", u);
            obj.put("upass", p);
        } catch (JSONException e) {
        }

        String enc = AES.encrypt(obj.toString(), SALT);
//        try {
//            enc = URLEncoder.encode(enc, UTF_8);
//        } catch (UnsupportedEncodingException ex) {
//
//        }
        return enc;
    }

    public static JSONObject decrypt(String enc) {
//        try {
//            enc = URLDecoder.decode(enc, UTF_8);
//        } catch (UnsupportedEncodingException ex) {
//
//        }
        String dec = AES.decrypt(enc, SALT);
        JSONObject obj = new JSONObject();
        try {
            obj = new JSONObject(dec);
        } catch (JSONException e) {
        }
        return obj;
    }
}
