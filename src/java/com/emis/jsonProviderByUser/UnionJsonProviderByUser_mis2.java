package com.emis.jsonProviderByUser;

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
 * @author Helal
 */
@WebServlet(name = "UnionJsonProviderByUser_mis2", urlPatterns = {"/UnionJsonProviderByUser_mis2"})
public class UnionJsonProviderByUser_mis2 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String district = (String) request.getSession(false).getAttribute("district");
            String upazila = (String) request.getSession(false).getAttribute("upazila");
            String union = (String) request.getSession(false).getAttribute("union");

            String unions = "", sql = null;
            //String query = "select distinct pa.unionid from providerdb p join providerarea pa using (providerid) where supervisorcode = "+(String) request.getSession(false).getAttribute("providerCode");
            //ResultSet rs = new DBManagerDistrict(Integer.parseInt(district)).select("select distinct pa.unionid from providerdb p join providerarea pa using (providerid) where active = 1 and supervisorcode = " + (String) request.getSession(false).getAttribute("providerCode"));
            ResultSet rs = new DBManagerDistrict(Integer.parseInt(district)).select("select distinct unionid, name_union(zillaid, upazilaid, unionid) unionname, name_union_eng(zillaid, upazilaid, unionid) unionnameeng FROM providerdb where supervisorcode = " + (String) request.getSession(false).getAttribute("providerCode") + " and active = 1 order by unionname");
            //if (rs.next() != false) {
            if (rs != null) {
                while (rs.next()) {
                    unions += ", " + rs.getInt("unionid");
                }
                unions = unions.substring(2, unions.length());
                System.out.println(unions);
                String where = "where zillaid=" + district + " and upazilaid=" + upazila + " and unionid in (" + unions + ")";
                sql = "SELECT * FROM public.unions " + where + " ORDER BY unionnameeng ASC ";
            } else {
                sql = "SELECT * FROM unions where zillaid=" + district + " and upazilaid=" + upazila + " and unionid in (" + union + ")  ORDER BY unionnameeng ASC";
            }
            System.out.println(sql);

            ResultSet result = new DBManagerDistrict(Integer.parseInt(district)).select(sql);
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
