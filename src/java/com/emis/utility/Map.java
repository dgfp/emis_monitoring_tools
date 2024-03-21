
package com.emis.utility;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal
 */
@WebServlet(name = "Map", urlPatterns = {"/map"})
public class Map extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
//        ArrayList<Integer> arr = new ArrayList<Integer>();
//        int a[] = { 20001,30001,40001};
//        int j = a[0];
//        for (int i=0;i<a.length;i++)
//        {
//            if (j==a[i])
//            {
//                j+=10000;
//                continue;
//            }
//            else
//            {
//                arr.add(j);
//                i--;
//                j+=10000;
//            }
//        }
//        
//        
//        response.getWriter().print("missing numbers are :");
//        for(int r : arr)
//        {
//            //System.out.println(" " + r);
//            response.getWriter().print(" " + r+", ");
//        }
        
        
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/utility/mapNID.jsp");
            view.forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
