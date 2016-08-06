package shiro;

import common.shiroUnilTest;
import org.apache.shiro.subject.Subject;

import java.util.Arrays;

/**
 * Created by Administrator on 2016/6/19.
 */
public class roleTest {
    public static void main(String[] args){
    }
    public void testHasRole(){
        Subject currentUser = shiroUnilTest.login("classpath:shiro.ini","大王","123");
        System.out.println(currentUser.hasRole("role1")?"有":"没有");
        boolean[]results = currentUser.hasRoles(Arrays.asList("roleTest","不要叫我大王","大王"));
        System.out.println(results[0]?"有\"roleTest\"":"没有\"roleTest\"");
        System.out.println(results[1]?"有\"不要叫我大王\"":"没有\"不要叫我大王\"");
        System.out.println(results[2]?"有\"大王\"":"没有\"大王\"");
        System.out.println(currentUser.hasAllRoles(Arrays.asList("role1","大王"))?"两个角色都有":"两个角色不全有");
        currentUser.logout();
    }

    public void testCheckRole(){
        Subject currentUser = shiroUnilTest.login("classpath:shiro.ini","大王","123");
        currentUser.checkRole("role1");
        currentUser.checkRoles(Arrays.asList("role1","大王"));
        currentUser.checkRoles("role1","大王");
        currentUser.logout();
    }

    public void testIsPermitted(){
        Subject currentUser = shiroUnilTest.login("classpath:shiro.ini","大王","123");
        System.out.println(currentUser.isPermitted("user:select")?"有":"没有");
        boolean[]results = currentUser.isPermitted("user:select","user:add","user:delete");
        System.out.println(results[0]?"有\"user:select\"":"没有\"user:select\"");
        System.out.println(results[1]?"有\"user:add\"":"没有\"user:add\"");
        System.out.println(results[2]?"有\"user:selectdelete\"":"没有\"user:delete\"");
        System.out.println(currentUser.isPermittedAll("user:select","user:add","user:delete")?"三个权限都有":"三个权限不全有");
        currentUser.logout();
    }

}
