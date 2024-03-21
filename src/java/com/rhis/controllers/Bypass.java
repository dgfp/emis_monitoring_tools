package com.rhis.controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import org.sci.rhis.security.Passphrase;

/**
 *
 * @author shahaz
 */
@WebServlet(name = "Bypass", urlPatterns = {"/bypass"})
public class Bypass extends LoginController {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String passphrase = request.getParameter("passphrase");
        //passphrase = passphrase.replace("+", "%2B");
        System.out.println("passphrase/encrypted:" + passphrase.toString());

        if (passphrase != null) {
            JSONObject obj = Passphrase.decrypt(passphrase);
            System.out.println("passphrase/decrypted:" + obj.toString());
            try {
                HttpSession session = request.getSession();
                session.setAttribute("user", obj.get("uid"));
                session.setAttribute("pass", obj.get("upass"));
                doPost(request, response);
            } catch (JSONException ex) {
                Logger.getLogger(Bypass.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("Error");
        }
    }
}