package cn.com.mybatis.test;

import java.util.Collection;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.reflection.factory.DefaultObjectFactory;

import cn.com.mybatis.po.ShoppingCart;

public class CartObjectFactory extends DefaultObjectFactory {

	private static final long serialVersionUID = 1L;

	@Override
	public <T> T create(Class<T> type) {
		return super.create(type);
	}
	
	@Override
	public <T> T create(Class<T> type, List<Class<?>> constructorArgTypes, List<Object> constructorArgs) {
		T ret = super.create(type, constructorArgTypes, constructorArgs);
		if(ShoppingCart.class.isAssignableFrom(type))
		{
			ShoppingCart entity = (ShoppingCart)ret;
			entity.init();
		}
		return ret;
	}
	
	public void setProperties(Properties properties)
	{
		super.setProperties(properties);
	}
	
	public <T> boolean isCollection(Class<T> type) {
		return Collection.class.isAssignableFrom(type);
	}
}
