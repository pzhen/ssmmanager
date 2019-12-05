package cn.zhen.service.sys;


import cn.zhen.model.sys.Role;
import cn.zhen.service.base.IBaseService;

public interface IRoleService extends IBaseService <Role>{
    public Role getRowByID(Integer ID);
}
