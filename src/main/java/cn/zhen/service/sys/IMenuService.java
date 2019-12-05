package cn.zhen.service.sys;


import cn.zhen.model.sys.Menu;
import cn.zhen.service.base.IBaseService;

import java.util.TreeSet;

public interface IMenuService extends IBaseService<Menu> {
    public TreeSet<Menu> getListByRoleIDs (String rIds);
}
