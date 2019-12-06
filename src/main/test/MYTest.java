import cn.zhen.mapper.sys.RoleMapper;
import cn.zhen.model.sys.Role;
import cn.zhen.model.sys.User;
import cn.zhen.utiles.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.core.RedisOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.SessionCallback;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.JedisSentinelPool;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class MYTest {

    /*
        本地开启redis哨兵模式
     ./redis-server  ../master-6379.conf
     ./redis-server  ../slave.6380.conf
     ./redis-server  ../slave.6381.conf

     ./redis-sentinel ../sentinel.63791.conf
     ./redis-sentinel ../sentinel.63801.conf
     ./redis-sentinel ../sentinel.63811.conf
     */

    @org.junit.Test
    public  void testSentinel() {
        // 连接池配置
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        jedisPoolConfig.setMaxTotal(10);
        jedisPoolConfig.setMaxIdle(5);
        jedisPoolConfig.setMinIdle(5);
        // 哨兵信息
        Set<String> sentinels = new HashSet<String>(
                Arrays.asList("127.0.0.1:63791", "127.0.0.1:63801", "127.0.0.1:63811"));
        // 创建连接池
        JedisSentinelPool pool = new JedisSentinelPool("mymaster", sentinels, jedisPoolConfig, "grs");
        // 获取客户端
        Jedis jedis = pool.getResource();

        // 执行两个命令
        jedis.set("mykey", "myvalue");
        String myvalue = jedis.get("mykey");
        // 打印信息
        System.out.println(myvalue);
    }

    //xml 配置方式测试哨兵模式
    @Test
    public void testSpringSentinel() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("redis.xml");
        RedisTemplate redisTemplate = ctx.getBean(RedisTemplate.class);

        final User user = new User();
        user.setUserId(1);
        user.setUsername("xiaoming");

        SessionCallback callback = new SessionCallback<User>() {
            @Override
            public User execute(RedisOperations ops) throws DataAccessException {
                ops.boundValueOps("user_1").set(user);
                return (User) ops.boundValueOps("user_1").get();
            }
        };

        User user1 = (User) redisTemplate.execute(callback);
        System.out.println(user1);
    }

    // 测试redis事务
    @Test
    public void testRedisTx(){
        ApplicationContext ctx = new ClassPathXmlApplicationContext("redis.xml");
        RedisTemplate redisTemplate = ctx.getBean(RedisTemplate.class);

        SessionCallback callback = new SessionCallback() {
            @Override
            public Object execute(RedisOperations ops) throws DataAccessException {
                //ops.watch("xxx");
                ops.multi();

                ops.boundValueOps("test-tx-key1").set("tx-value-1");
                ops.boundValueOps("test-tx-key2").set("tx-value-2");

                ops.boundValueOps("test-tx-key1").get();
                ops.boundValueOps("test-tx-key2").get();

                return ops.exec();
            }
        };

        System.out.println(redisTemplate.execute(callback));
    }

    // 测试redis管道和性能
    @Test
    public void testRedisPipeline(){
        ApplicationContext ctx = new ClassPathXmlApplicationContext("redis.xml");
        RedisTemplate redisTemplate = ctx.getBean(RedisTemplate.class);

        SessionCallback callback = new SessionCallback() {
            @Override
            public Object execute(RedisOperations ops) throws DataAccessException {

                for (int i = 0; i < 100000; i++) {
                    int j = i + 1;
                    ops.boundValueOps("pipeline_key_" + j).set("pipeline_value_" + j);
                    ops.boundValueOps("pipeline_key_" + j).get();
                }
                return null;
            }
        };

        long start = System.currentTimeMillis();
        // 执行Redis的流水线命令
        List resultList = redisTemplate.executePipelined(callback);
        long end = System.currentTimeMillis();
        System.err.println(end - start);
    }

    // 测试redis监听器
    @Test
    public void TestRedisListener()
    {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("redis.xml");
        RedisTemplate redisTemplate = applicationContext.getBean(RedisTemplate.class);

        String channel = "chat";
        redisTemplate.convertAndSend(channel, "222222222222222222222");
    }

    //DAO 测试
    @org.junit.Test
    public void test5(){
        Logger log = Logger.getLogger(MYTest.class);
        SqlSession sqlSession = null;
        try {
            sqlSession = SqlSessionFactoryUtils.openSqlSession();
            RoleMapper roleMapper = sqlSession.getMapper(RoleMapper.class);
            Role role = roleMapper.getRowByID(1);
            log.info(role.getRoleName());
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }
}
