package JDBC.Servlet;

import JDBC.JDBC;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 * Created by Administrator on 2016/6/22.
 */
public class login extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("errorInfo","你没有权限访问该页面");
        req.getRequestDispatcher("/login.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String userAccount = req.getParameter("username");
        String userPass = req.getParameter("password");
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(userAccount,userPass);
        try {
            subject.login(token);
            req.setAttribute("errorInfo","");
            Connection con = JDBC.getConnection();
            String sql = "select * from userinfo,roleinfo where userinfo.roleId=roleinfo.roleId and userAccount='"+userAccount+"'";
            ResultSet rs = JDBC.select(sql,con);
            rs.next();

            Session session = subject.getSession();
            session.setAttribute("userId",rs.getInt("userId"));
            session.setAttribute("userAccount",rs.getString("userAccount"));
            session.setAttribute("userPass",rs.getString("userPass"));
            session.setAttribute("faceimg",rs.getString("faceimg"));
            session.setAttribute("roleId",rs.getInt("roleId"));

            if (rs.getString("roleName").equals("后厨") ){
                resp.sendRedirect("/kitchen/kitchen.jsp");
            }else if (rs.getString("roleName").equals("点餐员")){
                resp.sendRedirect("/waiter/waiterMain.jsp");
            }else {
                resp.sendRedirect("/adminMain.jsp");
            }
            rs.close();
            con.close();
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("errorInfo","用户名或密码错误");
            req.getRequestDispatcher("/login.jsp").forward(req,resp);
        }
    }
}
