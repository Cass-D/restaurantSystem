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
 * Created by Administrator on 2016/6/16.
 */
public class getDishes extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置返回的MIME类型为xml
        resp.setContentType("text/xml");

        String type = new String(req.getParameter("dishesType").getBytes("ISO-8859-1"),"UTF-8");
        String sql = "SELECT dishesinfo.* FROM dishesinfo WHERE shelvesed=1 AND dishesType='"+type+"'";
        Connection conn = JDBC.getConnection();
        ResultSet rs = JDBC.select(sql,conn);
        // 尝试将结果结构化为xml文档
        try {
            // 创建XML DOM树 65
            Document doc = DocumentBuilderFactory.newInstance()
                    .newDocumentBuilder().newDocument();
            // 创建XML根节点
            Element root = doc.createElement("disheses");
            // 将根节点加入DOM树
            doc.appendChild(root);
            // 循环遍历结果集合中的用户信息
            while (rs.next()) {
                // 每一个菜品构建一个dishes标签节点
                Element dishes = doc.createElement("dishes");
                // 创建菜品ID标签
                Element dishesId = doc.createElement("dishesId");
                // 设置菜品ID标签的文本内容
                dishesId.setTextContent(rs.getString("dishesId"));
                // 将菜品ID标签设置为菜品标签子标签
                dishes.appendChild(dishesId);
                // 创建菜品名标签
                Element dishesName = doc.createElement("dishesName");
                // 设置菜品名标签的文本内容
                dishesName.setTextContent(rs.getString("dishesName"));
                // 将菜品名标签设置为菜品标签的子标签
                dishes.appendChild(dishesName);
                // 创建菜品名标签
                Element dishesType = doc.createElement("dishesType");
                // 设置菜品名标签的文本内容
                dishesType.setTextContent(rs.getString("dishesType"));
                // 将菜品名标签设置为菜品标签的子标签
                dishes.appendChild(dishesType);
                // 创建菜品描述标签
                Element dishesDiscript = doc.createElement("dishesDiscript");
                // 设置菜品描述标签文本内容
                dishesDiscript.setTextContent(rs.getString("dishesDiscript"));
                // 将菜品描述标签设置为菜品标签子标签
                dishes.appendChild(dishesDiscript);
                // 创建菜品图片标签
                Element dishesImg = doc.createElement("dishesImg");
                // 设置菜品图片标签的文本内容
                dishesImg.setTextContent(rs.getString("dishesImg"));
                // 将菜品图片标签设置为菜品标签的子标签
                dishes.appendChild(dishesImg);
                // 创建菜品详细文本标签
                Element dishesTxt = doc.createElement("dishesTxt");
                // 获取菜品详细文字描述
                String txt = rs.getString("dishesTxt");
                // 将空格替换为特殊分隔符
                txt = txt.replaceAll(" ", "ordersysspace");
                // 将\r替换为空字符串
                txt = txt.replaceAll("\r", "");
                // 将换行替换为特殊分隔符
                txt = txt.replaceAll("\n", "ordersysbreak");
                // 将双引号替换为转移字符
                txt = txt.replaceAll("\"", "\\\\\"");
                // 将单引号替换为转移字符
                txt = txt.replaceAll("\'", "\\\\\'");
                // 设置菜品详细文本标签的文本内容
                dishesTxt.setTextContent(txt);
                // 将菜品详细文本标签设置为菜品标签的子标签
                dishes.appendChild(dishesTxt);
                // 创建是否推荐子标签
                Element recommend = doc.createElement("recommend");
                // 设置是否推荐菜品标签文本内容
                recommend.setTextContent(rs.getString("recommend"));
                // 将是否推荐菜品标签设置为菜品标签的子标签
                dishes.appendChild(recommend);
                // 创建菜品价格标签
                Element dishesPrice = doc.createElement("dishesPrice");
                // 设置菜品价格标签文本内容
                dishesPrice.setTextContent(rs.getString("dishesPrice"));
                // 将菜品价格标签设置为菜品标签子标签
                dishes.appendChild(dishesPrice);
                // 将菜品标签设置为根标签的子标签
                root.appendChild(dishes);
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
