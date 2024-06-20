package kr.co.nextus.buylist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.nextus.sellerrequest.SellerRequestService;
import kr.co.nextus.sellerrequest.SellerRequestVO;

@Controller
public class BuyListController {

	@Autowired
	private BuyListService service;

	@Autowired
	private SellerRequestService SRservice;

	@RequestMapping("/sellerSettlement")
	public String sellerSettlement(BuyListVO vo, SellerRequestVO vo2, Model model) {
		model.addAttribute("map", service.list(vo));
		model.addAttribute("sellerRequestMap", SRservice.list(vo2));
		return "admin/adjustManagement/sellerSettlement";
	}

	// 정산하기
	@RequestMapping(value = "/settle/{buyno}", method = RequestMethod.POST)
	@ResponseBody
	public String settle(@PathVariable("buyno") int buyno) {

		try {
			service.settle(buyno);
			return "success"; // 성공 시 success 문자열 반환
		} catch (Exception e) {
			return "error"; // 실패 시 error 문자열 반환
		}

	}

}