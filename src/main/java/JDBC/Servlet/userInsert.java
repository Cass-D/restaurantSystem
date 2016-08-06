package JDBC.Servlet;

import JDBC.JDBC;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/6/5.
 */
public class userInsert extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String userAccount = req.getParameter("userAccount");
        String userPass = req.getParameter("userPass");
        int roleId =Integer.parseInt(req.getParameter("roleId"));
        String faceimg =req.getParameter("faceimg");
        JDBC.userinfo(userAccount,userPass,roleId,faceimg);
        req.getRequestDispatcher("adminUser.jsp").forward(req, resp);
    }
}
