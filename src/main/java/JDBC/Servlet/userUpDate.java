package JDBC.Servlet;

import JDBC.JDBC;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/6/6.
 */
public class userUpDate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        String userPass = req.getParameter("userPass").toString();
        int roleId =Integer.parseInt(req.getParameter("roleId"));
        String faceImg = req.getParameter("faceimg");
        String sql =String.format("UPDATE userinfo SET userPass='%s',roleId=%d,faceimg='%s' WHERE userId=%d",userPass,roleId,faceImg,userId);
        JDBC.upDate(sql);
        resp.sendRedirect("/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        String userPass = req.getParameter("userPass").toString();
        int roleId =Integer.parseInt(req.getParameter("roleId"));
        String faceImg = req.getParameter("faceimg");
        String sql =String.format("UPDATE userinfo SET userPass='%s',roleId=%d,faceimg='%s' WHERE userId=%d",userPass,roleId,faceImg,userId);
        JDBC.upDate(sql);
        req.getRequestDispatcher("adminUser.jsp").forward(req, resp);
    }
}
