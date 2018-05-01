package com.fruitsalesplatform.test.db;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fruitsalesplatform.test.entity.User;

public class DBConnectionTest {
	
	// MyBatis配置文件
	private String resource = "beans.xml";

	private SqlSessionFactory sqlSessionFactory;

	private SqlSession sqlSession = null;
	
	/**
	 * 获取SqlSession
	 * @return
	 * @throws Exception
	 */
	public SqlSession getSqlSession() throws Exception {
		// 获取Spring类加载配置对象
		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(resource);
		// 从配置对象中创建会话工厂，并注入MyBatis配置文件的信息
		sqlSessionFactory = (SqlSessionFactory) context.getBean("sqlSessionFactory");
		context.close();
		sqlSession = sqlSessionFactory.openSession();
		return sqlSession;
	}
	
	/**
	 * 测试连接
	 * @throws Exception
	 */
	@Test
	public void testConnection() throws Exception {
		sqlSession = getSqlSession();
		if (sqlSession != null) {
			System.out.println("MyBatis-数据库连接成功！目前SQL配置数目：");
			System.out.println(sqlSession.getConfiguration().getMappedStatements().size());
		} else {
			System.out.println("MyBatis-数据库连接失败");
		}
	}

	/**
	 * 测试查询
	 * @throws Exception
	 */
	@Test
	public void testSelect() throws Exception
	{
		sqlSession = getSqlSession();
		User user = sqlSession.selectOne("test.findUserByName","张三");
		System.out.println(user);
	}

}
