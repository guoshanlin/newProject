package com.net.core;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.LinkedList;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


// @WebFault("/GetCoreFilter");
public class GetCoreFilter implements Filter {
    private LinkedList<ActionMapping> actionMappingses = null;
	public GetCoreFilter() {

	}

	public void destroy() {

	}
	public void init(FilterConfig fConfig) throws ServletException {
		actionMappingses = new LinkedList();
		ActionMapping actionMapping = new ActionMapping();
		actionMapping.setClassName("com.servers.bean.ServerAction");
		actionMapping.setMethod("index");
		actionMapping.setName("index.jsp");
		actionMapping.setNamespace("/");
		
		actionMappingses.add(actionMapping);
		
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
//		request.getAttribute(arg0)
		System.out.println("......在这里拦截。。。。。");
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse reqn = (HttpServletResponse)response;
		String path = req.getServletPath();
		System.out.println(path);
		ActionMapping actionMapping = getActionMapping(path);
		System.out.println(actionMapping);
		//反射
		
		try {
			Class clazz = getClassObjct(actionMapping.getClassName());
			Object obj  = clazz.newInstance();
			Class[] clzs = clazz.getInterfaces();
			if(clzs.length > 0){
				for (Class class1 : clzs) {
					if(class1 == ServletRequestContext.class){
						System.out.println("+++++++++++++++ ok");
						Method newMethod = clazz.getDeclaredMethod("SetHttpServletRequest",HttpServletRequest.class);
						newMethod.invoke(obj,req);
					}					
				}
			}
		//	Method method = clazz.getDeclaredMethod(actionMapping.getMethod(),HttpServletRequest.class);
			Method method = clazz.getDeclaredMethod(actionMapping.getMethod());
			method.invoke(obj);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		chain.doFilter(request, response);
	}
	
	public static Class getClassObjct(String className) {
		Class clz;
		try {
			clz = Class.forName(className);// 注意此字符串必须是真实路径，就是带包名的类路径，包名.类名
			return clz;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	private ActionMapping getActionMapping(String path){
		if(actionMappingses == null && actionMappingses.size()==0) return null;
		ActionMapping mapping = null;
		for (ActionMapping actionMapping : actionMappingses) {
			String newPath =actionMapping.getNamespace().concat(actionMapping.getName());
			if(newPath.equalsIgnoreCase(path)){
				mapping = actionMapping;
				break;
			}
		}
		return mapping;
		
	}


}
