<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<form method="post" action="/fileuploadAction" enctype="multipart/form-data">
	<input type="file" multiple name="files" value="파일">
	<input type="text" name="stayNo" value="1">
	<input type="text" name="roomNo" value="1">
	
	<button type="submit">전송</button>
</form>
</body>
</html>