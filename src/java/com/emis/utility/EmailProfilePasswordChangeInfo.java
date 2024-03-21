package com.emis.utility;

import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import com.emis.service.UserArea;
import com.rhis.db.DBManagerMonitoring;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.rhis.userManagement.UserUtility;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
/**
 *
 * @author Nibras Ar Rakib
 */
@WebServlet(name = "EmailProfilePasswordCHangeInfo", urlPatterns = {"/email-profile-change-password-info"})
public class EmailProfilePasswordChangeInfo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        System.out.println("UserName"+session.getAttribute("username").toString());
        try {
            request.setAttribute("division", new UserArea().getDivisionNameByUserId(session.getAttribute("username").toString()));
            request.setAttribute("district", new UserArea().getDistrictNameByUserId(session.getAttribute("username").toString()));
            request.setAttribute("upazila", new UserArea().getUpazilaNameByUserId(session.getAttribute("username").toString()));
            request.setAttribute("union", new UserArea().getUnionNameByUserId(session.getAttribute("username").toString()));
            
            String userName = session.getAttribute("username").toString();
            String targetUrl = "http://emis1.dgfp.gov.bd:8090/emisdashboard/taskqueues/api/emis-reset-password-send-email";
//            String targetUrl = "http://localhost:8091/taskqueues/api/emis-reset-password-send-email";
            String encryptUserName = UserUtility.encrypt(userName);
            String resetUrl = UserUtility.generateResetPasswordURL(request, encryptUserName);
            String userEmail = UserUtility.getUserEmail(userName);
            
            String remoteRequest = UserUtility.executePost(targetUrl,
                    "url=" + URLEncoder.encode(resetUrl, StandardCharsets.UTF_8.toString()) 
                            + "&user_email="+ URLEncoder.encode(userEmail, StandardCharsets.UTF_8.toString()) 
                            + "&user=" + URLEncoder.encode(encryptUserName, StandardCharsets.UTF_8.toString()));
            
            System.out.println(URLEncoder.encode(encryptUserName, StandardCharsets.UTF_8.toString()) + "|" 
                    + URLDecoder.decode(UserUtility.decrypt(encryptUserName), StandardCharsets.UTF_8.toString()));
            request.setAttribute("remoteResponse", remoteRequest); // remoteRequest
            request.setAttribute("remoteResponseSuggest", "Please logout from this page and click on the activation link. <br /><br /> এই পেজ থেকে লগ আউট করুন এবং ইমেইল এর এক্টিভেশন লিংক এ ক্লিক করুন ।");
            
        } catch (SQLException ex) {
            Logger.getLogger(EmailProfilePasswordChangeInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(EmailProfilePasswordChangeInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/utility/email-profile-password-chage-info.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
