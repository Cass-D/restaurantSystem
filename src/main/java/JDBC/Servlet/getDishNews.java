package JDBC.Servlet;

import JDBC.JDBC;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by Administrator on 2016/6/17.
 */
public class getDishNews extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置返回的MIME类型为xml
        resp.setContentType("text/xml");

        int waiterId = Integer.parseInt(req.getParameter("waiterId"));
        String sql = "SELECT dishnews.* FROM dishnews WHERE waiterId='"+waiterId+"' ORDER BY dateTime DESC LIMIT 3";
        Connection conn = JDBC.getConnection();
        ResultSet rs = JDBC.select(sql,conn);
        // 尝试将结果结构化为xml文档
        try {
            // 创建XML DOM树
            Document doc = DocumentBuilderFactory.newInstance()
                    .newDocumentBuilder().newDocument();
            // 创建XML根节点
            Element root = doc.createElement("dishNews");
            // 将根节点加入DOM树
            doc.appendChild(root);
            // 循环遍历结果集合中的用户信息
            while (rs.next()) {
                // 每一个用户创建一个用户标签
                Element dishNew = doc.createElement("dishNew");
                // 创建用户ID标签
                Element dateTime = doc.createElement("dateTime");
                // 设置用户ID标签文本内容
                dateTime.setTextContent(rs.getString("dateTime"));
                // 将用户ID标签设置为用户标签子标签
                dishNew.appendChild(dateTime);
                // 创建用户名标签
                Element content = doc.createElement("content");
                // 设置用户名标签文本内容
                content.setTextContent(rs.getString("content"));
                // 将用户名标签设置为用户标签子标签
                dishNew.appendChild(content);
                // 设置用户标签为根标签子标签
                root.appendChild(dishNew);
            }

            TransformerFactory
                    .newInstance()
                    .newTransformer()
                    .transform(new DOMSource(doc),
                            new StreamResult(resp.getOutputStream()));
            // 捕获查询、转换过程中的异常信息
        } catch (Exception ex) {
            // 输出异常信息
            ex.printStackTrace();
        }finally {
            try {
                rs.close();
                conn.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }
}