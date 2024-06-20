<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head> 
    <meta charset="utf-8">
    <title></title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
	
	<link rel="stylesheet" type="text/css" href="/resources/css/footer.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/header.css">
	<link rel="stylesheet" href="/resources/css/reset.css"/>
	<link rel="stylesheet" href="/resources/css/style.css"/>
	<link rel="stylesheet" href="/resources/css/contents.css"/>

    <style>
        .answer-box {
            border: 1px solid #ccc;
            padding: 20px;
            margin-top: 20px;
            background-color: #f9f9f9;
            position: relative;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .answer-box .answer-text {
            flex: 1;
        }

        .answer-box .btnSet {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .answer-box .btnSet a {
            display: block;
            width: fit-content;
        }
    </style>

<script>
$(document).ready(function() {
    $('.btn-reply').click(function(e) {
        e.preventDefault();
        
        // 기존 답변 박스를 숨깁니다.
        $(this).closest('.answer-box').hide();

        if ($('#replyBox').length === 0) {
            var answerText = $(this).closest('.answer-box').find('.answer-text').text().trim();
            var replyBoxHtml = '<div id="replyBox">' +
                               '<textarea id="answer" style="width: 100%; height: 100px;">' + answerText + '</textarea>' +
                               '<div style="text-align: right; margin-top: 10px;">' +
                               '<button id="submitReply" class="btn">등록</button>' +
                               '<button id="cancelReply" class="btn">취소</button>' +
                               '</div>' +
                               '</div>';
            $('.cont').after(replyBoxHtml);

            $('#cancelReply').click(function() {
                $('#replyBox').remove();
                $('.answer-box').show(); // 취소 시 다시 기존 답변 박스를 보여줍니다.
            });

            $('#submitReply').click(function() {
                var answer = $('#answer').val();
                var no = '${vo.no}';
                
                if (answer.trim() !== "") {
                    $.ajax({
                        url: '/adqna/answer.do',
                        type: 'POST',
                        data: { answer: answer, no: no },
                        success: function(answer) {
                            alert('답변이 등록되었습니다.');
                            $('#replyBox').remove();
                            var answerBoxHtml = '<div class="answer-box">' +
                                                '<div class="answer-text">' +'<div>답변 : </div>'+ answer.answer + '</div>' +
                                                '<div class="btnSet">' +
                                                '<a href="#" class="btn btn-reply">수정</a>' +
                                                '<a href="#" class="btn btn-delete">삭제</a>' +
                                                '</div>' +
                                                '</div>';
                            $('.cont').after(answerBoxHtml);
                        },
                        error: function() {
                            alert('답변 등록에 실패했습니다.');
                        }
                    });
                } else {
                    alert('답변을 입력하세요.');
                }
            });
        }
    });

    $('.btn-delete').click(function(e) {
        e.preventDefault();
        var no = '${vo.no}';
        
        $.ajax({
            url: '/adqna/delete.do',
            type: 'POST',
            data: { no: no },
            success: function(response) {
                alert('삭제되었습니다.');
                window.location.href = 'view.do?no=${vo.no}';
            },
            error: function() {
                alert('삭제에 실패했습니다.');
            }
        });
    });
});
</script>
</head> 
<body>
    <div class="wrap">
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">고객센터(QnA)</h3>
                <div class="bbs">
                    <div class="view">
                        <div class="title">
                            <dl>
                                <dt>${vo.title }</dt>
                                <dd class="date">작성일 : <fmt:formatDate value="${vo.write_date }" pattern="yyyy-MM-dd HH:mm:ss"/> </dd>
                            </dl>
                        </div>
                        <div class="cont">${vo.text }</div>                 
                        <div class="btnSet clear">
                            <!-- Answer Box -->
                            <c:if test="${not empty vo.answer}">
                                <div class="answer-box">
                                    <div class="answer-text">${vo.answer}</div>
                                    <div class="btnSet">
                                        <a href="#" class="btn btn-reply">수정</a>
                                        <a href="#" class="btn btn-delete">삭제</a>
                                    </div>
                                </div>
                            </c:if>
                            <!-- End of Answer Box -->
                            <br>
                            <div class="fl_l">
                                <a href="index.do" class="btn">목록</a>
                                <c:if test="${empty vo.answer}">
                                    <a href="#" class="btn btn-reply">답변하기</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    </div>
</body> 
</html>