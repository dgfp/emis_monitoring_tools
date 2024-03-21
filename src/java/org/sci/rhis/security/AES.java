package org.sci.rhis.security;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

import javax.xml.bind.DatatypeConverter;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

/**
 * @author sabah.mugab
 * @since July, 2017
 */
public class AES {

    public static void main(String[] args) {
        
        final String secretKeyEncrypt = "rhis_unified_monitoring";
        final String secretKeyDecrypt = "rhis_unified_monitoring";

        String originalString = "{u:admin,p:p@s$W0r:D}";
        String encryptedString = AES.encrypt(originalString, secretKeyEncrypt);
        String decryptedString = AES.decrypt(encryptedString, secretKeyDecrypt);

//        System.out.println(originalString);
//        System.out.println(encryptedString);
//        System.out.println(decryptedString);
    }

    private static SecretKeySpec getKey(String saltKey) {
        try {
            return new SecretKeySpec(Arrays.copyOf(MessageDigest.getInstance("SHA-1").digest(saltKey.getBytes("UTF-8")), 16), "AES");
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String encrypt(String strToEncrypt, String saltKey) {
        try {
            return DatatypeConverter.printBase64Binary(getCipherInstance("encrypt", saltKey).doFinal(strToEncrypt.getBytes("UTF-8")));
        } catch (Exception e) {
            System.out.println("Error while encrypting: " + e.toString());
            return "";
        }
    }

    public static String decrypt(String strToDecrypt, String saltKey) {
        try {
            return new String(getCipherInstance("decrypt", saltKey).doFinal(DatatypeConverter.parseBase64Binary(strToDecrypt)));
        } catch (Exception e) {
            //System.out.println("Error while decrypting: " + e.toString());
            return "Salt Mismatch";
        }
    }

    private static Cipher getCipherInstance(String mode, String saltKey) {
        try {
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
            if (mode.equals("encrypt")) {
                cipher.init(Cipher.ENCRYPT_MODE, getKey(saltKey));
            } else {
                cipher.init(Cipher.DECRYPT_MODE, getKey(saltKey));
            }
            return cipher;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
