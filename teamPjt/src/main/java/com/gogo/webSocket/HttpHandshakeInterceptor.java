package com.gogo.webSocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import com.gogo.vo.MemberVO;

public class HttpHandshakeInterceptor implements HandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
                                   Map<String, Object> attributes) throws Exception {
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpSession session = servletRequest.getServletRequest().getSession(false);
            if (session != null) {
                String memberId = (String) session.getAttribute("memberId"); // HTTP 세션에서 사용자 이름 가져오기
                MemberVO member = (MemberVO) session.getAttribute("member");
                String roomId = (String) session.getAttribute("roomId");
                String stayNoMsg = (String)session.getAttribute("stayNoMsg");
                String hostMsgPageNo = (String)session.getAttribute("hostMsgPageNo");
                
                attributes.put("memberId", memberId); // WebSocket 세션 속성에 사용자 이름 설정
                attributes.put("member", member); // WebSocket 세션 속성에 사용자 이름 설정
                attributes.put("roomId", roomId);
                attributes.put("stayNoMsg", stayNoMsg);
                attributes.put("hostMsgPageNo", hostMsgPageNo);
                
            }
        }
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception exception) {
    }

}
