//package kr.co.nextus.member;
//
//import java.io.IOException;
//import javax.servlet.http.HttpSession;
//import org.json.simple.JSONObject;
//import org.json.simple.parser.JSONParser;
//import org.json.simple.parser.ParseException;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import com.github.scribejava.core.model.OAuth2AccessToken;
//
//@Controller
//public class NaverLoginController {
//
//    /* NaverLoginBO */
//    private NaverLoginVO naverLoginVO;
//    private String apiResult = null;
//
//    @Autowired
//    private void setNaverLoginVO(NaverLoginVO naverLoginVO) {
//        this.naverLoginVO = naverLoginVO;
//    }
//
//    //로그인 첫 화면 요청 메소드
//    @RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
//    public String login(Model model, HttpSession session) {
//        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
//        String naverAuthUrl = naverLoginVO.getAuthorizationUrl(session);
//
//        // 네이버
//        model.addAttribute("url", naverAuthUrl);
//
//        return "login";
//    }
//
//    //네이버 로그인 성공시 callback호출 메소드
//    @RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
//    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
//            throws IOException, ParseException {
//
//        System.out.println("여기는 callback");
//        OAuth2AccessToken oauthToken;
//        oauthToken = naverLoginVO.getAccessToken(session, code, state);
//
//        // 1. 로그인 사용자 정보를 읽어온다.
//        apiResult = naverLoginVO.getUserProfile(oauthToken); // String형식의 json데이터
//
//        /** apiResult json 구조
//        {"resultcode":"00",
//         "message":"success",
//         "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
//        **/
//
//        // 2. String형식인 apiResult를 json형태로 바꿈
//        JSONParser parser = new JSONParser();
//        Object obj = parser.parse(apiResult);
//        JSONObject jsonObj = (JSONObject) obj;
//
//        // 3. 데이터 파싱
//        // Top레벨 단계 _response 파싱
//        JSONObject response_obj = (JSONObject) jsonObj.get("response");
//        // response의 nickname값 파싱
//        String nickname = (String) response_obj.get("nickname");
//        System.out.println(nickname);
//
//        // 4.파싱 닉네임 세션으로 저장
//        session.setAttribute("sessionId", nickname); // 세션 생성
//
//        model.addAttribute("result", apiResult);
//
//        return "login";
//    }
//
//    //로그아웃
//    @RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
//    public String logout(HttpSession session) throws IOException {
//        System.out.println("여기는 logout");
//        session.invalidate();
//
//        return "redirect:index.jsp";
//    }
//}