package JDBC.Servlet;

import JDBC.JDBC;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Administrator on 2016/6/24.
 */
public class checkDishes extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String check = null;
        String dishesName = new String(req.getParameter("dishesName").getBytes("ISO-8859-1"),"UTF-8");
        String sql = "select dishesinfo.dishesName from dishesinfo where dishesName='"+dishesName+"'";
        Connection conn = JDBC.getConnection();
        ResultSet rs = JDBC.select(sql,conn);
        try{
            if (rs.next()){
                check = "true";
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try {
                conn.close();
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        resp.getWriter().write(check);
    }
}