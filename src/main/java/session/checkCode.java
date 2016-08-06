package session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/6/23.
 */
public class checkCode extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String check = null;
        String code = req.getSession().getAttribute("code").toString();
        String checkCode = req.getParameter("checkCode");
        checkCode = checkCode.toUpperCase();
        if (checkCode.equals(code)){
            check = "true";
        }else{
            check = "false";
        }
        resp.getWriter().write(check);
    }
}
