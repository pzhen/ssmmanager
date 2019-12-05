package cn.zhen.utiles;

import java.lang.annotation.*;


@Documented
@Target({ElementType.TYPE,ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface DataSource {
    String value();
    String slave  = "slave";
    String master = "master";
}
