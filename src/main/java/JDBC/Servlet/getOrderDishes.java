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
 * Created by Administrator on 2016/6/17.
 */
public class getOrderDishes extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置返回的MIME类型为xml
        resp.setContentType("text/xml");

        String sql = "SELECT orderdishes.*,orderinfo.*,dishesinfo.dishesName FROM orderdishes,orderinfo,dishesinfo WHERE orderReference=orderId AND dishes=dishesId AND cookingStatus!=2";
        Connection conn = JDBC.getConnection();
        ResultSet rs = JDBC.select(sql,conn);
        // 尝试将结果结构化为xml文档
        try {
            // 创建XML DOM树
            Document doc = DocumentBuilderFactory.newInstance()
                    .newDocumentBuilder().newDocument();
            // 创建XML根节点
            Element root = doc.createElement("orderdisheses");
            // 将根节点加入DOM树
            doc.appendChild(root);
            // 循环遍历结果集合中的用户信息
            while (rs.next()) {
                // 每一个用户创建一个用户标签
                Element orderdishes = doc.createElement("orderdishes");
                // 创建用户ID标签
                Element odId = doc.createElement("odId");
                // 设置用户ID标签文本内容
                odId.setTextContent(rs.getString("odId"));
                // 将用户ID标签设置为用户标签子标签
                orderdishes.appendChild(odId);
                // 创建用户名标签
                Element orderReference = doc.createElement("orderReference");
                // 设置用户名标签文本内容
                orderReference.setTextContent(rs.getString("orderReference"));
                // 将用户名标签设置为用户标签子标签
                orderdishes.appendChild(orderReference);
                // 创建角色id标签
                Element dishesName = doc.createElement("dishesName");
                // 设置角色id标签文本内容
                dishesName.setTextContent(rs.getString("dishesName"));
                // 将角色id标签设置为用户标签子标签
                orderdishes.appendChild(dishesName);
                // 创建角色名标签
                Element waiterId = doc.createElement("waiterId");
                // 设置角色名标签文本内容
                waiterId.setTextContent(rs.getString("waiterId"));
                // 将角色名标签设置为用户标签子标签
                orderdishes.appendChild(waiterId);
                // 创建角色锁定信息标签
                Element cookingStatus = doc.createElement("cookingStatus");
                // 设置角色锁定信息标签文本内容
                cookingStatus.setTextContent(rs.getString("cookingStatus"));
                // 将角色锁定信息标签设置为用户标签子标签
                orderdishes.appendChild(cookingStatus);
                // 创建角色头像标签
                Element num = doc.createElement("num");
                // 设置角色头像标签文本内容
                num.setTextContent(rs.getString("num"));
                // 设置头像标签为用户标签子标签
                orderdishes.appendChild(num);
                // 创建角色头像标签
                Element tableId = doc.createElement("tableId");
                // 设置角色头像标签文本内容
                tableId.setTextContent(rs.getString("tableId"));
                // 设置头像标签为用户标签子标签
                orderdishes.appendChild(tableId);
                // 设置用户标签为根标签子标签
                root.appendChild(orderdishes);
            }
            rs.close();
            conn.close();
            // 创建当前页码数的标签
            Element pageNow = doc.createElement("page");
            // 设置当前页码数标签的文本内容
            pageNow.setTextContent(1 + "");
            // 将当前页码数标签设置为根标签的子标签
            root.appendChild(pageNow);
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