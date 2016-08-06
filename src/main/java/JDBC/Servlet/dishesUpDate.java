package JDBC.Servlet;

import JDBC.JDBC;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/6/10.
 */
public class dishesUpDate extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");

        int dishesId = Integer.parseInt(req.getParameter("dishesId"));
        String dishesName = req.getParameter("dishesName");
        String dishesDiscript = req.getParameter("dishesDiscript");
        String dishesTxt = req.getParameter("dishesTxt");
        String type = req.getParameter("type");
        int recommend;
        try {
            recommend = Integer.parseInt(req.getParameterValues("recommend")[0]);
        }catch (NullPointerException e)
        {
            recommend = 0;
        }
        Float dishesPrice = Float.parseFloat(req.getParameter("dishesPrice"));
        String dishesImg = req.getParameter("dishesImg");
        String sql = String.format("UPDATE dishesinfo SET dishesName='%s',dishesDiscript='%s',dishesTxt='%s',recommend=%d,dishesPrice=%f,dishesImg='%s',dishesType='%s' WHERE dishesId=%d",dishesName,dishesDiscript,dishesTxt,recommend,dishesPrice,dishesImg,type,dishesId);
        JDBC.upDate(sql);
        req.getRequestDispatcher("adminDishes.jsp").forward(req, resp);
    }
}
