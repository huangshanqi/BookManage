<%@page import="com.hsq.model.Book"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>数目列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="script/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
	
	$(function(){
		
		$("#pageNo").change(function(){
			var val = $(this).val();
			val = $.trim(val);
			
			//1. 校验 val 是否为数字 1, 2, 而不是 a12, b
			var flag = false;
			var reg = /^\d+$/g;
			var pageNo = 0;
			
			if(reg.test(val)){
				//2. 校验 val 在一个合法的范围内： 1-totalPageNumber
				pageNo = parseInt(val);
				if(pageNo >= 1 && pageNo <= 5){
					flag = true;
				}
			}
			
			
			if(!flag){
				alert("输入的不是合法的页码.");
				$(this).val("");
				return;
			}
			
			//3. 页面跳转
			//var href = "bookServlet?method=getBooks&pageNo=" + pageNo + "&" + $(":hidden").serialize();
			//var href ="http://www.baidu.com";
			//window.location.href = href;
		});
	});
	
	function submitPageNo() {
		if(event.keyCode == 13){
			var href ="http://www.baidu.com";
			window.location.href = href;
		}
	}
	
</script>
</head>




<body>

<center>
	<c:if test="${param.title != null }">
	您已经将${param.title}放到购物车中
	<br><br>
	</c:if>
	
	<c:if test="${!empty sessionScope.ShoppingCart.books}">
	您的购物车中有${sessionScope.ShoppingCart.bookNumber }本书，
	<a href="">查看购物车</a>
	</c:if>
</center>

	<form action="#" method="post">
		Price: <input type="text" size="1" name="minPrice" /> - 
		<input type="text" size="1" name="maxPrice" /> 
		<input type="submit" value="Submit" />
	</form>
	：
	<br>
	<table border="1">
		<tr>
			<td>id</td>
			<td>书名</td>
			<td>简介</td>
			<td>价格</td>
			<td>操作</td>
		</tr>
		<c:forEach items="${booklist}" var="book">
			<tr>
				<td>${book.id}</td>
				<td>${book.bName}</td>
				<td>${book.description}</td>
				<td>${book.price}</td>
				<td>
				<a href="delete.do?id=${book.id}">删除</a>
				&nbsp;&nbsp;&nbsp; 
				<a href="modify.jsp?id=${book.id}&bName=${book.bName}&description=${book.description}&price=${book.price}">修改</a>
				&nbsp;&nbsp;&nbsp; 
				<a href="">加入购物车</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<br><br>
	
	共${bookpage.totalPageNumber}页
	&nbsp;&nbsp;&nbsp;
	当前第${pageNo }页
	&nbsp;&nbsp;&nbsp;
	<c:if test="${bookpage.hasPrev }">
	<a href="">首页</a>
	&nbsp;&nbsp;&nbsp;
	<a href="">下一页</a>
	</c:if>
    
    &nbsp;&nbsp;&nbsp;
    
	<c:if test="${bookpage.hasNext }">
		<a href="">下一页</a>
	&nbsp;&nbsp;&nbsp;
	<a href="">末页</a>
	</c:if>
	
	&nbsp;&nbsp;&nbsp;
	
	转到<input type="text" size="1" id="pageNo" onkeypress="submitPageNo()">页



</body>
</html>
