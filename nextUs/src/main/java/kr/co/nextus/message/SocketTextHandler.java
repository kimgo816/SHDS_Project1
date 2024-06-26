package kr.co.nextus.message;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.nextus.member.MemberVO;

public class SocketTextHandler extends TextWebSocketHandler {
	private final Map<Integer, WebSocketSession> sessions = new HashMap<>();
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	@Autowired
	private MessageService service;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        // 로그인 ID를 세션에 저장하여 사용자 식별   	
        String userId = session.getId();
        System.out.println("이전 " + sessions);
        System.out.println("새 클라이언트와 연결되었습니다: " + userId);
    }

	@Override
	 protected void handleTextMessage(WebSocketSession session, TextMessage message) throws IOException {
        System.out.println(message.getPayload()); // getPayload => 메시지 불러오는 역할
        String payload = message.getPayload();

        // JSON 문자열을 MessageData 객체로 변환
        MessageVO vo = objectMapper.readValue(payload, MessageVO.class);
        
        // 개별 변수로 접근
        if ("connect".equals(vo.getAction())) {
        	int no = vo.getSenderno();
        	sessions.put(no, session);
        	session.getAttributes().put("userNo", no);
        	System.out.println(vo.getSenderno() + "접속");
        	System.out.println("이후 " + sessions);
        } else if ("disconnect".equals(vo.getAction())) {
        	int no = vo.getSenderno();
        	sessions.remove(vo.getSenderno());
        	System.out.println(vo.getSenderno() + "접속해제");
        } else if ("sendMessage".equals(vo.getAction())) {
        	int chatno = vo.getChatno();
        	int senderNo = vo.getSenderno();
            int opNo = vo.getOpno();
            String msg = vo.getContent();
            
            WebSocketSession opSession = sessions.get(opNo);
            
            service.insert(vo);
            System.out.println(sessions);
            System.out.println("insert 완료");
          //접속 해있을 때 찾아야함
            if (opSession != null) {
            	opSession.sendMessage(message);
            	//읽음처리까지
            	service.update(chatno, opNo);
            }
            
        }
        
	}
		
		//sessionId + message 합치서 구분자변수
		//session 구할 수 있다 -> 위에서로 부터
		//sessions.value() 찾으면 좀 구려
		//1. jsp 의 id parameter를 map의 string에 넣어준다.
		//2. A가 B에게 메세지를 보낸다.
		//3-1 웹소켓에 message와 상대의 id 와 있어야해 -> 여기서의 id는 위랑은 다르다.
		//3-2 sessionId opId 나눠줘야해 if (send면?)
		//String id, String message
		//4-1 map에서 찾아 상대id를
		//4-2 찾았는데? 없네? -> query 만 쏴주면 된다.
		//4-3 찾았는데? 있네? -> send도 해주고 query도 쏴주고
		//sessions.containsKey(id);
		//-> String send = "recieve : " + 내id + " " + 상대방id + " " + message;
		//4-4 recieve 구분자를 붙여서 recieve : 보낸사람아이디 받는사람아이디 메세지
		//5-1 위에서 받은 메세지를 잘 변형 변수로 recieve 구분자 -> if(recieve면?)
		//5-2 보낸사람 받는사람 메세지 다 있어 if(내 세션이 받는사람 세션이야) 어? 나네?
		//5-3 내 세션.sendMessage(message);
		


	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
		int userNo = (int) session.getAttributes().get("userNo");
		sessions.remove(userNo);
		System.out.println(userNo + "접속해제");
		System.out.println("해제이후 " + sessions);
		System.out.println("특정 클라이언트와의 연결이 해제되었습니다.");
	}
}
