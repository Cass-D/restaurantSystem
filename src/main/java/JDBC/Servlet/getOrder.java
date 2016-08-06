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

/**
 * Created by Administrator on 2016/6/11.
 */
public class getOrder extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置返回的MIME类型为xml
        resp.setContentType("text/xml");

        String sql = req.getParameter("sql");
        Connection conn = JDBC.getConnection();
        ResultSet rs = JDBC.select(sql,conn);
        // 尝试将结果结构化为xml文档
        try {
            // 创建XML DOM树
            Document doc = DocumentBuilderFactory.newInstance()
                    .newDocumentBuilder().newDocument();
            // 创建XML根节点
            Element root = doc.createElement("orders");
            // 将根节点加入DOM树
            doc.appendChild(root);
            // 循环遍历结果集合中的用户信息
            while (rs.next()) {
                // 每一个用户创建一个用户标签
                Element order = doc.createElement("order");
                // 创建用户ID标签
                Element orderId = doc.createElement("orderId");
                // 设置用户ID标签文本内容
                orderId.setTextContent(rs.getString("orderId"));
                // 将用户ID标签设置为用户标签子标签
                order.appendChild(orderId);
                // 创建用户名标签
                Element orderBeginDate = doc.createElement("orderBeginDate");
                // 设置用户名标签文本内容
                orderBeginDate.setTextContent(rs.getString("orderBeginDate"));
                // 将用户名标签设置为用户标签子标签
                order.appendChild(orderBeginDate);
                // 创建角色id标签
                Element orderEndDate = doc.createElement("orderEndDate");
                // 设置角色id标签文本内容
                orderEndDate.setTextContent(rs.getString("orderEndDate"));
                // 将角色id标签设置为用户标签子标签
                order.appendChild(orderEndDate);
                // 创建角色名标签
                Element waiterId = doc.createElement("waiterId");
                // 设置角色名标签文本内容
                waiterId.setTextContent(rs.getString("waiterId"));
                // 将角色名标签设置为用户标签子标签
                order.appendChild(waiterId);
                // 创建角色锁定信息标签
                Element orderState = doc.createElement("orderState");
                // 设置角色锁定信息标签文本内容
                orderState.setTextContent(rs.getString("orderState"));
                // 将角色锁定信息标签设置为用户标签子标签
                order.appendChild(orderState);
                // 创建角色头像标签
                Element sum = doc.createElement("sum");
                // 设置角色头像标签文本内容
                sum.setTextContent(rs.getString("sum"));
                // 设置头像标签为用户标签子标签
                order.appendChild(sum);
                // 创建角色头像标签
                Element tableId = doc.createElement("tableId");
                // 设置角色头像标签文本内容
                tableId.setTextContent(rs.getString("tableId"));
                // 设置头像标签为用户标签子标签
                order.appendChild(tableId);
                // 创建角色头像标签
                Element userAccount = doc.createElement("userAccount");
                // 设置角色头像标签文本内容
                userAccount.setTextContent(rs.getString("userAccount"));
                // 设置头像标签为用户标签子标签
                order.appendChild(userAccount);
                // 设置用户标签为根标签子标签
                root.appendChild(order);
            }
            rs.close();
            conn.close();
            // 创建当前页码数的标签
//            Element pageNow = doc.createElement("page");
            // 设置当前页码数标签的文本内容
//            pageNow.setTextContent(1 + "");
            // 将当前页码数标签设置为根标签的子标签
//            root.appendChild(pageNow);
//            // 创建最大页码数的标签
//            Element maxPageElement = doc.createElement("maxPage");
//            // 设置最大页码数标签的文本内容
//            maxPageElement.setTextContent(maxPage + "");
//            // 将最大页码数标签设置为根标签的子标签
//            root.appendChild(maxPageElement);
            // 将完整的DOM树转换为XML文档结构字符串输出到客户端
            TransformerFactory
                    .newInstance()
                    .newTransformer()
                    .transform(new DOMSource(doc),
                            new StreamResult(resp.getOutputStream()));
            // 捕获查询、转换过程中的异常信息
        } catch (Exception ex) {
            // 输出异常信息
            ex.printStackTrace();
        }
    }
}
