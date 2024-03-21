package bd.govt.dgfp.meetingManagement;

import com.emis.entity.NoticeMaster;
import com.emis.utility.EmailUtility;
import com.emis.utility.Utility;
import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.emis.dao.ProviderManagement.ProviderManagement;

/**
 *
 * @author Helal
 */
@WebServlet(name = "MailNotification", urlPatterns = {"/mail-notification"})
public class MailNotification extends HttpServlet {

    private String host;
    private String port;
    private String user;
    private String pass;

    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean success = false;
        try {
            HttpSession session = request.getSession();
            String recipient = (String) session.getAttribute("recipient");
            String district = (String) session.getAttribute("district");
            String providerCode = (String) session.getAttribute("providerCode");

            System.out.println(request);
            System.out.println("~~~~~~~~~~~~~~~~~~~before~~~~~~~~~~~~~~~~~~~~~~~~");
            NoticeMaster noticeMaster = new MeetingNotice().getMeetingNotice(request);

            String subject = "সভার নোটিশ";
            String content = this.getMailbody(noticeMaster, new ProviderManagement(Integer.parseInt(district)).getProviderNameByProviderId(Integer.parseInt(providerCode)));
            EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
            success = true;
        } catch (Exception ex) {
            System.out.println("~~~~~~~~~~~~~~~~~~~Email exception~~~~~~~~~~~~~~~~~~~");
            System.out.println(ex.getMessage());
            ex.printStackTrace();
            success = false;
        } finally {
            request.setAttribute("success", success);
            request.getRequestDispatcher("WEB-INF/jsp/meetingManagement/MailNotification.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    public String getMailbody(NoticeMaster noticeMaster, String name) {
        System.out.println(noticeMaster);
        String mailText = "আগামী " + Utility.changeDateFormat(noticeMaster.getMeeting_date()) + " তারিখ, সময় " + noticeMaster.getMeeting_time() + ", " + noticeMaster.getPlace() + " তে " + noticeMaster.getMeeting_type() + " অনুষ্ঠিত হবে, উক্ত সভায় আপনি আমন্ত্রিত।";
        String image = "https://seeklogo.com/images/G/govt-bangladesh-logo-D1143C363F-seeklogo.com.png";
        String mail = "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "	<head>\r\n"
                + "	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n"
                + "	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n"
                + "	<title></title>\r\n"
                + "	</head>\r\n"
                + "	<style>\r\n"
                + "		body {\r\n"
                + "			color: #2a2a2a;\r\n"
                + "			font-family: Arial, sans-serif;\r\n"
                + "			font-size: 18px;\r\n"
                + "			width: 100% !important;\r\n"
                + "			-webkit-text-size-adjust: 100%;\r\n"
                + "			-ms-text-size-adjust: 100%;\r\n"
                + "			margin: 0;\r\n"
                + "			padding: 0;\r\n"
                + "			margin-bottom: 20px;\r\n"
                + "			line-height: 18px;\r\n"
                + "		}\r\n"
                + "		h1, h2, h3, h4, h5 {\r\n"
                + "			font-weight: bold;\r\n"
                + "		}\r\n"
                + "		h1, h2, h3, h4, h5, p {\r\n"
                + "			margin: 0;\r\n"
                + "			padding: 0;\r\n"
                + "		}\r\n"
                + "		h1 {\r\n"
                + "			font-size: 24px;\r\n"
                + "			line-height: 32px;\r\n"
                + "		}\r\n"
                + "		h2 {\r\n"
                + "			font-size: 20px;\r\n"
                + "			line-height: 26px;\r\n"
                + "		}\r\n"
                + "		\r\n"
                + "		h3 {\r\n"
                + "			font-size: 18px;\r\n"
                + "			line-height: 26px;\r\n"
                + "		}\r\n"
                + "		h4 {\r\n"
                + "			font-size: 16px;\r\n"
                + "			line-height: 26px;\r\n"
                + "		}\r\n"
                + "		h5 {\r\n"
                + "			font-size: 14px;\r\n"
                + "			line-height: 20px;\r\n"
                + "		}\r\n"
                + "		p {\r\n"
                + "			font-size: 16px;\r\n"
                + "			line-height: 22px;\r\n"
                + "		}a {\r\n"
                + "			color: #eb1478;\r\n"
                + "			text-decoration: none;\r\n"
                + "		}\r\n"
                + "		ol {\r\n"
                + "			list-style-position: inside;\r\n"
                + "			margin: 0;\r\n"
                + "			padding: 0;\r\n"
                + "		}\r\n"
                + "		\r\n"
                + "		ul {\r\n"
                + "			list-style-position: inside;\r\n"
                + "			margin: 0;\r\n"
                + "			padding: 0;\r\n"
                + "		}\r\n"
                + "		\r\n"
                + "		li {\r\n"
                + "			font-size: 18px;\r\n"
                + "			line-height: 28px;\r\n"
                + "			margin: 18px 10px;\r\n"
                + "		}\r\n"
                + "		li>a {\r\n"
                + "			font-weight: bold;\r\n"
                + "		}table.footer p {\r\n"
                + "			line-height: 18px;\r\n"
                + "		}\r\n"
                + "		\r\n"
                + "		table.footer a {\r\n"
                + "			color: #2a2a2a;\r\n"
                + "		}\r\n"
                + "		table, td {\r\n"
                + "			border-collapse: collapse;\r\n"
                + "		}\r\n"
                + "		p.header {\r\n"
                + "			color: #eb1478;\r\n"
                + "			font-size: 24px;\r\n"
                + "		}\r\n"
                + "		hr {\r\n"
                + "			display: block;\r\n"
                + "			height: 1px;\r\n"
                + "			border: 0;\r\n"
                + "			border-top: 1px solid #DDDDDD;\r\n"
                + "			margin: 37px 0 30px;\r\n"
                + "			padding: 0;\r\n"
                + "			align: left;\r\n"
                + "		}\r\n"
                + "	</style>\r\n"
                + "	<body class=\"perks \"\r\n"
                + "		style=\"color: #2a2a2a; font-family: Arial, sans-serif; font-size: 18px; width: 100% !important; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; line-height: 18px; margin: 0 0 20px; padding: 0;\">\r\n"
                + "		<div style=\"background-color: #eae9ea;\"></div>\r\n"
                + "		<table height=\"100%\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\"\r\n"
                + "			border=\"0\" bgcolor=\"#eae9ea\" style=\"border-collapse: collapse;\">\r\n"
                + "			<tr>\r\n"
                + "				<td valign=\"top\" align=\"center\" style=\"border-collapse: collapse;\">\r\n"
                + "					<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"\r\n"
                + "						class=\"main\"\r\n"
                + "						style=\"border-collapse: collapse; margin-left: 30px; margin-right: 30px;\">\r\n"
                + "						<tr>\r\n"
                + "							<td align=\"left\" class=\"min_width\"\r\n"
                + "								style=\"border-collapse: collapse; width: 600px;\">\r\n"
                + "								<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"\r\n"
                + "									bgcolor=\"#ffffff\"\r\n"
                + "									style=\"border-collapse: collapse; margin-top: 10px;\" class=\"\">\r\n"
                + "									<tr>\r\n"
                + "										<td align=\"left\" style=\"border-collapse: collapse;\">\r\n"
                + "	\r\n"
                + "											<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"\r\n"
                + "												style=\"border-collapse: collapse;\">\r\n"
                + "												<tr style=\"margin: 0; padding: 0;\">\r\n"
                + "													<td align=\"center\" style=\"border-collapse: collapse; border-spacing: 0; padding: 50px;\">\r\n"
                + "														<div style=\"margin-bottom: 30px; text-align: left;\"\r\n"
                + "															align=\"left\">\r\n"
                + "															<a\r\n"
                + "																href=\"#\"\r\n"
                + "																utm_content=\"igg-header-logo\" utm_medium=\"email\"\r\n"
                + "																style=\"color: #eb1478; text-decoration: none;\"> <img\r\n"
                + "																alt=\"\" class=\"logo\"\r\n"
                + "																src=\"" + image + "\"\r\n"
                + "																style=\"display: block; border: none;\" width=\"125\">\r\n"
                + "															</a>\r\n"
                + "														</div>\r\n"
                + "\r\n"
                + "														<p style=\"font-size: 22px; line-height: 22px; margin: 0; padding: 0;\" align=\"left\">\r\n"
                + "															শ্রদ্ধেয় " + name + ",\r\n"
                + "														</p>\r\n"
                + "														<div style=\"text-align: left;\" align=\"left\">\r\n"
                + "															<p style=\"font-size: 20px; line-height: 28px; margin: 20px 0 0; padding: 0;\">" + mailText + "</p>\r\n"
                + "														</div>\r\n"
                + "														<p\r\n"
                + "															style=\"font-size: 20px; line-height: 22px; margin: 0; padding: 0;\">\r\n"
                + "														</p>\r\n"
                + "														<div style=\"width: 100px; margin: 35px 0px; border: 1px solid #e9e9e9;\"></div>\r\n"
                + "														<p style=\"text-align:left;font-size: 20px; line-height: 22px; margin: 0; padding: 0;\">\r\n"
                + "															আমন্ত্রণে,\r\n"
                + "														</p>\r\n"
                + "														<p style=\"text-align:left;font-size: 22px; font-weight: bold; line-height: 22px; margin: 10px 0 0; padding: 0;\">\r\n"
                + "															পরিবার পরিকল্পনা পরিদর্শক\r\n"
                + "														</p>\r\n"
                + "													</td>\r\n"
                + "												</tr>\r\n"
                + "											</table>\r\n"
                + "	\r\n"
                + "										</td>\r\n"
                + "									</tr>\r\n"
                + "								</table>\r\n"
                + "								<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" lass=\"footer\" style=\"border-collapse: collapse;\">\r\n"
                + "									<tr>\r\n"
                + "										<td align=\"center\" class=\"footer\"\r\n"
                + "											style=\"border-collapse: collapse; padding: 30px;\">\r\n"
                + "											<i style=\"font-size: 13px; font-family: Arial, sans-serif; color: #000001; line-height: 18px; margin: 0; padding: 0;\">\r\n"
                + "												পরিবার পরিকল্পনা অধিদপ্তর, স্বাস্থ্য ও পরিবার কল্যাণ মন্ত্রণালয় \r\n"
                + "											</i>\r\n"
                + "										</td>\r\n"
                + "									</tr>\r\n"
                + "								</table>\r\n"
                + "	\r\n"
                + "							</td>\r\n"
                + "						</tr>\r\n"
                + "					</table>\r\n"
                + "				</td>\r\n"
                + "			</tr>\r\n"
                + "		</table>\r\n"
                + "	</body>\r\n"
                + "</html>	";

        System.out.println(mail);
        return mail;
    }
}
