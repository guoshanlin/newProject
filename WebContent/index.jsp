<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String base = request.getContextPath();
	request.setAttribute("base", base);
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+base+"/";
	request.setAttribute("basePath", basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <h4>这是一个新页面</h4>
    <form method="get" action="UserServlet">
       <p>用户名：<input type='text' name='userName' id = "userName"/></p>
       <p> 密码：<input type='password' name='password' id = "password" /></p>
       <p> 年龄：<input type='text' name='age' id = "age" value="50" /></p>
    <!--    <p><input type="submit" value="Submit" onclick="Submit()" /></p> -->
    </form>
     <p><input type="submit" value="登录" onclick="Submit()"/></p> 
  </body>
  <script type="text/javascript">
        function Submit(){
           ajax();
           return false;
        }
        
        function ajax() {

          //先声明一个异步请求对象
          var xmlHttpReg = null;
          if (window.ActiveXObject) {//如果是IE
              xmlHttpReg = new ActiveXObject("Microsoft.XMLHTTP");
          } else if (window.XMLHttpRequest) {
              xmlHttpReg = new XMLHttpRequest(); //实例化一个xmlHttpReg
          }

          //如果实例化成功,就调用open()方法,就开始准备向服务器发送请求
          if (xmlHttpReg != null) {
               var _userName = document.getElementById("userName").value;
               var _password = document.getElementById("password").value;
                var _age = document.getElementById("age").value;
               var _url = "UserServlet?userName="+_userName+"&password="+_password+"&age="+_age;
               xmlHttpReg.open("get", _url, true);
               xmlHttpReg.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
            //     xmlHttpReg.send({userName:_userName,password:_password});
	               xmlHttpReg.send();
	               xmlHttpReg.onreadystatechange = doResult; //设置回调函数
          }

          //回调函数
          //一旦readyState的值改变,将会调用这个函数,readyState=4表示完成相应

          //设定函数doResult()
          function doResult() {
          
              if (xmlHttpReg.readyState == 4) {//4代表执行完成
                 
                 
                  if (xmlHttpReg.status == 200) {//200代表执行成功
                  console.log(xmlHttpReg); 
                  console.log('${base}');
                  var _data = eval('(' + xmlHttpReg.responseText + ')');
                  console.log( _data);
                  if(_data.success){
                      window.location = '${base}/src/table.jsp';
                     // xmlHttpReg.sendRedirect(path + "{path}/IndexServlet");
                    }
                    //将xmlHttpReg.responseText的值赋给ID为resText的元素
                    //  document.getElementById("resText").innerHTML = xmlHttpReg.responseText 
                  }
              }

          }
        

      }
  </script>
</html>
