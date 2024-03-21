//dgis2, open srp, cabinet ministry , citizen charter data structure (ccds)

package com.emis.beans;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Random;
import java.util.Base64;
import java.net.URLEncoder;
import java.net.URLDecoder;

/*
 @author Rahen
 */
public class Cipher {
    // private static final String UTF8="UTF8";

    private static final String UTF_8 = "UTF-8";
    private static final Random SALT = new Random((new Date()).getTime());
    private static final int SALT_SIZE = 8;

    public static int padded(int n) {
        return ((n + 2) / 3) << 2;
    }

    public static int padded() {
        return padded(SALT_SIZE);
    }

    public static int unpadded(int n) {
        return ((n << 2) | 2) / 3;
    }

    public static int unpadded() {
        return unpadded(SALT_SIZE);
    }

    public static byte[] getSalt(int n) {
        byte[] salt = new byte[n];
        SALT.nextBytes(salt);
        return salt;
    }

    public static byte[] getSalt() {
        return getSalt(SALT_SIZE);
    }

    public static Base64.Encoder encoder() {
        return Base64.getEncoder().withoutPadding();
    }

    public static Base64.Decoder decoder() {
        return Base64.getDecoder();
    }
    
    public static void test(String prefix,String[] dPassphrase){
        System.out.println(String.format("%s,POST>>/tresspass?u=%s&p=%s", prefix, dPassphrase[0], dPassphrase[1]));
    }
     public static void test(String prefix,String ePassphrase){
         System.out.println(String.format("%s,GET>>/bypass=%s", prefix, ePassphrase));
     };
     
    public static void main(String[] args) throws Exception {
        String u = "admin";
        String p = "p@s=&W0r:D";
        String ePassphrase = encryptPassphrase(u, p);
        String[] dPassphrase = decryptPassphrase(ePassphrase);
//        System.out.println("Base64.decode:" + decoder().decode(ePassphrase));
//        System.out.println("Cipher.decrypt:" + decoder().decode(ePassphrase));
//        System.out.println("decrypt.encryptPassphrase:" + ePassphrase);

        test("Cipher.encryptPassphrase",ePassphrase);
        test("Cipher.dycryptPassphrase",dPassphrase);
    }

    public static String encrypt(String str) {
        Base64.Encoder encoder = encoder();
        String p0 = encoder.encodeToString(getSalt());
        String p1 = encoder.encodeToString(str.getBytes());
        return p0 + p1;
    }

    public static String decrypt(String encstr) {
        int excluded = unpadded();
        String cipher = encstr.substring(excluded);
        Base64.Decoder decoder = decoder();
        return new String(decoder.decode(cipher));
    }

    public static String encryptPassphrase(String u, String p) throws UnsupportedEncodingException {
        try {
            u = URLEncoder.encode(u, UTF_8);
            p = URLEncoder.encode(p, UTF_8);
        } catch (UnsupportedEncodingException e) {
        }
         u =encrypt(u);
         p =encrypt(p);
        String queryString = String.format("u=%s&p=%s", u, p);
        String passphrase = encrypt(queryString);
        return passphrase;
    }

    public static String[] decryptPassphrase(String passphrase) {
        String queryString = decrypt(passphrase);
        String u = getParameter("u", queryString);
        String p = getParameter("p", queryString);
         u =decrypt(u);
         p =decrypt(p);
        return new String[]{u, p};
    }

    public static String getParameter(String key, String queryString) {
        String param = queryString.replaceAll("^(?=.*" + key + "=([^&]+)|).+$", "$1");
        try {
            param = URLDecoder.decode(param, UTF_8);
        } catch (UnsupportedEncodingException e) {
        }
        return param;
    }
}
