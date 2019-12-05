//import cn.zhen.aspect.RoleVerifier;
//import cn.zhen.aspect.TestRole;
//import cn.zhen.aspect.TestRoleImpl;
//import cn.zhen.model.sys.RoleModel;
//
//import org.junit.Test;
//import org.springframework.context.ApplicationContext;
//import org.springframework.context.annotation.AnnotationConfigApplicationContext;
//
//public class TestAspect {
//    @Test
//    public void test1(){
//
//        ApplicationContext ctx = new AnnotationConfigApplicationContext(cn.zhen.aspect.AopConfig.class);
//
//        TestRole roleService = (TestRole) ctx.getBean("testRoleImpl");
//        RoleVerifier roleVerifier = (RoleVerifier) ctx.getBean("testRoleImpl");
//
//        RoleModel  r = new RoleModel();
//        r.setRoleID(1);
//        r.setRoleName("hello world....");
//
//        //roleService.printRole(r);
//        RoleModel r2 = null;
//
//        if (roleVerifier.verify(r2)){
//            roleService.printRole(r2);
//        }
//
//
//    }
//}
