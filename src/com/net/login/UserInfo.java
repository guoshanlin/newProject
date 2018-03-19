package com.net.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;
import com.mysql.jdbc.Statement;
import com.net.bean.Students;
import com.net.bean.StudentsSearch;
//import com.net.bean.User;
//import com.net.utls.ToolClass;

public class UserInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UserInfo() {
		super();
	}
	
	/**
	 * 查询用户信息
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 处理乱码；
		request.setCharacterEncoding("UTF-8");

		System.out.println("get=================================");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String _keyWorld = request.getParameter("keyWorld");
			String sql = "SELECT * FROM `guoguoblog` WHERE name LIKE ? AND password LIKE ? order by id asc";
			List<Students> student = new StudentsSearch().finStudents(sql,
					_keyWorld, "");
			System.out.println(student.size());
			if (student.size() != 0) {
				ArrayList<Object> arrayList = new ArrayList<Object>();
				for (Students students : student) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("userName", students.getNames());
					map.put("id", students.getId());
					map.put("rowId", students.getRowId());
					map.put("age", students.getAge());
					map.put("password", students.getPassword());
					arrayList.add(map);
				}
				result.put("success", true);
				result.put("msg", "查询成功");
				result.put("data", arrayList);
				JSONObject jsonObj = JSONObject.fromObject(result);
				out.println(jsonObj);
			} else {
				// 通过下面的方式把需要的内容发送到客户端
				result.put("success", true);
				result.put("msg", "查询无结果");
				result.put("data", null);
				JSONObject jsonObj = JSONObject.fromObject(result);
				out.println(jsonObj);
			}

		} catch (Exception e) {
			result.put("success", false);
			result.put("msg", "查询失败");
			result.put("data", null);
			JSONObject jsonObj = JSONObject.fromObject(result);
			out.println(jsonObj);
			// TODO: handle exception
		}
		out.flush();
		out.close();
		// super.doGet(request, response);
	}
	
	/**
	 * 新增或修改用户信息
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// super.doPost(request, response);
		System.out.println("post===============================拦截！");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		Map<String, Object> result = new HashMap<String, Object>();
		String _id = request.getParameter("id");
		String msg = "修改" ;
		if (_id == null || "".equals(_id)) { 
			msg = "新增";
		}
		try {
			Connection connection = StudentsSearch.getConnection();// 链接数据库
			Statement state= (Statement) connection.createStatement();   //容器
			 String _userName = request.getParameter("userName");
			 String _password = request.getParameter("password");
			 int _age = Integer.parseInt(request.getParameter("age"));
			 String _rowId = request.getParameter("rowId");
			 
			 if(_id != "" ){				 
				 //执行修改
				 System.out.println("执行修改=================================");
				 String sql="UPDATE guoguoblog SET name='"+_userName+"',age="+ _age +",password='"+_password+"',rowId='"+_rowId+"' WHERE id='"+_id+"'";	 
				 state.executeUpdate(sql); 
			     connection.close();			     
				 result.put("success",true);
				 result.put("msg",msg+ "成功");
				 JSONObject jsonObj = JSONObject.fromObject(result);
				 out.println(jsonObj);
			 }else {
				 //执行新增
//				 String sql1 = "SELECT * FROM `guoguoblog` WHERE name LIKE ? AND password LIKE ? order by age asc";
//                 List<Students> student = new StudentsSearch().finStudents(sql1,"", "");
//                 String _newId = String.valueOf(student.size() + 1);
				 System.out.println("执行新增=================================");
				 String sql = "insert into guoguoblog(name,password,age,rowId,id) values(?,?,?,?,?)"; 
				 PreparedStatement ptmt = (PreparedStatement) connection.prepareStatement(sql); 
				 ptmt.setString(1, _userName); 
				 ptmt.setString(2, _password); 
				 ptmt.setInt(3, _age); 
				 ptmt.setString(4, _rowId); 
				 ptmt.setString(5, getUUID()); 	
				 ptmt.execute();				     
				 result.put("success",true);
				 result.put("msg",msg+"成功");
				 JSONObject jsonObj = JSONObject.fromObject(result);
				 out.println(jsonObj);
			 }
			
		} catch (Exception e) {
			// TODO: handle exception
			  System.out.println("=============异常捕获");
			 result.put("success",false);
			 result.put("msg",msg+ "失败");
			 result.put("data",null);
			 JSONObject jsonObj = JSONObject.fromObject(result);
			out.println(jsonObj);
			
		}
		out.flush();
		out.close();

	}
	
	/**
	 * 获取唯一id
	 * @return
	 */
	public static String getUUID() {
		return UUID.randomUUID().toString().replace("-", "").toUpperCase();
	}
	/**
	 * 删除用户信息
	 */
	protected void doDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 处理乱码；
		request.setCharacterEncoding("UTF-8");
		System.out.println("Delect=================================");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Connection connection = StudentsSearch.getConnection();// 链接数据库
		     	String _id = request.getParameter("id");
		     	System.out.println(_id);
			    String sql="delete from guoguoblog where id='" +_id + "'";  //生成一条sql语句
			    java.sql.Statement stmt= connection.createStatement() ;//创建Statement对象
			    stmt.executeUpdate(sql);//执行sql语句
			    connection.close();
				result.put("success", true);
				result.put("msg", "删除成功");
				JSONObject jsonObj = JSONObject.fromObject(result);
				out.println(jsonObj);

		} catch (Exception e) {
			result.put("success", false);
			result.put("msg", "删除败");
			JSONObject jsonObj = JSONObject.fromObject(result);
			out.println(jsonObj);
			// TODO: handle exception
		}
		out.flush();
		out.close();
		//super.doGet(request, response);
	}

}
