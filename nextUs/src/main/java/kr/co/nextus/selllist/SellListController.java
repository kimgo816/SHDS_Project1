package kr.co.nextus.selllist;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nextus.event.EventVO;
import kr.co.nextus.member.MemberVO;
import kr.co.nextus.mypage.wishlist.WishListService;
import kr.co.nextus.mypage.wishlist.WishListVO;
import kr.co.nextus.notice.NoticeVO;
import kr.co.nextus.selllist.SellListVO;
import kr.co.nextus.selllist.SellListService;
import kr.co.nextus.review.ReviewVO;
import kr.co.nextus.sellerrequest.SellerRequestService;
import kr.co.nextus.sellerrequest.SellerRequestVO;
import kr.co.nextus.review.ReviewService;


@Controller
public class SellListController {

	@Autowired
	private SellListService sellListService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private WishListService wishListService;
	@Autowired
	private SellerRequestService SRservice;
	
	
	@GetMapping("/selllist/view.do")
	public String detail(Model model, HttpSession sess, @RequestParam("sellno") int sellno, SellListVO vo, ReviewVO rvo, WishListVO wvo) {
		MemberVO login = (MemberVO) sess.getAttribute("login");
		rvo.setSellno(sellno);
		vo.setSellno(sellno);
		wvo.setSellno(sellno);
		
		if(login == null) {
			vo.setLoginno(0);
			wvo.setMemberno(0);
		} else {
			vo.setLoginno(login.getNo());
			wvo.setMemberno(login.getNo());
		}

		SellListVO detail = sellListService.detail(vo);
		
		model.addAttribute("vo", detail);
		model.addAttribute("review", reviewService.list(rvo));
		model.addAttribute("iswishlist", wishListService.count(wvo));
		return "/selllist/view";
	}
	
	
	//관리자
//	@GetMapping("/productManagement.do")
//	public String List(SellListVO vo, Model model) {
//		model.addAttribute("selllist", sellListService.index(vo));
//		return "admin/productManagement/productManagement";
//	}
	
	// 관리자						
	@RequestMapping("/productManagement")						
	public String productManagement(SellListVO vo, SellerRequestVO vo2, Model model) {						
		model.addAttribute("selllist", sellListService.index(vo));					
		model.addAttribute("sellerRequestMap", SRservice.list(vo2));					
		return "admin/productManagement/productManagement";					
	}						
							
	// 판매글삭제						
	@RequestMapping(value = "/deleteSelllist/{sellno}", method = RequestMethod.POST)						
	@ResponseBody						
	public String deleteSelllist(@PathVariable("sellno") int sellno) {						
							
		try {					
			sellListService.deleteSelllist(sellno);				
			return "success"; // 성공 시 success 문자열 반환				
		} catch (Exception e) {					
			return "error"; // 실패 시 error 문자열 반환				
		}					
							
	}						

	
	
}
