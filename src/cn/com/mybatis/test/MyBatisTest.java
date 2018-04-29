package cn.com.mybatis.test;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import cn.com.mybatis.datasource.DataConnection;
import cn.com.mybatis.mapper.CustomerMapper;
import cn.com.mybatis.po.BatchCustomer;
import cn.com.mybatis.po.BatchItem;
import cn.com.mybatis.po.Customer;
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
	
	@Test
	public void testBatchCustomer() throws IOException {
		SqlSession sqlSession = dataConn.getSqlSession();
		List<BatchCustomer> bcList = sqlSession.selectList("test.findBatchCustomer");
		for (BatchCustomer batchCustomer : bcList) {
			System.out.println(batchCustomer);
		}
		sqlSession.close();
	}
	
	@Test
	public void testBatchCustomerToMap() throws IOException {
		SqlSession sqlSession = dataConn.getSqlSession();
		List<BatchItem> bcList = sqlSession.selectList("test.findBatchCustomerToMap");
		for (BatchItem batchCustomer : bcList) {
			System.out.println(batchCustomer);
		}
		sqlSession.close();
	}
	
	@Test
	public void testBatchAndBatchDetail() throws IOException {
		SqlSession sqlSession = dataConn.getSqlSession();
		BatchItem batchItem = sqlSession.selectOne("test.findBatchAndBatchDetail");
		if(batchItem!=null)
		{
			System.out.println(batchItem);
		}
		sqlSession.close();
	}
	
	@Test
	public void testFindCustomerAndProducts() throws IOException
	{
		SqlSession sqlSession = dataConn.getSqlSession();
		List<Customer> customerList = sqlSession.selectList("test.findUserAndProducts");
		System.out.println(customerList);
		sqlSession.close();
	}
	
	@Test
	public void testFindBatchCustomerLazyLoading() throws IOException
	{
		SqlSession sqlSession = dataConn.getSqlSession();
		List<BatchItem> batchItemList = sqlSession.selectList("test.findBatchUserLazyLoading");
//		System.out.println(batchItemList.toString());
		BatchItem batchItem = null;
		Customer customer = null;
		for(int i=0;i<batchItemList.size();i++)
		{
			batchItem = batchItemList.get(i);
			System.out.println("订单编号："+ batchItem.getNumber());
			
			// 执行getCustomer时才会去查询用户信息，这里实现了延迟加载
			customer = batchItem.getCustomer();
			System.out.println("订购用户姓名："+customer.getUsername());
		}
		sqlSession.close();
	}
	
	/**
	 * 测试Mapper动态代理
	 * @throws Exception
	 */
	@Test
	public void testFindCustomerOnMapper() throws Exception
	{
		SqlSession sqlSession = dataConn.getSqlSession();
		// 获取Mapper代理
		CustomerMapper customerMapper = sqlSession.getMapper(CustomerMapper.class);
		// 执行Mapper代理对象的查询方法
		Customer customer = customerMapper.findCustomerById(1);
		System.out.println(customer);
		sqlSession.close();
	}
}




