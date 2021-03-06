package cn.zhen.web.controller.sys;

import cn.zhen.model.Message;
import cn.zhen.model.Page;
import cn.zhen.model.sys.Menu;
import cn.zhen.model.sys.Role;
import cn.zhen.model.sys.User;
import cn.zhen.service.sys.impl.MenuServiceImpl;
import cn.zhen.service.sys.impl.RoleServiceImpl;
import cn.zhen.service.sys.impl.UserServiceImpl;
import cn.zhen.web.controller.base.BaseController;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

@Controller
@RequestMapping("sys/user")
@SessionAttributes(names = "user")
public class UserController extends BaseController {

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private MenuServiceImpl menuService;

    @Autowired
    private RoleServiceImpl roleService;

    @RequestMapping("login")
    public @ResponseBody
    Message login(Model m, @RequestBody User u) {
        Message msg = userService.doLogin(u);
        m.addAttribute("user", msg.getData());
        return msg;
    }

    @RequestMapping("logout")
    public @ResponseBody Message logout(Model m) {
        m.addAttribute("user", new User());
        return new Message(1, "退出成功...", "/");
    }

    @RequestMapping("frame")
    public void frame(Model m, @SessionAttribute(value = "user") User user) {
        TreeSet<Menu> menList = menuService.getListByRoleIDs(user.getUserRoles());
        ArrayList<Menu> menuArr = new ArrayList<>();
        m.addAttribute("sysMenuList", menList);
    }

    @RequestMapping("home")
    public void home() {
    }

    @RequestMapping("list")
    public void list(Model model, String username, String pageNum) {
        Page pageList = userService.getListByPage(username, pageNum);
        List<Role> roleList = roleService.getListByAll();
        model.addAttribute("username", username);
        model.addAttribute("pageList", pageList);
        model.addAttribute("roleList", roleList);
    }

    @RequestMapping("form")
    public void form(Model m, String userId) {
        int uid = StringUtils.isEmpty(userId) ? 0 : Integer.parseInt(userId);
        if (uid > 0) {
            User userRow = userService.getRowByID(uid);
            m.addAttribute("userRow", userRow);
        }
        List<Role> roleList = roleService.getListByAll();
        m.addAttribute("roleList", roleList);
    }

    @RequestMapping("save")
    public @ResponseBody Message save(@RequestBody User user){
        return userService.save(user);
    }
}
