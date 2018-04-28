package cn.com.mybatis.test;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

public class DateTypeHandler implements TypeHandler<Date> {
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Override
	public Date getResult(ResultSet arg0, String arg1) throws SQLException {
		System.out.println("其他逻辑");
		return arg0.getDate(arg1);
	}

	@Override
	public Date getResult(ResultSet arg0, int arg1) throws SQLException {
		System.out.println("其他逻辑");
		return arg0.getDate(arg1);
	}

	@Override
	public Date getResult(CallableStatement arg0, int arg1) throws SQLException {
		System.out.println("其他逻辑");
		return arg0.getDate(arg1);
	}

	@Override
	public void setParameter(PreparedStatement arg0, int arg1, Date arg2, JdbcType arg3) throws SQLException {
		System.out.println("其他逻辑");
		arg0.setDate(arg1, arg2);
		System.out.println("其他逻辑");
	}

}
