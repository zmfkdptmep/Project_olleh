<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple Chatbot</title>
    <style>
        #chatbox {
            width: 900px;
            height: 600px;
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
            overflow:auto;
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
            line-height:50px;
        }
            /* 코드블록 스타일 */
    pre {
        background-color: #f8f8f8;  /* 배경색 */
        border: 1px solid #ccc;     /* 테두리 */
        padding: 8px 12px;          /* 내부 여백 */
        overflow-x: auto;           /* 긴 코드의 경우 스크롤바 생성 */
        border-radius: 4px;         /* 둥근 테두리 */
        max-width: 100%;            /* 최대 너비 */
    }

    code {
        font-family: 'Courier New', Courier, monospace; /* 고정 너비 글꼴 */
        color: #333;                                  /* 글자색 */
    }
    </style>
</head>
<body>
		    	<button style="padding-bottom:10px; background-color:white; border:0px; cursor: pointer; position:absolute; top:7%; right:0%;" type="button" class="btn_close" id="closeChatBot">
		    	<img src="/resources/images/closeBtn.JPG">
		    	</button>
<div id="chatbox">

    <!-- Chat messages will appear here -->
</div>

<input type="text" id="userInput" placeholder="메세지를 입력하세요" style="width: 325px; border:1px solid #f2f2f2;">
<button onclick="sendMessage()" style="padding:22px;">전송</button>

<script>

	//엔터키로 바로 전송
	document.getElementById('userInput').addEventListener('keydown', function(event) {
	    if (event.keyCode === 13 && document.activeElement === this) {
	        enterMsg = '';
	        if ($("#userInput").val().trim() !== '') {
	            // 길이 제한
	            if ($("#userInput").val().length > 85) {
	                $("#userInput").val('메세지는 85자를 초과할 수 없습니다.');
	            } else {
	                sendMessage();
	                $('#userInput').val('');
	            }
	        }
	    }
	});



	function escapeHtml(unsafe) {
	    return unsafe
	        .replace(/&/g, "&amp;")
	        .replace(/</g, "&lt;")
	        .replace(/>/g, "&gt;")
	        .replace(/"/g, "&quot;")
	        .replace(/'/g, "&#039;");
	}

	function appendMessage(role, content) {
	    const chatbox = document.getElementById('chatbox');
	    const messageDiv = document.createElement('div');
	    messageDiv.className = role;

	    const codeBlockRegex = /```(\w+)?\n?([\s\S]*?)```/g;

	    let lastIndex = 0;

	    let match;
	    while ((match = codeBlockRegex.exec(content)) !== null) {
	        const beforeCodeBlock = content.substring(lastIndex, match.index);
	        if (beforeCodeBlock) {
	            messageDiv.appendChild(document.createTextNode(beforeCodeBlock));
	        }

	        lastIndex = match.index + match[0].length;

	        const language = match[1];
	        const codeContent = match[2];

	        const preElement = document.createElement('pre');
	        const codeElement = document.createElement('code');

	        if (language) {
	            const titleDiv = document.createElement('div');
	            titleDiv.innerText = language;
	            titleDiv.style.backgroundColor = "#333"; 
	            titleDiv.style.color = "white"; 
	            titleDiv.style.padding = "5px"; 
	            titleDiv.style.borderTopLeftRadius = "5px"; 
	            titleDiv.style.borderTopRightRadius = "5px";
	            preElement.appendChild(titleDiv);
	        }

	        codeElement.innerText = codeContent;
	        preElement.appendChild(codeElement);
	        messageDiv.appendChild(preElement);
	    }

	    const afterLastCodeBlock = content.substring(lastIndex);
	    if (afterLastCodeBlock) {
	        messageDiv.appendChild(document.createTextNode(afterLastCodeBlock));
	    }

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
