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
public class sendDishNews extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int waiterId = Integer.parseInt(req.getParameter("waiterId"));
        String content = new String(req.getParameter("content").getBytes("ISO-8859-1"), "UTF-8");
        JDBC.dishNews(waiterId,content);
    }
}
