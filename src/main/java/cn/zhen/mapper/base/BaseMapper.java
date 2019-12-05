package cn.zhen.mapper.base;

import java.util.List;

public interface BaseMapper<T> {
    public T save(T t);
    public Integer delete(Integer ID);
    public T getRowByID(Integer ID);
    public List<T> getListByIDArr(List<String> ids);
}
