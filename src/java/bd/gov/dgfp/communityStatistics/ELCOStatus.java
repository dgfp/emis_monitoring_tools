package bd.gov.dgfp.communityStatistics;

import com.emis.entity.EligibleCoupleStatus;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
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
@WebServlet(name = "ELCOStatus", urlPatterns = {"/elco-status"})
public class ELCOStatus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("COMMUNITY STATISTICS", "elco-status", request);
        request.getRequestDispatcher("WEB-INF/jsp/dgfpCommunityStatistics/ELCOStatus.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            EligibleCoupleStatus elco = new ObjectMapper().readValue(request.getParameter("data").toString(), EligibleCoupleStatus.class);
            System.out.println(elco);
            String sql = "";
            String json = "";
            if (elco.getLevel().equals("aggregate")) {
                switch (elco.getReportType()) {
                    case "byMethodCategory":
                        if (elco.getUpazila() == 0) {
                            sql = "SELECT  * from public.web_elco_status_upazila_wise_by_method_category(" + elco.getDistrict() + ") order by upzilanameeng asc;";
                        } else if (elco.getUnion() == 0) {
                            sql = "SELECT  * from public.web_elco_status_union_wise_by_method_category(" + elco.getDistrict() + "," + elco.getUpazila() + ") order by unionnameeng asc";
                        } else if (elco.getUnit() == 0) {
                            sql = "SELECT  * from public.web_elco_status_unit_wise_by_method_category(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getUnion() + ") order by uname asc";
                        } else if (elco.getUnit() != 0 && elco.getLevel().equals("aggregate")) {
                            sql = "SELECT  * from public.web_elco_status_unit_wise_by_method_category(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getUnion() + ") where unitid = " + elco.getUnit() + " order by uname asc;";
                        }
                        json = "[\n"
                                + "	{\n"
                                + "		\"active\": 1,\n"
                                + "		\"assign_type\": 1,\n"
                                + "		\"providerid\": 93108,\n"
                                + "		\"providermobile\": \"01720343835\",\n"
                                + "		\"provname\": \"Selina Akter\",\n"
                                + "		\"reporting_unionid\": 94,\n"
                                + "		\"uname\": \"1KA\",\n"
                                + "		\"unionnameeng\": \"UARSI\",\n"
                                + "		\"unit\": 2,\n"
                                + "		\"unitid\": 4200,\n"
                                + "		\"upazilaid\": 66,\n"
                                + "		\"upazilanameeng\": \"MIRZAPUR\",\n"
                                + "		\"zillaid\": 93,\n"
                                + "		\"short_term_acceptor\": 234,\n"
                                + "		\"short_term_visited\": 50.0,\n"
                                + "		\"long_term_acceptor\": 25,\n"
                                + "		\"long_term_visited\": 20.0,\n"
                                + "		\"permanent_term_acceptor\": 11,\n"
                                + "		\"permanent_term_visited\": 25.0\n"
                                + "		\n"
                                + "	},\n"
                                + "	{\n"
                                + "		\"active\": 1,\n"
                                + "		\"assign_type\": 1,\n"
                                + "		\"providerid\": 93051,\n"
                                + "		\"providermobile\": \"01738765530\",\n"
                                + "		\"provname\": \"Afroza Akter\",\n"
                                + "		\"reporting_unionid\": 94,\n"
                                + "		\"uname\": \"1KHA\",\n"
                                + "		\"unionnameeng\": \"UARSI\",\n"
                                + "		\"unit\": 3,\n"
                                + "		\"unitid\": 4199,\n"
                                + "		\"upazilaid\": 66,\n"
                                + "		\"upazilanameeng\": \"MIRZAPUR\",\n"
                                + "		\"zillaid\": 93,\n"
                                + "		\"short_term_acceptor\": 234,\n"
                                + "		\"short_term_visited\": 50.0,\n"
                                + "		\"long_term_acceptor\": 25,\n"
                                + "		\"long_term_visited\": 20.0,\n"
                                + "		\"permanent_term_acceptor\": 11,\n"
                                + "		\"permanent_term_visited\": 25.0\n"
                                + "	}\n"
                                + "]";
                        break;
                    case "byMethod":
                        if (elco.getUpazila() == 0) {
                            sql = "SELECT  * from public.web_elco_status_upazila_wise_by_method(" + elco.getDistrict() + ") order by upzilanameeng asc;";
                        } else if (elco.getUnion() == 0) {
                            sql = "SELECT  * from public.web_elco_status_union_wise_by_method(" + elco.getDistrict() + "," + elco.getUpazila() + ") order by unionnameeng asc";
                        } else if (elco.getUnit() == 0) {
                            sql = "SELECT  * from public.web_elco_status_unit_wise_by_method(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getUnion() + ") order by uname asc";
                        } else if (elco.getUnit() != 0 && elco.getLevel().equals("aggregate")) {
                            sql = "SELECT  * from public.web_elco_status_unit_wise_by_method(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getUnion() + ") where unitid = " + elco.getUnit() + " order by uname asc;";
                        }
                        json = "[\n"
                                + "	{\n"
                                + "		\"active\": 1,\n"
                                + "		\"assign_type\": 1,\n"
                                + "		\"providerid\": 93108,\n"
                                + "		\"providermobile\": \"01720343835\",\n"
                                + "		\"provname\": \"Selina Akter\",\n"
                                + "		\"reporting_unionid\": 94,\n"
                                + "		\"uname\": \"1KA\",\n"
                                + "		\"unionnameeng\": \"UARSI\",\n"
                                + "		\"unit\": 2,\n"
                                + "		\"unitid\": 4200,\n"
                                + "		\"upazilaid\": 66,\n"
                                + "		\"upazilanameeng\": \"MIRZAPUR\",\n"
                                + "		\"zillaid\": 93,\n"
                                + "		\"oral_pill_acceptor\": 234,\n"
                                + "		\"oral_pill_visited\": 50.0,\n"
                                + "		\"condom_acceptor\": 25,\n"
                                + "		\"condom_visited\": 20.0,\n"
                                + "		\"injectable_acceptor\": 25,\n"
                                + "		\"injectable_visited\": 20.0,\n"
                                + "		\"iud_acceptor\": 25,\n"
                                + "		\"iud_visited\": 20.0,\n"
                                + "		\"implant_acceptor\": 25,\n"
                                + "		\"implant_visited\": 20.0,\n"
                                + "		\"permanent_method_male_acceptor\": 234,\n"
                                + "		\"permanent_method_male_visited\": 50.0,\n"
                                + "		\"permanent_method_female_acceptor\": 234,\n"
                                + "		\"permanent_method_female_visited\": 50.0\n"
                                + "		\n"
                                + "	},\n"
                                + "	{\n"
                                + "		\"active\": 1,\n"
                                + "		\"assign_type\": 1,\n"
                                + "		\"providerid\": 93051,\n"
                                + "		\"providermobile\": \"01738765530\",\n"
                                + "		\"provname\": \"Afroza Akter\",\n"
                                + "		\"reporting_unionid\": 94,\n"
                                + "		\"uname\": \"1KHA\",\n"
                                + "		\"unionnameeng\": \"UARSI\",\n"
                                + "		\"unit\": 3,\n"
                                + "		\"unitid\": 4199,\n"
                                + "		\"upazilaid\": 66,\n"
                                + "		\"upazilanameeng\": \"MIRZAPUR\",\n"
                                + "		\"zillaid\": 93,\n"
                                + "		\"oral_pill_acceptor\": 234,\n"
                                + "		\"oral_pill_visited\": 50.0,\n"
                                + "		\"condom_acceptor\": 25,\n"
                                + "		\"condom_visited\": 20.0,\n"
                                + "		\"injectable_acceptor\": 25,\n"
                                + "		\"injectable_visited\": 20.0,\n"
                                + "		\"iud_acceptor\": 25,\n"
                                + "		\"iud_visited\": 20.0,\n"
                                + "		\"implant_acceptor\": 25,\n"
                                + "		\"implant_visited\": 20.0,\n"
                                + "		\"permanent_method_male_acceptor\": 234,\n"
                                + "		\"permanent_method_male_visited\": 50.0,\n"
                                + "		\"permanent_method_female_acceptor\": 234,\n"
                                + "		\"permanent_method_female_visited\": 50.0\n"
                                + "	}\n"
                                + "]";
                        break;
                    default:
                        response.getWriter().write(new Utility().errorResponse());
                }
            } else {

                if (elco.getVillage().equals("0")) {
                    //sql = "SELECT * from public.web_eligible_couple_village_individual_mv(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getUnion() + "," + elco.getUnit() + ", '%' ,TO_CHAR(NOW() :: DATE, 'dd/mm/yyyy')) where currstatus in (1,2,3,4,5,6,7) order by village asc";
                    sql = "SELECT  * from public.web_elco_status_village_individual(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getUnion() + "," + elco.getUnit() + ", '%')";
                } else {
                    //sql = "SELECT * from public.web_eligible_couple_village_individual_mv(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ", " + elco.getUnit() + ", '" + elco.getVillage().split(" ")[0] + "" + elco.getVillage().split(" ")[1] + "',TO_CHAR(NOW() :: DATE, 'dd/mm/yyyy')) where currstatus in (1,2,3,4,5,6,7) order by village asc";
                    sql = "SELECT  * from public.web_elco_status_village_individual(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getUnion() + "," + elco.getUnit() + ", '" + elco.getVillage().split(" ")[0] + "" + elco.getVillage().split(" ")[1] + "')";
                }

                json = "[\n"
                        + "	{\n"
                        + "		\"age\": 29,\n"
                        + "		\"currstatus\": 1,\n"
                        + "		\"elconame\": \"MOREYOM BEGUM\",\n"
                        + "		\"elcono\": 7317,\n"
                        + "		\"evname\": \"Oral pill\",\n"
                        + "		\"husband\": \"EISMIL MIAH\",\n"
                        + "		\"mobileno\": 1725777612,\n"
                        + "		\"mouzaid\": 543,\n"
                        + "		\"reporting_unionid\": 63,\n"
                        + "		\"unit\": 3,\n"
                        + "		\"unitid\": 4179,\n"
                        + "		\"unitname\": \"1KHA\",\n"
                        + "		\"upazilaid\": 66,\n"
                        + "		\"vdate\": \"2020-05-16\",\n"
                        + "		\"village\": \"JAMURKI\",\n"
                        + "		\"villageid\": 1,\n"
                        + "		\"zillaid\": 93\n"
                        + "	},\n"
                        + "	{\n"
                        + "		\"age\": 34,\n"
                        + "		\"currstatus\": 2,\n"
                        + "		\"elconame\": \"AMENA BEGUM\",\n"
                        + "		\"elcono\": 7218,\n"
                        + "		\"evname\": \"Condom\",\n"
                        + "		\"husband\": \"FAGUL BUIYA\",\n"
                        + "		\"mobileno\": 1962090240,\n"
                        + "		\"mouzaid\": 543,\n"
                        + "		\"reporting_unionid\": 63,\n"
                        + "		\"unit\": 3,\n"
                        + "		\"unitid\": 4179,\n"
                        + "		\"unitname\": \"1KHA\",\n"
                        + "		\"upazilaid\": 66,\n"
                        + "		\"vdate\": \"2020-07-13\",\n"
                        + "		\"village\": \"JAMURKI\",\n"
                        + "		\"villageid\": 1,\n"
                        + "		\"zillaid\": 93\n"
                        + "	},\n"
                        + "	{\n"
                        + "		\"age\": 34,\n"
                        + "		\"currstatus\": 3,\n"
                        + "		\"elconame\": \"AMENA BEGUM\",\n"
                        + "		\"elcono\": 7218,\n"
                        + "		\"evname\": \"Injectable\",\n"
                        + "		\"husband\": \"FAGUL BUIYA\",\n"
                        + "		\"mobileno\": 1962090240,\n"
                        + "		\"mouzaid\": 543,\n"
                        + "		\"reporting_unionid\": 63,\n"
                        + "		\"unit\": 3,\n"
                        + "		\"unitid\": 4179,\n"
                        + "		\"unitname\": \"1KHA\",\n"
                        + "		\"upazilaid\": 66,\n"
                        + "		\"vdate\": \"2020-07-13\",\n"
                        + "		\"village\": \"JAMURKI\",\n"
                        + "		\"villageid\": 1,\n"
                        + "		\"zillaid\": 93\n"
                        + "	},\n"
                        + "	{\n"
                        + "		\"age\": 34,\n"
                        + "		\"currstatus\": 4,\n"
                        + "		\"elconame\": \"AMENA BEGUM\",\n"
                        + "		\"elcono\": 7218,\n"
                        + "		\"evname\": \"IUD\",\n"
                        + "		\"husband\": \"FAGUL BUIYA\",\n"
                        + "		\"mobileno\": 1962090240,\n"
                        + "		\"mouzaid\": 543,\n"
                        + "		\"reporting_unionid\": 63,\n"
                        + "		\"unit\": 3,\n"
                        + "		\"unitid\": 4179,\n"
                        + "		\"unitname\": \"1KHA\",\n"
                        + "		\"upazilaid\": 66,\n"
                        + "		\"vdate\": \"2020-07-13\",\n"
                        + "		\"village\": \"JAMURKI\",\n"
                        + "		\"villageid\": 1,\n"
                        + "		\"zillaid\": 93\n"
                        + "	},\n"
                        + "	{\n"
                        + "		\"age\": 34,\n"
                        + "		\"currstatus\": 5,\n"
                        + "		\"elconame\": \"AMENA BEGUM\",\n"
                        + "		\"elcono\": 7218,\n"
                        + "		\"evname\": \"Implant\",\n"
                        + "		\"husband\": \"FAGUL BUIYA\",\n"
                        + "		\"mobileno\": 1962090240,\n"
                        + "		\"mouzaid\": 543,\n"
                        + "		\"reporting_unionid\": 63,\n"
                        + "		\"unit\": 3,\n"
                        + "		\"unitid\": 4179,\n"
                        + "		\"unitname\": \"1KHA\",\n"
                        + "		\"upazilaid\": 66,\n"
                        + "		\"vdate\": \"2020-07-13\",\n"
                        + "		\"village\": \"JAMURKI\",\n"
                        + "		\"villageid\": 1,\n"
                        + "		\"zillaid\": 93\n"
                        + "	},\n"
                        + "	{\n"
                        + "		\"age\": 34,\n"
                        + "		\"currstatus\": 6,\n"
                        + "		\"elconame\": \"AMENA BEGUM\",\n"
                        + "		\"elcono\": 7218,\n"
                        + "		\"evname\": \"Permanent method (Male)\",\n"
                        + "		\"husband\": \"FAGUL BUIYA\",\n"
                        + "		\"mobileno\": 1962090240,\n"
                        + "		\"mouzaid\": 543,\n"
                        + "		\"reporting_unionid\": 63,\n"
                        + "		\"unit\": 3,\n"
                        + "		\"unitid\": 4179,\n"
                        + "		\"unitname\": \"1KHA\",\n"
                        + "		\"upazilaid\": 66,\n"
                        + "		\"vdate\": \"2020-07-13\",\n"
                        + "		\"village\": \"JAMURKI\",\n"
                        + "		\"villageid\": 1,\n"
                        + "		\"zillaid\": 93\n"
                        + "	},\n"
                        + "	{\n"
                        + "		\"age\": 34,\n"
                        + "		\"currstatus\": 7,\n"
                        + "		\"elconame\": \"AMENA BEGUM\",\n"
                        + "		\"elcono\": 7218,\n"
                        + "		\"evname\": \"Permanent method (Female)\",\n"
                        + "		\"husband\": \"FAGUL BUIYA\",\n"
                        + "		\"mobileno\": 1962090240,\n"
                        + "		\"mouzaid\": 543,\n"
                        + "		\"reporting_unionid\": 63,\n"
                        + "		\"unit\": 3,\n"
                        + "		\"unitid\": 4179,\n"
                        + "		\"unitname\": \"1KHA\",\n"
                        + "		\"upazilaid\": 66,\n"
                        + "		\"vdate\": \"2020-07-13\",\n"
                        + "		\"village\": \"JAMURKI\",\n"
                        + "		\"villageid\": 1,\n"
                        + "		\"zillaid\": 93\n"
                        + "	}\n"
                        + "]";
            }
            DBManagerDistrict db = new DBManagerDistrict(elco.getDistrict());
            JSONArray jsonData = Convertor.convertResultSetIntoJSON(db.select(sql));
            //System.out.println(json);
            response.getWriter().write("{\"success\":true,\"data\":" + jsonData.toString() + "}");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().write(ex.getMessage());
        }
    }
}
