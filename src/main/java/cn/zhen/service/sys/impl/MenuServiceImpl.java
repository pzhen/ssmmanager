package cn.zhen.service.sys.impl;

import cn.zhen.mapper.sys.MenuMapper;
import cn.zhen.mapper.sys.RoleMapper;
import cn.zhen.model.sys.Menu;
import cn.zhen.model.sys.Role;
import cn.zhen.service.base.impl.BaseServiceImpl;
import cn.zhen.service.sys.IMenuService;
import cn.zhen.utiles.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class MenuServiceImpl extends BaseServiceImpl<Menu> implements IMenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Autowired
    private RoleMapper roleMapper;

    /**
     * 获取角色对应菜单
     * @param rIds
     * @return
     */
    @DataSource(DataSource.slave)
    @Override
    public TreeSet<Menu> getListByRoleIDs(String rIds) {
        if (rIds == null || "".equals(rIds)) {
            return null;
        }

        String[] rIdA = rIds.split(",");
        List<Role> roleList = roleMapper.getListByIDArr(Arrays.asList(rIdA));

        if (roleList == null) {
            return null;
        }

        TreeSet<Menu> menuSet = new TreeSet<Menu>(new Comparator<Menu>() {
            @Override
            public int compare(Menu o1, Menu o2) {
                if (o1.getMenuPath() > o2.getMenuPath()) {
                    return 1;
                } else if (o1.getMenuPath() < o2.getMenuPath()) {
                    return -1;
                } else {
                    return 0;
                }
            }
        });

        for (Role role : roleList) {
            String mIds = role.getRoleMenus();
            if (mIds != null && !"".equals(mIds)) {
                List<Menu> mList = menuMapper.getListByIDArr(Arrays.asList(mIds));
                if (mList == null || mList.size() <= 0) {
                    continue;
                }

                for (Menu m : mList) {
                    menuSet.add(m);
                }
            }
        }

        return menuSet;
    }
}
