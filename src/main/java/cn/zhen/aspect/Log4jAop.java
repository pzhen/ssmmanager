package cn.zhen.aspect;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;

public class Log4jAop {
    private static final Logger logger = Logger.getLogger(Log4jAop.class);

    public Object around(ProceedingJoinPoint pj) {
        String str = "执行 Class --> " + pj.getTarget().getClass().getName() + " Method --> " + pj.getSignature().getName() + " took ";
        Long start = System.currentTimeMillis();
        try {
            Object res = pj.proceed();
            Long end = System.currentTimeMillis();

            logger.info(str + (end - start) + " ms");
            return res;
        } catch (Throwable e) {
            throw new RuntimeException(e);
        }
    }
}
