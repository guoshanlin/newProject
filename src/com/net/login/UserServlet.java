package com.net.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.net.bean.Students;
import com.net.bean.StudentsSearch;
import com.net.bean.User;
import com.net.utls.ToolClass;

public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UserServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 处理乱码；
		request.setCharacterEncoding("UTF-8");
		// String userName = request.getParameter("userName");
		// String password = request.getParameter("password");
		// String age = request.getParameter("age");
		// System.out.println("用户名：" + userName);
		// System.out.println("密码：" + password);
		// System.out.println("年龄：" + age);

		System.out.println("=================================");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		try {
			// Class clz = Class.forName("com.net.bean.User");
			User user = (User) ToolClass.requestToBean(request, User.class);
			user.setId();
			// System.out.println(user.getId());
			// System.out.println(user.getPassword());
			// System.out.println(user.getUserName());
			// System.out.println(user.getAge());

			String sql = "SELECT * FROM `guoguoblog` WHERE name LIKE ? AND password LIKE ? order by age asc";

			List<Students> student = new StudentsSearch().finStudents(sql,
					user.getUserName(), user.getPassword());
			System.out.println(student.size() == 1);
			if (student.size() == 1) {
				Map<String, Object> map = new HashMap<String, Object>();

				for (Students students : student) {
					map.put("userName", students.getNames());
					map.put("id", students.getId());
					map.put("rowId", students.getRowId());
					map.put("age", students.getAge());
					map.put("password", students.getPassword());

					System.out.println(students.getNames());
					System.out.println(students.getId());
					System.out.println(students.getRowId());
					System.out.println(students.getAge());
					System.out.println(students.getPassword());

					JSONObject jsonObj = JSONObject.fromObject(map);
//
//					// JSONObject jsonObj = JSONObject.fromObject(map);
//					jsonObj.put("data", map);
					// 通过下面的方式把需要的内容发送到客户端
//					out.println("{success:true," + jsonObj + ",msg:'登录成功'}");
				}
			} else {
				// 通过下面的方式把需要的内容发送到客户端
				out.println("{success:false,data:null,msg:'登录失败，用户名或密码错误'}");
			}

		} catch (Exception e) {
			out.println("{success:false,data:null，msg：'登录失败'}");
			// TODO: handle exception
		}
		out.flush();
		out.close();
		// super.doGet(request, response);
	}

}
