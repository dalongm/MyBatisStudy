package cn.com.mvc.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import cn.com.mvc.model.User;

public class UserValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmpty(errors, "username", "Username.is.empty","用户名不能为空");
		User user = (User)target;
		if(null==user.getPassword()||"".equals(user.getPassword())) {
			errors.rejectValue("password", "Password.is.empty", "密码不能为空");
		}else if(user.getPassword().length()<6)
		{
			errors.rejectValue("password", "Length.too.short", "密码长度不能小于6位");
		}
	}


}
