package cn.com.mvc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.DataBinder;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.mvc.model.User;
import cn.com.mvc.validator.UserValidator;

@Controller
@RequestMapping("user")
public class UserControllerTest {
	@InitBinder
	public void initBinder(DataBinder binder) {
		binder.setValidator(new UserValidator());
	}
	
	@RequestMapping("toLogin")
	public String toLoginPage()
	{
		return "/user/login";
	}
	
	/**
	 * 登录模块
	 * @param model
	 * @param user
	 * @param result
	 * 需要@Valid，spring才会对其校验
	 * @Valid与后面的Errors和其子类BindingResult等必须成对出现
	 * @return
	 */
	@RequestMapping("login")
	public String login(Model model,HttpServletRequest request, @Valid User user, BindingResult result) {
		// 登录检测
		List<ObjectError> allErrors = null;
		if(result.hasErrors())
		{
			allErrors=result.getAllErrors();
			for (ObjectError objectError : allErrors) {
				System.out.println("code="+objectError.getCode()+" DefaultMessage="+objectError.getDefaultMessage());
			}
			model.addAttribute("allErrors",allErrors);
			return "/user/login";
		}
		boolean flag = checkUser(user);
		if(flag) {
			request.getSession().setAttribute("user", user);
		}else {
			model.addAttribute("errorMsg", "账号或密码错误");
			return "/user/login";
		}
		return "/user/loginSuccess";
	}

	@RequestMapping("loginout")
	public String loginout(Model model, HttpServletRequest request) {
		if(request.getSession().getAttribute("user")!=null) {
			request.getSession().removeAttribute("user");
		}else{
			model.addAttribute("errorMsg", "注销失败！用户已注销");
		}
		return "/user/login";
	}
	
	private boolean checkUser(User user) {
		if(user.getUsername().equals("zhangsan")&&user.getPassword().equals("123456")) {
			return true;
		}
		return false;
	}
	
}
