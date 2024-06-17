package kr.co.nextus.mypage.refund;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nextus.event.EventVO;
import kr.co.nextus.member.MemberVO;

@Controller
public class RefundController {

	@Autowired
	private RefundService service;
	
	@PostMapping("/refund/insert.do")
	public String insert(Model model, HttpServletRequest request, RefundVO vo) {
		
		int r = service.insert(vo, request);
		int n = service.update(vo);
		if (r > 0 && n > 0) {
			model.addAttribute("cmd", "move");
			model.addAttribute("msg", "환불 신청이 완료되었습니다.");
			model.addAttribute("url", "/mypage/orderlist.do");
		} else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "등록 오류");
		}
		return "common/alert";
	}
}