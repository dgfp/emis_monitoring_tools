package com.emis.checkers;

import com.emis.beans.Response;
import com.rhis.db.DBManagerMonitoring;
import com.rhis.db.DBManagerDistrict;
import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
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
@WebServlet(name = "DownloadChecker", urlPatterns = {"/downloadChecker"})
public class DownloadChecker extends HttpServlet {

    private static String[] SU = new String[]{"10", "11", "12", "15", "16"};

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //String providerid = request.getParameter("providerid");
        //System.out.println("Out:------------------------"+providerId);
        //request.setAttribute("providerid", providerid);
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/checkers/downloadChecker.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int providerid = Integer.parseInt(Utility.getParam("providerid", "0", request));
        String provtype = Utility.getParam("provtype", "0", request);
        int zillaid = Integer.parseInt(Utility.getParam("zillaid", "0", request));
        String table_suffix=Utility.contains(SU,provtype)?"_su":"";
        
        System.out.println("<<<zillaid/providerId/provtype>>> " + zillaid + "/" + providerid+ "/" + provtype);
        if (zillaid == 0) {
            DBManagerMonitoring dm = new DBManagerMonitoring();
            String qy = "SELECT zillaid,providerid from providerdb where providerid='" + providerid + "' limit 1;";
            String zid = dm.one(qy, "zillaid");
            if (!zid.isEmpty()) {
                zillaid = Integer.parseInt(zid);
            }
        }

        System.out.println("zillaid: " + zillaid);

        //String query1 = "select * from fn_table_record_count__after_upload_new(" + providerId + ")";
        //number_of_record_in_server_tab_after_download_in_tab_compare or number_of_record_in_server_tab_after_download_in_tab_compare_???
        //String sql = "select a.zillanameeng, a.upazilanameeng, a.unionnameeng, studyareaupzila_vw a join from number_of_record_in_server_tab_after_download_in_tab_compare c using(providerid) where providerid=" + providerId;
        String sql = "select p.*, c.*\n"
                + "from providerdb_vw p\n"
                //+ "join providertype t using(provtype)\n"
                //+ "join studyareaunion_vw a using (zillaid,upazilaid,unionid) \n"
                + "left join number_of_record_in_server_tab_after_download_in_tab_compare%s c \n"
                + "using(providerid) \n"
                + "where providerid='%s'";
        sql = String.format(sql, table_suffix, providerid);
        Response R = new Response();
        try {
            DBManagerDistrict db = new DBManagerDistrict(zillaid);
            ResultSet result = db.select(sql);
            JSONArray json = Convertor.toJSON(result);
//            ArrayList<Test> _list = new ArrayList<Test>();
//            _list.add(new Test());
//            _list.add(new Test());
//            R.setJsonList(_list);
            //json=new JSONArray("[{}]");
            R.setMessage("Data loaded successfully").setStatus(1).setData(json.toString());
//            response.setContentType("text/plain;charset=UTF-8");
//            System.out.println(json.toString());
//            response.getWriter().write(json.toString());

        } catch (Exception ex) {
            R.setMessage(ex.getMessage()).setStatus(0);
        }

        ObjectMapper mapper = new ObjectMapper();
        //mapper.writeValueAsString(car);
        mapper.writeValue(response.getOutputStream(), R);

    }

    private JSONArray JSONArray(String string) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public class Test {

        public String testName;
    }
}
