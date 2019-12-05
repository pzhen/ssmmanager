package cn.zhen.service.sys.impl;

import cn.zhen.mapper.sys.MenuMapper;
import cn.zhen.mapper.sys.UserMapper;
import cn.zhen.model.Page;
import cn.zhen.model.sys.Menu;
import cn.zhen.model.sys.User;
import cn.zhen.service.base.impl.BaseServiceImpl;
import cn.zhen.service.sys.IUserService;
import cn.zhen.utiles.DataSource;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.TreeSet;

@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private MenuMapper menuMapper;

    @Autowired
    private RoleServiceImpl roleService;

    @Autowired
    private MenuServiceImpl menuService;

    @DataSource(DataSource.slave)
    public User doLogin(String username, String password) {
        if (StringUtils.isEmpty(username)) {
            return null;
        }

        User user = userMapper.getRowByName(username);

        if (user == null) {
            return null;
        }

        if (password.equals(user.getPassword())) {
            return user;
        } else {
            return null;
        }
    }

    @Override
    public User getRowByID(Integer ID) {

        return userMapper.getRowByID(ID);
    }

    @Override
    public User getUserRowByName(String name) {
        return userMapper.getRowByName(name);
    }

    @Override
    public boolean checkPermission(User user, String uri) {
        if (StringUtils.isEmpty(uri) || user == null) {
            return false;
        }

        boolean flag = false;
        TreeSet<Menu> listMenu = menuService.getListByRoleIDs(user.getUserRoles());
        if (listMenu == null) {
            return flag;
        }

        for (Menu m : listMenu) {
            if (m.getMenuUrl().equals(uri)) {
                flag = true;
                break;
            }
        }
        return flag;
    }

    public Page getListByPage(String name, String pageNum) {
        int currPage = StringUtils.isEmpty(pageNum) ? 1 : Math.abs(Integer.parseInt(pageNum));
        Page<User> page = new Page<>();
        int rowNum = page.getRows();

        int total = userMapper.getListByPageTotal(name);

        if (total > 0) {
            List<User> list = userMapper.getListByPage(name, (currPage - 1) * rowNum, rowNum, "user_id DESC");
            page.setList(list);
        }
        page.setTotalCount(total);
        page.setCurrentPage(currPage);
        return page;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public int save(User user){
        if (user.getUserId() > 0) {
            user.setUpdateTime(System.currentTimeMillis()/1000);
            return userMapper.update(user);
        } else {
            return userMapper.insert(user);
        }
    }
}
