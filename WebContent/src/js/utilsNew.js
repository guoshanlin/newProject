/**
 * 公用工具类js
 * 前提引入jQuery，jquery-ui-1.9.2.custom.js
 * 在jsp或html文件<script type="text/javascript" src="${basePath}/src/js/utilsNew.js"></script>导入后
 * $.Utils.requireAjax(xxx,xxx)调用
 */
(function(win,$) {
	$.widget("CW.UtilsNew", {
		textFunction:function(){
		   console.log("测试");
		   return "test";
		}		
	});
}(window,jQuery));