package JDBC.Servlet;

import JDBC.JDBC;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/6/9.
 */
public class userStatus extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sql;
        int locked=Integer.parseInt(req.getParameter("locked"));
        int id=Integer.parseInt(req.getParameter("id"));
        sql=String.format("UPDATE userinfo SET locked=%d WHERE userId=%d",locked,id);
        JDBC.upDate(sql);
    }
}
