import cn.zhen.mapper.sys.RoleMapper;
import cn.zhen.model.sys.Role;
import cn.zhen.utiles.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.JedisSentinelPool;

import java.util.Arrays;
import java.util.HashSet;
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
