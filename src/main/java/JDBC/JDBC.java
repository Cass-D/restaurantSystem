package JDBC;

import java.sql.*;

/**
 * Created by Administrator on 2016/6/2.
 */


//数据库插入操作类
public class JDBC {

    //获取数据库连接对象方法
    public  static Connection getConnection(){
        Connection conn = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ordersys","root","x5");
        }catch(Exception e){
            e.printStackTrace();
        }
        return conn;
    }

    //'dishNews'表数据插入方法
    public static void dishNews(int waiterId,String content){
        Connection conn = getConnection();
        String sql ="INSERT INTO dishnews(waiterId,content)"+
                String.format("VALUES(%d,'%s')",waiterId,content);
        try{
            Statement st = conn.createStatement();
            st.executeUpdate(sql);
            conn.close();
            st.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //'news'表数据插入方法
    public static void news(String content){
        Connection conn = getConnection();
        String sql ="INSERT INTO news(content)"+
                String.format("VALUES('%s')",content);
        try{
            Statement st = conn.createStatement();
            st.executeUpdate(sql);
            conn.close();
            st.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //'userinfo'表数据插入方法
    public static void userinfo(String userAccount,String userPass,int role,String faceimg){
        Connection conn = getConnection();
        String sql ="INSERT INTO userinfo(userAccount,userPass,roleId,faceimg)"+
                String.format("VALUES('%s','%s','%d','%s')",userAccount,userPass,role,faceimg);
        try{
            Statement st = conn.createStatement();
//            int count;
            st.executeUpdate(sql);
//            System.out.print(count);
            conn.close();
            st.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //'dishesinfo'表数据插入方法
    public static void dishesinfo(String dishesName,String dishesDiscript,String dishesTxt,int recommend,float dishesPrice,String dishesImg,String dishesType){
        Connection conn = getConnection();
        String sql ="INSERT INTO dishesinfo(dishesName,dishesDiscript,dishesTxt,recommend,dishesPrice,dishesImg,dishesType)"+
                String.format("VALUES('%s','%s','%s','%d','%f','%s','%s')",dishesName,dishesDiscript,dishesTxt,recommend,dishesPrice,dishesImg,dishesType);
        try{
            Statement st = conn.createStatement();
            int count;
            st.executeUpdate(sql);
//            System.out.print(count);
            conn.close();
            st.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //'orderinfo'表数据插入方法
    public static void orderinfo(int waiterId,int tableId){
        Connection conn = getConnection();
        String sql ="INSERT INTO orderinfo(waiterId,tableId)"+
                String.format("VALUES('%d','%d')",waiterId,tableId);
        try{
            Statement st = conn.createStatement();
            st.executeUpdate(sql);
            conn.close();
            st.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //'orderdishes'表数据插入方法
    public static void orderdishes(int orderReference,int dishes,int num){
        Connection conn = getConnection();
        String sql ="INSERT INTO orderdishes(orderReference,dishes,num)"+
                String.format("VALUES('%d','%d','%d')",orderReference,dishes,num);
        try{
            Statement st = conn.createStatement();
            st.executeUpdate(sql);
            //int count = st.executeUpdate(sql);
            //System.out.print("count="+count);
            conn.close();
            st.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //数据库查询操作方法
    public static ResultSet select(String sql,Connection conn){

        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
        }catch (Exception e){
            e.printStackTrace();
        }

        return rs;
    }

    //数据修改操作方法
    public static void upDate(String sql){

        Connection conn = getConnection();
        Statement st = null;
        try {
            st = conn.createStatement();
            st.executeUpdate(sql);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try {
                conn.close();
                st.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
