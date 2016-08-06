package realm;

import DAO.userDAO;
import JDBC.JDBC;
import entity.user;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by Administrator on 2016/6/21.
 */
public class MyRealm extends AuthorizingRealm {

    private userDAO userDao = new userDAO();

    //为当前登录的用户授予角色和权限
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        String userAccount = (String) principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        Connection con = null;
        try {
            con = JDBC.getConnection();
            authorizationInfo.setRoles(userDao.getRoles(con,userAccount));
            authorizationInfo.setStringPermissions(userDao.getPermissions(con,userAccount));
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return authorizationInfo;
    }

    //验证当前登陆的用户
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String userAccount = (String)token.getPrincipal();
        Connection con = null;
        con = JDBC.getConnection();
        try {
            user user = userDao.getByUserAccount(con,userAccount);
            if (user!=null){
                AuthenticationInfo authInfo = new SimpleAuthenticationInfo(user.getUserAccount(),user.getUserPass(),"xx");
                return authInfo;
            }else {
                return null;
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try {
                con.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return null;
    }
}
