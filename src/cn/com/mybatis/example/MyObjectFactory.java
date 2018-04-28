package cn.com.mybatis.example;

import java.util.Collection;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.reflection.factory.DefaultObjectFactory;

public class MyObjectFactory extends DefaultObjectFactory {

	private static final long serialVersionUID = 1L;

	public <T> T create(Class<T> type) {
		return super.create(type);
	}
	
	public <T> T create(Class<T> type, List<Class<?>> constructorArgTypes, List<Object> constructorArgs) {
		return super.create(type, constructorArgTypes, constructorArgs);
	}
	
	public void setProperties(Properties properties)
	{
		super.setProperties(properties);
	}
	
	public <T> boolean isCollection(Class<T> type) {
		return Collection.class.isAssignableFrom(type);
	}
}
