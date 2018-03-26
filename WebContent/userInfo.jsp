<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String base = request.getContextPath();
	request.setAttribute("base", base);
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+base+"/";
	request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设置用户信息</title>
<script type="text/javascript" src="${basePath}/src/js/jquery.min.js"></script>
<script type="text/javascript" src="${basePath}/src/js/jquery-ui-1.9.2.custom.js"></script>
</head>
<body>
<h4>修改用户信息</h4>
    <form method="get" action="UserServlet">
       <p>用户名：<input type='text' name='userName' id = "userName"/></p>
       <p> 密码：<input type='password' name='password' id = "password" /></p>
       <p> 年龄：<input type='text' name='age' id = "age" /></p>
       <p> rowId：<input type='text' name='rowId' id = "rowId" /></p>
    <!--    <p><input type="submit" value="Submit" onclick="Submit()" /></p> -->
    </form>
     <p><input type="submit" value="Submit" onclick="Submit()"/></p> 
</body>
<script type="text/javascript" src="${basePath}/src/js/utils.js"></script>

<script type="text/javascript" src="${basePath}/src/js/utilsNew.js"></script>

<script type="text/javascript">
        function Submit(){
        console.log($.ui.tabs);
        //$.UtilsNew.textFunction();
       //    ajax();
           return false;
        }
        
        function ajax() {
               var _userName = document.getElementById("userName").value;
               var _password = document.getElementById("password").value;
               var _age = document.getElementById("age").value;
               var _rowId = document.getElementById("rowId").value;
               var _url = "UserInfo?userName="+_userName+"&password="+_password+"&age="+_age+ "&rowId="+_rowId;
               var _type ="post";
               Utils.requireAjax(_url,_type,function(data){
                  console.log(data);
               });
          //先声明一个异步请求对象
    /*       var xmlHttpReg = null;
          if (window.ActiveXObject) {//如果是IE
              xmlHttpReg = new ActiveXObject("Microsoft.XMLHTTP");
          } else if (window.XMLHttpRequest) {
              xmlHttpReg = new XMLHttpRequest(); //实例化一个xmlHttpReg
          }

          //如果实例化成功,就调用open()方法,就开始准备向服务器发送请求
          if (xmlHttpReg != null) {
               xmlHttpReg.open("post", _url, true);
               xmlHttpReg.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
               // xmlHttpReg.send({userName:_userName,password:_password});
	           xmlHttpReg.send();
	           xmlHttpReg.onreadystatechange = doResult; //设置回调函数
          }

          //回调函数
          //一旦readyState的值改变,将会调用这个函数,readyState=4表示完成相应

          //设定函数doResult()
          function doResult() {
          
              if (xmlHttpReg.readyState == 4) {//4代表执行完成    
                  if (xmlHttpReg.status == 200) {//200代表执行成功
                  var _data = xmlHttpReg.responseText;
                  _data = JSON.parse(_data);
                  console.log( _data.success);
                  if(_data.success){
                     alert("修改成功");
                      // xmlHttpReg.sendRedirect(path + "{path}/IndexServlet");
                    } 
                    //将xmlHttpReg.responseText的值赋给ID为resText的元素
                    //document.getElementById("resText").innerHTML = xmlHttpReg.responseText 
                  }
              }

          }*/
        

      }
  </script>
</html>