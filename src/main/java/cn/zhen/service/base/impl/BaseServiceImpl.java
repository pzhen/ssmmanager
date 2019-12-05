package cn.zhen.service.base.impl;

import cn.zhen.service.base.IBaseService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;

public abstract class BaseServiceImpl<T> implements IBaseService<T>{
    @Autowired
    protected HttpServletRequest request;
}
