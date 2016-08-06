package JDBC.Servlet;

import JDBC.JDBC;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/6/11.
 */
public class dishesStatus extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sql;
        int shelvesed=Integer.parseInt(req.getParameter("shelvesed"));
        int id=Integer.parseInt(req.getParameter("id"));
        sql=String.format("UPDATE dishesinfo SET shelvesed=%d WHERE dishesId=%d",shelvesed,id);
        JDBC.upDate(sql);
    }
}
