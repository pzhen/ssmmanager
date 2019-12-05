package cn.zhen.web.Interceptor;

import cn.zhen.model.Message;
import cn.zhen.model.sys.User;
import cn.zhen.service.sys.impl.UserServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Autowired
    private UserServiceImpl userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        String uri = request.getRequestURI();

        if (uri.contains("/sys/user/login")
                || uri.contains("/static/")
                || uri.contains("/sys/user/checkCode")) {
            return true;
        }

        User user = (User) request.getSession().getAttribute("user");

        if (user == null || user.getUserId() <= 0) {
            request.getRequestDispatcher("/WEB-INF/views/sys/user/login.jsp").forward(request, response);
            return false;
        }

        if (user.getUserType() == 1) {
            return true;
        }

        String checkURI = uri.replace(request.getContextPath(), "");
        if (userService.checkPermission(user, checkURI)) {
            return true;
        }

        String accept  = request.getHeader("accept");
        String referer = request.getHeader("referer");

        if (accept != null && accept.indexOf("application/json") != -1) {
            Message message = new Message(0, "对不起,您没有权限", referer);
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(response.getWriter(), message);
        } else {
            request.setAttribute("error_msg", "对不起您没有权限");
            request.setAttribute("referer", referer);
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        //System.out.println("拦截后....");
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        //System.out.println("视图处理前....");
    }
}
