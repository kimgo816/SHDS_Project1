package kr.co.nextus.buylist;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BuyListVO {
	private int buyno;
	private int memberno;
	private int optionno;
	private int price;
	// 결제 상태
	private int status;
	private String paymentId;
	private Timestamp buydate;
	private Timestamp decidedate;
	private int sellerno;
	private int sellno;
	//주문자 성함
	private String name;
	private String hp;
	private String email;
	private String addr1;
	private String addr2;
	private int isrevire;
	// 사용한 쿠폰 번호
	private int couponNo; //0번이면 쿠폰안쓴거 
	private int discount; //couponNo면 0 
	private String orderName;
	
	// 상품명
	private String title;
	// 구매자 닉네임
	private String nickname;
	// 옵션 등급 (브,실,골)
	private String optionrank;
	// 옵션 내용
	private String content;

	
	
	
	// 관리자페이지에서 씁니다요
	// 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
	private String searchType;
	private String searchWord;
	private int page; // 사용자가 요청한 페이지 번호
	private int startIdx; // limit 앞에 들어갈 시작인덱스값

	//최근7일 내역볼때
	private int totalprice;
	private Timestamp date;
	
	private String MVP_nickname;
	private int MVP_total;
	private int total_sales;
	private int today_sales;
	
	private String sellerEmail;
	private String account;

	public BuyListVO() {
			this.page = 1;
		}

	public int getStartIdx() {
			return (page-1) * 10;
	}
}
