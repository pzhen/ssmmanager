package cn.zhen.mapper.sys;

import cn.zhen.mapper.base.BaseMapper;
import cn.zhen.model.sys.Menu;
import org.springframework.stereotype.Repository;

@Repository
public interface MenuMapper extends BaseMapper<Menu> {
    public Menu getRowByUri(String uri);
}
