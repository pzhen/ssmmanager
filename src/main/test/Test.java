import cn.zhen.model.sys.Menu;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Comparator;
import java.util.TreeSet;





interface Person {
    public void buy();
    public void buy1();
}

class XiaoQiang implements Person {
    private String name;
    private String house;

    public XiaoQiang(String name, String house) {
        this.name = name;
        this.house = house;
    }

    @Override
    public void buy() {
        System.out.println(name+"买了"+house);
    }

    @Override
    public void buy1() {
        System.out.println("我是你爸爸");
    }
}

class ProxySaler implements InvocationHandler {

    public Object person;

    public Object newInstall(Object person)
    {
        this.person=person;
        return  Proxy.newProxyInstance(person.getClass().getClassLoader(),person.getClass().getInterfaces(),this);
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        return method.invoke(person,args);
    }
}





public class Test {


    @org.junit.Test
    public void test2()
    {
        ProxySaler proxySaler=new ProxySaler();
        Person object= (Person) proxySaler.newInstall(new XiaoQiang("黄豪强","南山区"));
        object.buy1();
        object.buy();
    }

    @org.junit.Test
    public void test4(){

        Long a = System.currentTimeMillis()/1000;

        System.out.println(a);

    }



    @org.junit.Test
    public void test1(){

        Menu menu1 = new Menu();
        menu1.setMenuPath(1);

        Menu menu2 = new Menu();
        menu2.setMenuPath(2);

        Menu menu3 = new Menu();
        menu3.setMenuPath(3);

        Menu menu4 = new Menu();
        menu4.setMenuPath(3);

        TreeSet<Menu> set = new TreeSet<Menu>(new Comparator<Menu>() {
            @Override
            public int compare(Menu o1, Menu o2) {
                if (o1.getMenuPath() > o2.getMenuPath()) {
                    return 1;
                }else if (o1.getMenuPath() < o2.getMenuPath()) {
                    return -1;
                }else {
                    return 0;
                }
            }
        });
        set.add(menu1);
        set.add(menu2);
        set.add(menu3);
        set.add(menu4);
        System.out.println(set);
    }


    @org.junit.Test
    public void test3(){

    }
}
