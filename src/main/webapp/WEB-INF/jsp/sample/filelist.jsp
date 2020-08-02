<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>
<%
	Connection con = null;
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection(
				"jdbc:oracle:thin:@127.0.0.1:1521:xe", "noaa", "noaa");
	}
	catch (Exception e) {e.printStackTrace();}
	Statement st = con.createStatement();
	String sql = "select * from menu_list";
	ResultSet rs = st.executeQuery(sql);
%>
<!doctype html>
<html>
<head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.32/angular.min.js"></script>
<script>
document.oncontextmenu = new Function("return false");
var app = angular.module('app', []);

app.controller('MainCtrl', function($scope) {
  $scope.menus = [
      <% while(rs.next()){%>
      {
        place: "<%=rs.getString("place")%>",
        menu: "<%=rs.getString("menu")%>",
        price: <%=rs.getInt("price")%>
      },
      <% } %>
      {
          place: "집", menu: "밥", price: 0
      }
    ];
});
</script>
<link rel="stylesheet" type="text/css" href="/first/common.css">
<style>
input[type=button]{
	height:34px;
  	width:60px;
  	background:#1E7493;
  	border:0;
  	font-size:12px;
  	border-radius:5px;
  	color:white;
}
input[type=button]:hover{
	color:white;
	background:#3DBCE0;
}
input[type=button]:active{
  	position: relative;
  	top: 2px;
  	left: -1px;
}
table{font-family: 'Nanum Gothic Coding', monospace;}
table.list tr:nth-child(2n-1){background:#EAEAEA;}
</style>
<title>등록현황</title>
</head>
<body ng-app="app" ng-controller="MainCtrl">
<%@ include file="../../../index.jsp"%><br/>
<h1 align = "center" id = "title">등록 현황<br/>
<input ng-model="search" type="text" placeholder = "사무용품 검색 가능!!"/></h1>
	<div align="center">
		<table style="width: 20%" class = "list">
			<tr align="center">
				<td class="top" width="25%">식당</td>
				<td class="top" width="60%">메뉴</td>
				<td class="top">가격</td>
			</tr>
			<tr ng-repeat="m in menus | filter:search" align="center">
				<td>{{ m.place }}</td>
				<td>{{ m.menu }}</td>
				<td>{{ m.price }}</td>
			</tr>
		</table>
	</div>
</body>
</html>