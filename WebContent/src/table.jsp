<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>列表</title>
<style>
  table{border-collapse: collapse;border-spacing:inherit;border-right:1px solid #232222;border-bottom:1px solid #232222;}
  tr{height:30px;}
  td{border-top:1px solid #232222;border-left:1px solid #232222;height:30px;}
  td>div{height:30px;}
  .modal_fix_mask{position: fixed; top: 0; left:0;z-index: 999;width: 100%;height: 100%; background-color: rgba(11,11,11,.5);display:none;}
  .modal_place{width:300px;height:190px;background-color:#FFF; position:absolute;top:50%;left:50%;margin-top:-95px;margin-left:-150px;}
  .modal_head h5{margin:0; text-indent:10px; line-height:30px;display:inline-block;width:270px;}
  .modal_head span{display:inline-block;line-height:30px;width:25px; text-align:center;cursor: pointer;}
  .modal_body{padding:0 10px;}
  .modal_body p{ margin:5px 0;height:25px;}
  .modal_footer{text-align:right;}
  .span_title{display:inline-block;width:80px;}
</style>
</head>
<body>
	<div style="margin:10px">
	  <button onclick="modify()">新增</button>
	   <input id="keyWorld" type="text" value="">
	   <button onclick="ajax()">查询</button>
	</div>
	<div style="margin: 10px">
		<table width="100%">
			<thead>
				<tr>
				    <td width="5%" style="text-align:center">序号</td>
					<td width="15%">姓名</td>
					<td width="15%">年龄</td>
					<td width="25%">编号</td>
					<td width="20%">id</td>
					<td width="10%">密码</td>
					<td width="10%">操作</td>
				</tr>
			</thead>
			<tbody id="table_tbody">
			</tbody>
		</table>
	</div>
	<div class="modal_fix_mask" id="modal_add_modify">
	    <div class="modal_place">
	       <div class="modal_content">
	          <div class="modal_head">
	            <h5 id="modal_title">新增</h5>
	            <span id="modal_icon_hide" onclick="modalHide()">X</span>
	          </div>
	          <div class="modal_body">
		            <form>
				       <p><span class="span_title">用户名：</span><input type='text' name='userName' id = "userName"/></p>
				       <p><span class="span_title">密码：</span><input type='password' name='password' id = "password" /></p>
				       <p><span class="span_title">年龄：</span><input type='text' name='age' id = "age" /></p>
				       <p><span class="span_title">rowId：</span><input type='text' name='rowId' id = "rowId" /></p>
	               </form>
	          </div>
	          <div class="modal_footer">
	             <button id="modal_submit">提交 </button><button style="margin:0 10px;" onclick="modalHide()">取消 </button></p> 
	          </div> 
	       </div>
	    </div>
	</div>
</body>
<script type="text/javascript">
  /*       function Submit(){
           ajax();
           return false;
        } */
         ajax();
        function delect(obj){
          console.log("点击删除+++++++++++++"+JSON.stringify(obj));
            //先声明一个异步请求对象
          var xmlHttpReg = null;
          if (window.ActiveXObject) {//如果是IE
              xmlHttpReg = new ActiveXObject("Microsoft.XMLHTTP");
          } else if (window.XMLHttpRequest) {
              xmlHttpReg = new XMLHttpRequest(); //实例化一个xmlHttpReg
          }

          //如果实例化成功,就调用open()方法,就开始准备向服务器发送请求
          if (xmlHttpReg != null) {
               var keyWorld = document.getElementById("keyWorld").value;
               var _url = "${basePath}UserInfo?id="+obj.id;
               xmlHttpReg.open("Delete", _url, true);
               xmlHttpReg.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
	           xmlHttpReg.send();
	           xmlHttpReg.onreadystatechange = doResultDel; //设置回调函数
          }

          //回调函数
          //一旦readyState的值改变,将会调用这个函数,readyState=4表示完成相应

          //设定函数doResult()
          function doResultDel() {
          
              if (xmlHttpReg.readyState == 4) {//4代表执行完成
                 
                 
                  if (xmlHttpReg.status == 200) {//200代表执行成功
                    var _data = eval('(' + xmlHttpReg.responseText + ')');
                  if(_data.success){
                      alert("删除成功");
                       ajax();
                  }
              }

          }
          }
         }
         function modalHide(){          
           var _modal_damo = document.getElementById("modal_add_modify");
            _modal_damo.style.display="none";
         }
        function modify(obj){
           var _modal_damo = document.getElementById("modal_add_modify");
            _modal_damo.style.display="block";
           if(obj){
               document.getElementById("userName").value = obj.userName;
               document.getElementById("password").value = obj.password;
               document.getElementById("age").value = obj.age;
               document.getElementById("rowId").value = obj.rowId;
           }else{
               document.getElementById("userName").value = "";
               document.getElementById("password").value = "";
               document.getElementById("age").value = "";
               document.getElementById("rowId").value = "";
           }
           document.getElementById("modal_submit").onclick=function submitUser(){
               var _obj = {};
                   _obj.userName = document.getElementById("userName").value;
	               _obj.password = document.getElementById("password").value;
	               _obj.age = document.getElementById("age").value;
	               _obj.rowId = document.getElementById("rowId").value;          
               if(_obj.userName== "" && !obj){alert("用户名不能为空");return;}  
               if(_obj.password== "" && !obj ){ alert("密码不能为空");return;}  
               if(_obj.age== "" && !obj){ alert("年龄不能为空"); return;}    
               if(_obj.rowId== "" && !obj){alert("rowId不能为空");return;}               
               if(obj){
                  for(var key in _obj){
                    if(_obj[key] != ""){
                      obj[key] = _obj[key];
                    }                   
                  }
                addOrModify(obj,"修改");
               } else{
                _obj.id="";
                addOrModify(_obj,"新增");
               }       
           }
         }
         function addOrModify(obj,msg){           
	          //先声明一个异步请求对象
	          var xmlHttpReg = null;
	          if (window.ActiveXObject) {//如果是IE
	              xmlHttpReg = new ActiveXObject("Microsoft.XMLHTTP");
	          } else if (window.XMLHttpRequest) {
	              xmlHttpReg = new XMLHttpRequest(); //实例化一个xmlHttpReg
	          }
	
	          //如果实例化成功,就调用open()方法,就开始准备向服务器发送请求
	          if (xmlHttpReg != null) {
	               var _url = "${basePath}UserInfo?userName="+obj.userName+"&password="+obj.password+"&age="+obj.age+ "&rowId="+obj.rowId+ "&id="+obj.id;
	               xmlHttpReg.open("post", _url, true);
	               xmlHttpReg.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
	               // xmlHttpReg.send({userName:_userName,password:_password});
		           xmlHttpReg.send();
		           xmlHttpReg.onreadystatechange = doResultUser; //设置回调函数
	          }
	
	          //回调函数
	          //一旦readyState的值改变,将会调用这个函数,readyState=4表示完成相应
	
	          //设定函数doResult()
	          function doResultUser() {
	          
	              if (xmlHttpReg.readyState == 4) {//4代表执行完成    
	                  if (xmlHttpReg.status == 200) {//200代表执行成功
	                  var _data = xmlHttpReg.responseText;
	                  _data = JSON.parse(_data);
	                  if(_data.success){
	                     var _modal_damo = document.getElementById("modal_add_modify");
                         _modal_damo.style.display="none";
	                     alert(msg + "成功");
	                     ajax();
	                      // xmlHttpReg.sendRedirect(path + "{path}/IndexServlet");
	                    }else{
	                      alert(msg + "失败");
	                    } 
	                    //将xmlHttpReg.responseText的值赋给ID为resText的元素
	                    //document.getElementById("resText").innerHTML = xmlHttpReg.responseText 
	                  }
	              }
	
	          }
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
               var keyWorld = document.getElementById("keyWorld").value;
               var _url = "${basePath}UserInfo?keyWorld="+keyWorld;
               xmlHttpReg.open("get", _url, true);
               xmlHttpReg.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
	           xmlHttpReg.send();
	           xmlHttpReg.onreadystatechange = doResult; //设置回调函数
          }

          //回调函数
          //一旦readyState的值改变,将会调用这个函数,readyState=4表示完成相应

          //设定函数doResult()
          function doResult() {
          
              if (xmlHttpReg.readyState == 4) {//4代表执行完成
                 
                 
                  if (xmlHttpReg.status == 200) {//200代表执行成功
                  var _data = eval('(' + xmlHttpReg.responseText + ')');
                  _html = "";
                  if(_data.success && _data.data !=null ){
                      _data.data.forEach(function(item,index){
                        var  i=index +1;
                       _html+="<tr><td><div style='text-align:center;'>"+i+"</div></td><td><div>"+item.userName+"</div></td>";
					   _html+="<td><div>"+item.age+"</div></td>" ;
					   _html+="<td><div>"+item.id+"</div></td>" ;
					   _html+="<td><div>"+item.rowId+"</div></td>" ;
					   _html+="<td><div>"+item.password+"</div></td>" ;
					   _html+="<td><button onclick='modify("+JSON.stringify(item)+")' style='margin-left:5px;'>修改</button><button onclick='delect("+JSON.stringify(item)+")' style='margin-left:5px;'>删除</button></td></tr>";			
                      });                
                     // xmlHttpReg.sendRedirect(path + "{path}/IndexServlet");
                    }else{
                      _html+="<tr><td colspan='6' style='text-align:center'><div>暂无数据</div></td>";
                    }
                    var damo = document.getElementById("table_tbody").innerHTML=_html;
                  }
              }

          }
        

      }
  </script>
</html>