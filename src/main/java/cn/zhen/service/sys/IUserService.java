package cn.zhen.service.sys;


import cn.zhen.model.sys.User;
import cn.zhen.service.base.IBaseService;

public interface IUserService extends IBaseService<User> {
    public User getRowByID(Integer ID);
    public User getUserRowByName(String name);
    public boolean checkPermission(User user, String uri);
}
