<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>챗봇과 대화해 보아요</title>
</head>
<body>
    <h2>OpenAI</h2>
    
    <!-- Form for User Input -->
    <form action="formAsk" method="post">
        <label for="userMessage">질문 :</label>
        <input type="text" id="userMessage" name="userMessage">
        <input type="submit" value="전송">
    </form>

    <!-- Display OpenAI's Response -->
    <h3>답장 :</h3>
    <p>${responseMessage}</p>
    
    
    
    
</body>
</html>
