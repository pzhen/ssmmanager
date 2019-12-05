package cn.zhen.service.sys.impl;

import cn.zhen.mapper.sys.RoleMapper;
import cn.zhen.model.sys.Role;
import cn.zhen.service.base.impl.BaseServiceImpl;
import cn.zhen.service.sys.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;


@Service
public class RoleServiceImpl extends BaseServiceImpl<Role> implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public Role getRowByID(Integer ID) {
        return null;
    }

    public List<Role> getListByIds(String ids) {
        if (ids == null || ids.equals("")) {
            return null;
        }
        String[] idList = ids.split(",");
        return roleMapper.getListByIDArr(Arrays.asList(idList));
    }

    public List<Role> getListByAll() {
        return roleMapper.getListByAll();
    }
}
