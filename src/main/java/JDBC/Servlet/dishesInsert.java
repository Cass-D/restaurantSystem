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
public class dishesInsert extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String dishesName = req.getParameter("dishesName");
        String dishesDiscript = req.getParameter("dishesDiscript");
        String dishesTxt = req.getParameter("dishesTxt");
        String dishesType = req.getParameter("type");
        int recommend;
        try {
            recommend = Integer.parseInt(req.getParameterValues("recommend")[0]);
        }catch (NullPointerException e)
        {
            recommend = 0;
        }
        float dishesPrice = Float.parseFloat(req.getParameter("dishesPrice"));
        String dishesImg = req.getParameter("dishesImg");
        JDBC.dishesinfo(dishesName,dishesDiscript,dishesTxt,recommend,dishesPrice,dishesImg,dishesType);
        req.getRequestDispatcher("adminDishes.jsp").forward(req, resp);
    }
}
