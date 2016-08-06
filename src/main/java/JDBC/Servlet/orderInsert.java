package JDBC.Servlet;

import JDBC.JDBC;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/6/15.
 */
public class orderInsert extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int waiterId =Integer.parseInt(req.getParameter("waiterId"));
        int tableId =Integer.parseInt(req.getParameter("tableId"));
        JDBC.orderinfo(waiterId,tableId);
    }
}
