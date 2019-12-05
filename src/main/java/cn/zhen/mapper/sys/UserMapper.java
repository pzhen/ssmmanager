package cn.zhen.mapper.sys;

import cn.zhen.mapper.base.BaseMapper;
import cn.zhen.model.sys.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface UserMapper extends BaseMapper<User>{
    public User getRowByName(String name);
    public List<User> getListByPage(@Param("username") String name,
                                    @Param("start") int start,
                                    @Param("offset") int offset,
                                    @Param("order") String order);

    public int getListByPageTotal(@Param("username") String name);
    public int insert(User user);
    public int update(User user);
}
