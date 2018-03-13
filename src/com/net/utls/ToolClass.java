package com.net.utls;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
/**
 * 工具类
 * 
 * ToolClass
 * 创建人:guoshanlin 
 * 时间：2018-2-8-下午4:31:56 
 * @version 1.0.0
 *
 */
public class ToolClass {
      
	
	/**
	 * 根据class获取所有方法名以及类型
	 * @param clz
	 * @return
	 */
	public static HashMap<String, Class> getTypes(Class clz) {
		HashMap<String, Class> map = new HashMap<>();

		// 获取类方法
		Method[] methods = clz.getDeclaredMethods();
		for (Method method : methods) {
			// 判断是否为set方法
			if (!method.getName().equals("setId") && method.getName().startsWith("set")) {
				
				map.put(method.getName(), method.getParameterTypes()[0]);
			}

		}
		return map;
	}
	/**
	 * 根据方法名获取数据类型
	 * @param methodName
	 * @param clz
	 * @return
	 */
	public static Class getMethodType(String methodName, Class clz) {
		return getTypes(clz).get(methodName);
	}
	
	/**
	 * 根据方法名获取设置参数的方法（如：setId）；
	 * @param key
	 * @return
	 */
	public static String getKetSetMethod(String key) {
		return "set" + key.substring(0, 1).toUpperCase() + key.substring(1);
	}
	
	/**
	 * 根据参数值创建并返回clz对象
	 * @param request
	 * @param clz
	 * @return
	 */
	public static Object requestToBean(HttpServletRequest request, Class clz) {
		try {

			// 获取传值数组
			Map<String, String[]> map = request.getParameterMap();
			//System.out.println(clz);
			//通过反射创建对象
			    Object object = clz.newInstance();
				for (Map.Entry<String, String[]> entry : map.entrySet()) {
					// 获取传值key
					String key = entry.getKey();
					// key首字母大写；
					// key = key.substring(0, 1).toUpperCase() + key.substring(1);
					// 获取set方法
					String methodName = getKetSetMethod(key);
					//获取方法类型：
					Class type = getMethodType(methodName, clz);
					
					Method method = clz.getDeclaredMethod(methodName,type);
					String[] values = entry.getValue();
					if (values != null && values.length == 1) {
						String result = values[0];
						// 判断方法类型将string转成指定数据类型
						if(type==Byte.class){
							//将值存到class对象中；
							method.invoke(object, Byte.parseByte(result));
						}else if (type==Short.class) {
							method.invoke(object, Short.parseShort(result));
						}else if (type==Integer.class) {
							method.invoke(object, Integer.parseInt(result));
						}else if (type==Long.class) {
							method.invoke(object, Long.parseLong(result));
						}else if (type==Float.class) {
							method.invoke(object, Float.parseFloat(result));
						}else if (type==Double.class) {
							method.invoke(object, Double.parseDouble(result));
						}else if (type==Boolean.class) {
							method.invoke(object, Boolean.parseBoolean(result));
						}else {
							method.invoke(object, result);
						}
					
						//  System.out.println("key:===========" + result);
					} else if (values != null && values.length > 1) {
						// String result = values[0];
						// System.out.println("key:===========" + values);
					}
				}
			return object;

		} catch (Exception e) {
			// TODO: handle exception
			 e.printStackTrace();
			 return null;
		}
	
	}
}
