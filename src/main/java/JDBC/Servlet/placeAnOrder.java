package JDBC.Servlet;

import JDBC.JDBC;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/6/17.
 */
public class placeAnOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        int i = Integer.parseInt(req.getParameter("i"));
//        int orderId = Integer.parseInt(req.getParameter("orderId"));
////        System.out.println("i="+i);
//        for (int j=0;j<(i/4);j++){
//            if (req.getParameter(j*4+"")==null){
//                continue;
//            }
////            System.out.print("id="+req.getParameter(j*4+"")+"  ");
////            System.out.print("num="+req.getParameter(j*4+2+"")+"  ");
////            System.out.println();
//            int dishes = Integer.parseInt(req.getParameter(j*4+""));
//            int num = Integer.parseInt(req.getParameter(j*4+2+""));
//            JDBC.orderdishes(orderId,dishes,num);
//        }
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        if (req.getParameterValues("id") == null){
            req.getRequestDispatcher("/waiter/waiterMain.jsp").forward(req, resp);
        }
        String id[] = req.getParameterValues("id");
        int dishes[] = new int[id.length];
        String number[] = req.getParameterValues("number");
        int num[] = new int[number.length];
        for (int i=0;i<id.length;i++){
            dishes[i] = Integer.parseInt(id[i]);
            num[i] = Integer.parseInt(number[i]);
            if (num[i] == 0){
                continue;
            }
            JDBC.orderdishes(orderId,dishes[i],num[i]);
        }
        req.getRequestDispatcher("/waiter/waiterMain.jsp").forward(req, resp);
    }
}
