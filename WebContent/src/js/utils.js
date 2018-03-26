/**
 * 公用工具类js
 * 在jsp或html文件<script type="text/javascript" src="${basePath}/src/js/utils.js"></script>导入后
 * Utils.requireAjax(xxx,xxx)调用
 */
(function() {
	var _this = window.Utils = {
		/**
		 * js请求
		 * @param url 请求的url路径
		 * @param type 请求的类型("post","get","delete")
		 * @param fn 请求的回调方法
		 */
		requireAjax : function(url, type, fn) {
			// 先声明一个异步请求对象
			var xmlHttpReg = null;
			if (window.ActiveXObject) {// 如果是IE
				xmlHttpReg = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xmlHttpReg = new XMLHttpRequest(); // 实例化一个xmlHttpReg
			}

			// 如果实例化成功,就调用open()方法,就开始准备向服务器发送请求
			if (xmlHttpReg != null) {
				xmlHttpReg.open(type, url, true);
				xmlHttpReg.setRequestHeader("Content-Type",
						"application/x-www-form-urlencoded");
				xmlHttpReg.send();
				xmlHttpReg.onreadystatechange = function() {
					if (xmlHttpReg.readyState == 4 && xmlHttpReg.status == 200) {
						// 4代表执行完成 200代表执行成功
						var _data = xmlHttpReg.responseText;
						_data = JSON.parse(_data);
						fn(_data);
					}
				};
			}
		}
	};
	/*_this.createFunction(){};*/
}());