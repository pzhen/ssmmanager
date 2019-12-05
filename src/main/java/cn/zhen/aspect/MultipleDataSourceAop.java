package cn.zhen.aspect;

import cn.zhen.utiles.DataSource;
import cn.zhen.utiles.DynamicDataSource;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.reflect.MethodSignature;

import java.lang.reflect.Method;

public class MultipleDataSourceAop {
    private final Logger logger = Logger.getLogger(MultipleDataSourceAop.class);

    public void before(JoinPoint joinPoint) {
        try {
            Class<?> clazz = joinPoint.getTarget().getClass();
            MethodSignature signature = (MethodSignature)joinPoint.getSignature();
            Method method = signature.getMethod();
            // service
            Class<?>[] types = method.getParameterTypes();
            if (clazz.isAnnotationPresent(DataSource.class)) {
                DataSource source = clazz.getAnnotation(DataSource.class);
                DynamicDataSource.setDataSource(source.value());
                logger.info("切换数据源 Class --> " + clazz.getName() + " dataSource " + source.value());
            }

            Method m = clazz.getMethod(method.getName(), types);
            if (m != null && m.isAnnotationPresent(DataSource.class)) {
                DataSource source = m.getAnnotation(DataSource.class);
                DynamicDataSource.setDataSource(source.value());
                logger.info("切换数据源 Class --> " + clazz.getName() + " --> Method " + m.getName() + " dataSource " + source.value());
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void afterReturning() {
        try {
            DynamicDataSource.clearDataSource();
            logger.debug("dataSource clear ...");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
