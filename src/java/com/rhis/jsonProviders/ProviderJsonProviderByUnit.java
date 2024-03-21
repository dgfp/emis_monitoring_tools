package com.rhis.jsonProviders;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "ProviderJsonProviderByUnit", urlPatterns = {"/ProviderJsonProviderByUnit"})
public class ProviderJsonProviderByUnit extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String zilaId = request.getParameter("zilaId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String unitId = request.getParameter("unitId"); //unitId
            
            System.out.println("Unit: "+unitId);
            
            String providerCode =  (String) request.getSession(false).getAttribute("providerCode");
            String userLevel =  (String) request.getSession(false).getAttribute("userLevel");
            String username =  (String) request.getSession(false).getAttribute("username");
            String where="";
            if(providerCode!=null && userLevel=="7"){
                    //Temporary Soultions for tab view
                    if(!username.equals("fpi_provider"))
                        where =" and pdb.providerid = "+providerCode;
            }

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zilaId));
                ResultSet result = db.select("select distinct pdb.providerid,pdb.provname \n" +
                                                            "from providerdb pdb \n" +
                                                            "inner join providerarea pa \n" +
                                                            "on pdb.providerid = pa.providerid  \n" +
                                                            "where  pa.zillaid = "+zilaId+" \n" +
                                                            "and pa.upazilaid = "+upazilaId+" \n" +
                                                            "and pa.unionid = "+unionId+" \n" +
                                                            "and pa.provtype=3 \n" +
                                                            "and pa.fwaunit = "+unitId+" "+where);
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
