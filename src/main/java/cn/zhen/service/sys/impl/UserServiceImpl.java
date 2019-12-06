package cn.zhen.service.sys.impl;

import cn.zhen.mapper.sys.MenuMapper;
import cn.zhen.mapper.sys.UserMapper;
import cn.zhen.model.Message;
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
import org.springframework.ui.Model;

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
    public Message doLogin(User u) {
        if (u == null || StringUtils.isEmpty(u.getUsername()) ||
                StringUtils.isEmpty(u.getPassword())) {
            return new Message(0, "请填写用户名密码");
        }

        User user = userMapper.getRowByName(u.getUsername());

        if (user == null) {
            return new Message(0, "用户不存在或密码错误");
        }

        if (u.getPassword().equals(user.getPassword())) {
            return new Message(1, "登录成功...", "/sys/user/frame.do", user);
        }
        return new Message(0, "用户不存在或密码错误");
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
    public Message save(User user) {
        if (StringUtils.isEmpty(user.getUsername())) {
            return new Message(0, "名字不能为空");
        }

        if (StringUtils.isEmpty(user.getPassword())) {
            return new Message(0, "密码不能为空");
        }

        if (StringUtils.isEmpty(user.getUserRoles())) {
            return new Message(0, "角色不能为空");
        }

        Long time = System.currentTimeMillis() / 1000;
        user.setUpdateTime(time);

        if (user.getUserId() > 0) {
            if (userMapper.update(user) > 0) {
                return new Message(1, "保存成功", "/sys/user/list.do");
            }
        } else {
            user.setCreateTime(time);
            if (userMapper.insert(user) > 0) {
                return new Message(1, "保存成功", "/sys/user/list.do");
            }
        }

        return new Message(0, "保存失败");
    }
}
