package cn.zhen.listener;

import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.core.RedisTemplate;

public class RedisMessageListener implements MessageListener {

    private RedisTemplate redisTemplate;

    public RedisTemplate getRedisTemplate() {
        return redisTemplate;
    }

    public void setRedisTemplate(RedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    public void onMessage(Message message, byte[] bytes) {
        // 获取消息
        byte[] body = message.getBody();

        // 获取channel
        byte[] channel = message.getChannel();

        // 使用字符串序列化器转换
        String channelStr = (String) getRedisTemplate().getStringSerializer().deserialize(channel);
        System.out.println("channelStr:" + channelStr);

        if (channelStr.equals("__keyevent@0__:expired")) {
            String expireKey = new String(body);
            System.out.println("过期消息Key: " + expireKey);
        }

        if (channelStr.equals("chat")) {
            String msgBody = (String) getRedisTemplate().getValueSerializer().deserialize(body);
            System.out.println("订阅消息:"+msgBody);
        }
    }
}
