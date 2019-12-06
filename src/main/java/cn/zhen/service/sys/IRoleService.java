package cn.zhen.service.sys;


import cn.zhen.model.sys.Role;
import cn.zhen.service.base.IBaseService;

import java.util.List;

public interface IRoleService extends IBaseService <Role>{
    public Role getRowByID(Integer ID);
    public List<Role> getListByIds(String ids);
    public List<Role> getListByAll();
}
