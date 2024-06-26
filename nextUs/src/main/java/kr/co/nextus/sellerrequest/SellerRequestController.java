package kr.co.nextus.sellerrequest;



import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.nextus.buylist.BuyListService;
import kr.co.nextus.buylist.BuyListVO;




@Controller
public class SellerRequestController {

	@Autowired
	private SellerRequestService service;
	@Autowired
	private BuyListService BLservice;



	
	@GetMapping("/sellerRequestManagement")
	@RequestMapping("/sellerRequestManagement")
	public String sellerRequestManagement(SellerRequestVO vo,
			BuyListVO vo3, Model model,HttpServletRequest request) {
		Boolean adminLoggedIn = (Boolean) request.getSession().getAttribute("adminLoggedIn");
		if(adminLoggedIn!= null && adminLoggedIn) {
			model.addAttribute("sellerRequestMap", service.list(vo));
			model.addAttribute("SRnew", service.NEW(vo));
			model.addAttribute("STnew", BLservice.settleNEW(vo3));
			model.addAttribute("RFnew", BLservice.refundNEW(vo3));
			return "admin/sellerManagement/sellerRequestManagement";
		}else {
			return "common/403";
		}
		
	}
	

	
	@RequestMapping("/sellerRequestPopup")
	public String sellerRequestPopup(SellerRequestVO vo,Model model,HttpServletRequest request,@RequestParam("no") int no) {
		Boolean adminLoggedIn = (Boolean) request.getSession().getAttribute("adminLoggedIn");
		if(adminLoggedIn!= null && adminLoggedIn) {
			model.addAttribute("map", service.list(vo,no));
			return "admin/sellerManagement/sellerRequestPopup";
		}else {
			return "common/403";
		}
		
	}
	
	
	
	@PostMapping("/requestApprove.do")
	public String requestApprove(SellerRequestVO vo,Model model,
									@RequestParam(name = "memberno")int memberno,
									@RequestParam(name = "bank")String bank,
									@RequestParam(name = "account")String account) {
		vo.setBank(bank);
		vo.setAccount(account);
		model.addAttribute("sellerRequest", service.approve(vo,memberno));
		
		model.addAttribute("msg", "승인 완료!");
		return "common/alertThenClose";
	}
	
	@PostMapping("/requestDeny.do")
	public String requestDeny(SellerRequestVO vo,Model model, @RequestParam(name = "memberno")int memberno) {
		model.addAttribute("sellerRequest", service.deny(vo,memberno));
		
		model.addAttribute("msg", "승인을 거부했습니다");
		return "common/alertThenClose";
	}
}
