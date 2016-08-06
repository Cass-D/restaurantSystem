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
public class setCookingStatus extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int odId = Integer.parseInt(req.getParameter("odId"));
        int cookingStatus = Integer.parseInt(req.getParameter("cookingStatus"));
        String sql = String.format("UPDATE orderdishes SET cookingStatus=%d WHERE odId=%d",cookingStatus,odId);
        JDBC.upDate(sql);
    }
}
