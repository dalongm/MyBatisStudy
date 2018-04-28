package cn.com.mybatis.test;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import cn.com.mybatis.datasource.DataConnection;
import cn.com.mybatis.po.User;

public class MyBatisTest {
	public DataConnection dataConn = new DataConnection();

	@Test
	public void testSelect() throws IOException {
		SqlSession sqlSession = dataConn.getSqlSession();
		User user = sqlSession.selectOne("test.findUserById", 7);
		System.out.println("姓名：" + user.getUsername());
		System.out.println("性别：" + user.getGender());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println("生日：" + sdf.format(user.getBirthday()));
		System.out.println("所在地：" + user.getProvince() + user.getCity());
		// System.out.println(user);
		sqlSession.close();
	}

	@Test
	public void testFuzzySearch() throws IOException {
		SqlSession sqlSession = dataConn.getSqlSession();
		// UserMapper中使用'%${value}%'，实现模糊匹配
		// List<User> userList = sqlSession.selectList("test.findUserByUsername", "丽");

		// UserMapper中使用#{_parameter}，实现模糊匹配
		List<User> userList = sqlSession.selectList("test.findUserByUsername", "%丽%");
		for (User user : userList) {
			System.out.println(user);
		}
		sqlSession.close();
	}

	@Test
	public void testInsert() throws IOException, ParseException {
		SqlSession sqlSession = dataConn.getSqlSession();
		User user = new User();
		user.setUsername("孙佳");
		user.setGender("女");
		user.setPassword("6666");
		user.setEmail("6666@126.com");
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		user.setBirthday(simpleDateFormat.parse("1994-03-03"));
		user.setProvince("湖北省");
		user.setCity("武汉市");
		sqlSession.insert("test.insertUser", user);
		System.out.println(user);
		sqlSession.commit();
		sqlSession.close();
	}
	
	@Test
	public void testUpdateUserName() throws IOException{
		SqlSession sqlSession = null;
		try {
			sqlSession = dataConn.getSqlSession();
			User user = new User();
			user.setId(7);
			user.setUsername("孙嘉");
			sqlSession.update("test.updateUserName", user);
			// 不能在此处打印user，因为部分字段为空，还会导致sqlSession不会提交
			sqlSession.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(sqlSession!=null)
			{
				sqlSession.close();
			}
		}
		
		sqlSession.close();
	}
	
	@Test
	public void testDeleteUserById(){
		SqlSession sqlSession = null;
		try {
			sqlSession = dataConn.getSqlSession();
			sqlSession.delete("test.deleteUser", 6);
			sqlSession.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(sqlSession!=null)
			{
				sqlSession.close();
			}
		}
		
	}
	
}
