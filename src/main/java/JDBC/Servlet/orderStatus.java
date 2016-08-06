package JDBC.Servlet;

import JDBC.JDBC;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/6/12.
 */
public class orderStatus extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("id"));
        int orderState = Integer.parseInt(req.getParameter("orderState"));
        String sql = String.format("UPDATE orderinfo SET orderState=%d WHERE orderId=%d",orderState,orderId);
        JDBC.upDate(sql);
        //resp.getWriter().println(sql);
    }
}
