package cn.zhen.mapper.sys;

import cn.zhen.mapper.base.BaseMapper;
import cn.zhen.model.sys.Role;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface RoleMapper extends BaseMapper<Role>{
    public List<Role> getListByAll();
}
