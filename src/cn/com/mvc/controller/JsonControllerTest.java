package cn.com.mvc.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.mvc.model.User;

@Controller
public class JsonControllerTest {
	Log log = LogFactory.getLog(this.getClass());
	
	@RequestMapping("toJsonTestPage")
	public String toJsonTestPage(Model model){
		return "/jsonTest";
	}
	
	
	@RequestMapping("/jsonTest")
	public @ResponseBody User jsonTest(@RequestBody User user)
	{
		log.info("username="+user.getUsername()+",password="+user.getPassword());
		return user;
	}
	
}
