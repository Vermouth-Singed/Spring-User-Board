<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>연습</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#but").click(function(){
		var formData = new FormData();
		var file1 = document.getElementById("file1");
		var file2 = document.getElementById("file2");

		formData.append("file1", file1.files[0]);
		formData.append("file2", file2.files[0]);

		if(file1.files.length > 0 && 
			file1.files[0].name.substring(file1.files[0].name.lastIndexOf(".")+1) == "jpg" ||
			file2.files.length > 0 && 
			file2.files[0].name.substring(file2.files[0].name.lastIndexOf(".")+1) == "jpg"){ // jsp 에 jpg 로 하드코딩
		
			$.ajax({
	             url: "add_data2.do",
	             data: formData,
	             processData: false,
	             contentType: false,
	             type: 'POST',
	             success: function(data){                  
	                 if(data == "OK")
	                    location.href = "add_data.do"; // 성공하면 화면 새로고침, 기존에 파일 안지워도 자동 덮어쓰기
	             }
	         });
		}
	});
});
</script>
<style type="text/css">
</style>
</head>
<body>
<%@ include file="../../../index.jsp"%><br/><br/><br/>
<h3 align = "center">
	<input type="file" name="file1" id = "file1"><br/><br/>
	<input type="file" name="file2" id = "file2"><br/><br/>
	<input type = "button" id = "but" value = "등록">
</h3>
<div align = "center">
	<img src = "../../../img/daeman.jpg"/>
</div>
<br/><br/>
<div align = "center">
	<img src = "../../../img/mikuk.jpg"/>
</div>
</body>
</html>