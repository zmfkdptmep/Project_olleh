<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple Chatbot</title>
    <style>
        #chatbox {
            width: 400px;
            height: 400px;
            border: 1px solid #ccc;
            overflow-y: scroll;
            padding: 10px;
            margin-bottom: 10px;
        }
        .user, .bot {
            margin: 5px;
            padding: 5px;
            border-radius: 5px;
        }
        .user {
            background-color: #e6f7ff;
            text-align: right;
        }
        .bot {
            background-color: #fff2e6;
        }
    </style>
</head>
<body>

<div id="chatbox">
    <!-- Chat messages will appear here -->
</div>

<input type="text" id="userInput" placeholder="메세지를 입력하세요" style="width: 325px;">
<button onclick="sendMessage()">전송</button>

<script>
    function appendMessage(role, content) {
        const chatbox = document.getElementById('chatbox');
        const messageDiv = document.createElement('div');
        messageDiv.className = role;
        messageDiv.innerText = content;
        chatbox.appendChild(messageDiv);
        chatbox.scrollTop = chatbox.scrollHeight;
    }

    function sendMessage() {
        const input = document.getElementById('userInput');
        const userMessage = input.value;
        appendMessage('user', userMessage);

        // Call your backend service
        fetch('/chat/ask', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({ message: userMessage })
        })
        .then(response => response.json())
        .then(data => {
        	console.log(data);
            appendMessage('bot', data.message); // assuming the response contains a field called 'response' with the bot's reply
        })
        .catch(error => console.error('Error:', error));

        input.value = '';
    }
</script>

</body>
</html>
