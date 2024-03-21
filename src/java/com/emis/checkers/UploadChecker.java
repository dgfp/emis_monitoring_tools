package com.emis.checkers;

import com.rhis.db.DBManagerMonitoring;
import com.rhis.db.DBManagerDistrict;
import com.emis.utility.Convertor;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;


/**
 *
 * @author Helal
 */
@WebServlet(name = "UploadChecker", urlPatterns = {"/uploadChecker"})
public class UploadChecker extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/checkers/uploadChecker.jsp");
                dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            int zillaid=93;
            String providerId = request.getParameter("providerId");
            String query1="select * from fn_table_record_count__after_upload_new("+providerId+")";
            String query2  = "select * from number_of_record_in_server_compare_new where providerid ="+providerId;
            
            try {
                DBManagerDistrict db1 = new DBManagerDistrict(zillaid);
                db1.select(query1);
                
                DBManagerDistrict db2 = new DBManagerDistrict(zillaid);
                ResultSet result = db2.select(query2);
                
                JSONArray json = Convertor.toJSON(result);
                
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                ex.getMessage();
            }
    }

}
