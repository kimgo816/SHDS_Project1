<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 헤더푸터 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="/resources/css/header.css">

<link rel="stylesheet" href="/resources/css/reset.css" />
<link rel="stylesheet" href="/resources/css/style.css" />
<!--부트스트랩 Libs CSS -->
<link rel="stylesheet" href="/resources/css/board/libs.bundle.css" />
<!--부트스트랩 Theme CSS -->
<link rel="stylesheet" href="/resources/css/board/theme.bundle.css" />
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function zipcodef() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                /*
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                */
                $('#zipcode').val(data.zonecode);
                $('#addr1').val(roadAddr);
            }
        }).open();
    }
	</script>
	


<style>
	.form-groupbirth select {
          margin-right: 16px;
          width: 90px;
          height: 50px; 
          padding: 5px; /* 내부 여백 추가 */
          font-size: 16px; /* 글자 크기 조정 */
      }
</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	
	<!-- MODALS -->

    <!-- BREADCRUMB -->
    <nav class="py-5">
      <div class="container">
        <div class="row">
          <div class="col-12">

            <!-- Breadcrumb -->
            <ol class="breadcrumb mb-0 fs-xs text-gray-400">
              <li class="breadcrumb-item">
                <a class="text-gray-400" href="index.html">Home</a>
              </li>
              <li class="breadcrumb-item active">
                마이페이지
              </li>
            </ol>

          </div>
        </div>
      </div>
    </nav>

    <!-- CONTENT -->
    <section class="pt-7 pb-12">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">내 정보 수정</h3>

          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-3">

            <!-- Nav -->
            <nav class="mb-10 mb-md-0">
              <div class="list-group list-group-sm list-group-strong list-group-flush-x">
                <a class="list-group-item list-group-item-action dropend-toggle active" href="orderlist.do">
                  주문 내역
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="wishlist.do">
                  찜 목록
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="pinfo.do">
                  내 정보 수정
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-address.html">
                  문의 내역
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-payment.html">
                  보유 쿠폰
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle" href="#!">
                  회원 탈퇴
                </a>
              </div>
            </nav>

          </div>
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">

            <!-- Form -->
            <form method="post" id="frm" name="frm" action="/pinfo/update.do" enctype="multipart/form-data">
              <div class="row">
                <div class="col-12 col-md-6">

                  <!-- 이름 -->
                  <div class="form-group">
                    <label class="form-label" for="accountFirstName">
                      이름 *
                    </label>
                    <input class="form-control form-control-sm" id="accountFirstName" name="name" type="text" placeholder="이름" value="${member.name }"required>
                  </div>

                </div>

                <div class="col-12 col-md-6"></div>

                <div class="col-12 col-md-6">

                  <!-- 닉네임 -->
                  <div class="form-group">
                    <label class="form-label" for="accountFirstName">
                      닉네임 *
                    </label>
                    <input class="form-control form-control-sm" id="accountFirstName" name="nickname" type="text" placeholder="닉네임" value="${member.nickname }" required>
                  </div>

                </div>

                <div class="col-12">

                  <!-- 이메일 -->
                  <div class="form-group">
                    <label class="form-label" for="accountEmail">
                      이메일 *
                    </label>
                    <input class="form-control form-control-sm" id="accountEmail" name="email" type="email" placeholder="이메일" value="${member.email }" required>
                  </div>

                </div>
                <div class="col-12 col-md-6">

                  <!-- 현재 비밀번호 -->
                  <div class="form-group">
                    <label class="form-label" for="accountPassword">
                      현재 비밀번호 *
                    </label>
                    <input class="form-control form-control-sm" id="pwd" name="pwd" type="password" placeholder="Current Password *" required>
                  </div>

                </div>
                <div class="col-12 col-md-6">

                  <!-- 새 비밀번호 -->
                  <div class="form-group">
                    <label class="form-label" for="AccountNewPassword">
                      새 비밀번호 *
                    </label>
                    <input class="form-control form-control-sm" id="newpwd" name="newpwd" type="password" placeholder="New Password *" required>
                  </div>

                </div>

                <div class="col-12 col-md-6">

                  <!-- 전화번호 -->
                  <div class="form-group">
                    <label class="form-label" for="accountFirstName">
                      전화번호 *
                    </label>
                    <input class="form-control form-control-sm" id="accountFirstName" name="hp" type="text" placeholder="전화번호" value="${member.hp }" required>
                  </div>

                </div>


                <div class="col-12 col-lg-6">

                  <!-- 생년월일 -->
                  <div class="form-group">

                    <!-- Label -->
                    <label class="form-label">생년월일 ${member.birthday }</label>
					
			        <script>
				        var member = {
				            birthday: '${member.birthday}'
				        };
				    </script>
                    <!-- Inputs -->
                    <div class="row gx-5">

                      <div class="form-groupbirth">
                     
			            <select id="year">
			                <!-- 년도 옵션 추가 -->
			                <!-- 년도 넣기 -->
			                <script>
			                    var startYear = 1930;
			                    var endYear = new Date().getFullYear();
			                    for (var year = startYear; year <= endYear; year++) {
			                        document.write('<option value="' + year + '">' + year + '년'+'</option>');
			                    }
			                    
			                 	// 기본값 설정
			                    var defaultYear = member.birthday.split('-')[0];
			                 	console.log(defaultYear);
			                    document.getElementById('year').value = defaultYear;
			                
			                </script>
			            </select>
			
			            <select id="month">
			                <!-- 월 옵션 추가 -->
							<script>
					            for (var month = 1; month <= 12; month++) {
			                        document.write('<option value="' + month.toString().padStart(2, '0') + '">' + month + '월' +'</option>');
			                    }
			                	var defaultMonth = member.birthday.split('-')[1];
			                	console.log(defaultMonth);
			                	document.getElementById('month').value = defaultMonth.padStart(2, '0');
			            	</script>
			            </select>
			            
			
			
			            <select id="day">
			                <!-- 일 옵션 추가 -->
			                <script>
			                    for (var day = 1; day <= 31; day++) {
			                        document.write('<option value="' + day.toString().padStart(2, '0') + '">' + day + '일' +'</option>');
			                    }
			                 	// 기본값 
			                    var defaultDay = member.birthday.split('-')[2];
			                    console.log(defaultDay);
			                    document.getElementById('day').value = defaultDay.padStart(2, '0');
			                </script>
			            </select>
			        </div>
			        
			        <!-- 년,월,일을 합쳐서 형식에 맞게 전송 -->
			        <input type="hidden" id="birthday" name="birthday">
			        <script>
				        var year = document.getElementById('year').value;
			            var month = document.getElementById('month').value;
			            var day = document.getElementById('day').value;
			        	var birthdate = year + '-' + month.padStart(2, '0') + '-' + day.padStart(2, '0');
			        	document.getElementById('birthday').value = birthdate;
			        	console.log(birthdate);
			        </script>
			        
      				</div>
                  </div>
                </div>
                
                <div class="col-12 col-lg-6">

                  <!-- 성별 -->
                  <div class="form-group mb-8">

                    <!-- Label -->
                    <label class="form-label">성별</label>

                    <!-- Inputs -->
                    <div>

                      <!-- Male -->
                      <input class="btn-check" type="radio" name="gender" value=1 id="male">
                      <label class="btn btn-sm btn-outline-border" for="male">Male</label>

                      <!-- Female -->
                      <input class="btn-check" type="radio" name="gender" value=2 id="female">
                      <label class="btn btn-sm btn-outline-border" for="female">Female</label>

                    </div>

                  </div>
                </div>
                <script>
				  document.addEventListener("DOMContentLoaded", function() {
				    var gender = ${member.gender}; // Assuming ${member.gender} holds the value 1 or 2
				
				    if (gender === 1) {
				      document.getElementById("male").checked = true;
				    } else if (gender === 2) {
				      document.getElementById("female").checked = true;
				    }
				  });
				</script>
                

                <div class="col-12">

                  <!-- 기본주소 -->
                  <div class="form-group">
                    <label class="form-label">
                      기본주소 * 
                    </label>
                    <input class="form-control form-control-sm" id="addr1" name="addr1" type="text" placeholder="기본주소 *" value="${member.addr1 }" required>
                  </div>
                  
                  <div class="input-group-append">
	                <button class="btn btn-outline-secondary" type="button" onclick="javascript:zipcodef();">우편번호 찾기</button>
	            </div>
                  

                </div>

                <div class="col-12 col-md-6">

                  <!-- 상세주소 -->
                  <div class="form-group">
                    <label class="form-label" for="accountFirstName">
                      상세주소 *
                    </label>
                    <input class="form-control form-control-sm" id="addr2" name="addr2" type="text" placeholder="상세주소 *" value="${member.addr2 }" required>
                  </div>

                </div>

                <div class="col-12 col-md-6">

                  <!-- 우편번호 -->
                  <div class="form-group">
                    <label class="form-label" for="accountFirstName">
                      우편번호 *
                    </label>
                    <input class="form-control form-control-sm" id="zipcode" name="zipcode" type="text" placeholder="우편번호 *" value="${member.zipcode }" required>
                  </div>

                </div>
                
                <!-- 프로필 사진 수정 -->
                <div class="col-12">
               	  <div class="form-group">
                	<label class="form-label" for="accountFirstName">
                      프로필 사진 수정 *
                    </label>
                    <input class="form-control form-control-sm" type="file" name="file" id="file"/>
				  </div>
				</div>
                <div class="col-12">

                  <!-- 제출버튼 -->
 
				  <button type="button" class="btn btn-dark" onclick="javascript:checkpwd();">Save Changes</button>
                  

                </div>
              
            </form>
          </div>
        </div>
      </div>
    </section>
	
    <%@ include file="/WEB-INF/views/include/footer.jsp"%>
    
    <!--부트스트랩 JAVASCRIPT -->
	<!-- Map (replace the API key to enable) -->
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCnKt8_N4-FKOnhI_pSaDL7g_g-XI1-R9E"></script>

	<!-- Vendor JS -->
	<script src="/resources/js/board/vendor.bundle.js"></script>

	<!-- Theme JS -->
	<script src="/resources/js/board/theme.bundle.js"></script>
	
	<!-- 폼 제출 js -->
	<script type="text/javascript">
		function checkpwd() {
			if ($("#pwd").val() != '') {
				var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/;
	    		if ($("#pwd").val().match(reg) == null || $("#newpwd").val().match(reg) == null) {
	    			alert('비밀번호는 영문+숫자 조합으로 8자이상 입력하세요');
	    			$("#pwd").val('');
	    			$("#newpwd").val('');
	    			return;
	    		}
			}
			console.log($("#pwd").val());
			$.ajax({
	            url: '/pinfo/checkpwd.do',
	            type: 'POST',
	            data: {
	            	pwd: $("#pwd").val()
	            },
	            success: function(response) {
	            	if (response === 'success') {
	                    $("#frm").submit();
	                } else {
	                    alert('현재 비밀번호가 일치하지 않습니다.');
	                }
	            },
	            error: function(xhr, status, error) {
	            	alert('서버와의 통신에 문제가 발생했습니다.');
	            }
	          });
		}
	</script>

	
</body>
</html>