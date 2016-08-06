package JDBC.Servlet;

import JDBC.JDBC;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2016/6/20.
 */
public class checkOut extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int sum = 0;
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String selectSql = "SELECT orderdishes.num,dishesinfo.dishesPrice FROM orderdishes,dishesinfo WHERE orderdishes.dishes=dishesinfo.dishesId AND orderReference="+orderId;
        Connection conn = JDBC.getConnection();
        ResultSet selectRs = JDBC.select(selectSql,conn);
        try{
            while (selectRs.next()){
                sum += selectRs.getInt("dishesPrice") * selectRs.getInt("num");
            }
            selectRs.close();
            conn.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String date = df.format(new Date());// new Date()为获取当前系统时间
        String updateSql = "UPDATE orderinfo SET orderEndDate='"+date+"',sum="+sum+",orderState=1 WHERE orderId="+orderId;
        JDBC.upDate(updateSql);
    }
}