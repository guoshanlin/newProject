package com.net.utls;

/**
 *
 * 常量工具类
 * PublicConstant
 * 创建人:guoshanlin 
 * 时间：2018-1-24-上午11:24:56 
 * @version 1.0.0
 *
 */
public class PublicConstant {
	
	//"jdbc:mysql://localhost:3306/guoguo" 
    // "jdbc:mysql"为mysql链接；
	//  "localhost:3306";本地固定地址
	//  "guoguo";数据库名
	
   public static String driver ="com.mysql.jdbc.Driver";
   public static String url ="jdbc:mysql://localhost:3306/guoguo?useUnicode=true&amp;characterEncoding=UTF-8";
   public static String pathName ="root";
   public static String password ="root";
   public static String sqlguoguoblog ="SELECT * FROM `guoguoblog`";
}
