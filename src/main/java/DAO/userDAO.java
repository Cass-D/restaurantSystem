package DAO;

import entity.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Administrator on 2016/6/21.
 */
public class userDAO {
    public user getByUserAccount(Connection con, String userAccount)throws Exception{
        user resultUser = null;
        String sql = "select * from userinfo where userAccount=?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1,userAccount);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()){
            resultUser = new user();
            resultUser.setUserId(rs.getInt("userId"));
            resultUser.setUserAccount(rs.getString("userAccount"));
            resultUser.setUserPass(rs.getString("userPass"));
        }
        return resultUser;
    }

    public Set<String> getRoles(Connection con, String userAccount) throws Exception {
        Set<String> roles = new HashSet<String>();
        String sql = "select roleinfo.* from userinfo,roleinfo where userinfo.roleId=roleinfo.roleId and userAccount='"+userAccount+"'";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()){
            roles.add(rs.getString("roleName"));
        }
        return roles;
    }

    public Set<String> getPermissions(Connection con, String userAccount) throws SQLException {
        Set<String> permissions = new HashSet<String>();
        String sql = "select * from userinfo,roleinfo,permissioninfo where userinfo.roleId=roleinfo.roleId and roleinfo.roleId=permissioninfo.roleId and userAccount='"+userAccount+"'";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()){
            permissions.add(rs.getString("permissionName"));
        }
        return permissions;
    }
}
