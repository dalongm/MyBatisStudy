package com.fruitsalesplatform.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 暂时全部放行
 */
public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String uri = request.getRequestURI();
		// 判断当前请求地址是否是登录/注册地址
		if (!(uri.contains("login") ||uri.contains("Login")|| uri.contains("register"))) {
			// 非登录请求
			if (request.getSession().getAttribute("user") != null) {
				return true;
			} else {
				if(uri.contains("css")||uri.contains("js")||uri.contains("images")) {
					// 静态资源
					return true;
				}
				else
				{	// 跳转到登录界面
					response.sendRedirect(request.getContextPath()+"/user/toLogin.action");
				}
			}
		}
		else
		{
			// 登录请求
			return true;
		}
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

}
