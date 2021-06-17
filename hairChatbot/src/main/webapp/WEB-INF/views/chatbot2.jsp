<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/chat.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/typing.css">

<title>Chatbox</title>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
	chatbotSend();	
	enterkey();
	scroll();
});

//전송버튼
function SendIF(){
	if(document.formupload.file1.value != ""){
		uploadImage();//이미지 전송		
	}else if(inputMessageTest != ""){
		chatbotSend();//텍스트 전송
	}
}
//텍스트 전송
function chatbotSend(){
	//질문 읽기
	var inputMessageTest = $("#inputMessageTest").val();
	if(inputMessageTest != ""){// 입장
		$(".chatbox__messages").append("<div class= 'messages__item messages__item--operator'>"+inputMessageTest + "</div>");
		
	}
	$.ajax({
		 url : "/chatbottest",
		 type : "post",
		 data : {"message" : inputMessageTest},
		 dataType : 'json',
		 success : function(server_response){
			 var bubbles = server_response.bubbles;
				for(var b in bubbles){
					if(bubbles[b].type == 'text'){// 텍스트 답변 처리 시작 
						var description = bubbles[b].data.description;
						var descriptionResult ="";
						//줄바꿈 처리
						if(description.indexOf("\n") != -1){
							var descriptions = description.split("\n");
							var descriptionResult ="";
							descriptionResult += descriptions[0]+ "<br>" + descriptions[1];		
						}else{
							descriptionResult = description;
						}
						$(".chatbox__messages").append("<div class= 'messages__item messages__item--visitor'>"+descriptionResult +  "</div>");

						if(bubbles[b].data.url != null){//url 있으면
							$(".chatbox__messages").append
							("<div class= 'messages__item messages__item--visitor'><a href='" + bubbles[b].data.url + "'class='linkEffect' target='_blank'>" + bubbles[b].data.url + "</a></div>");
						}//url 있으면 if end
					}//텍스트 답변 처리 종료
					//이미지나 멀티링크 답변
					else if(bubbles[b].type == 'template'){						
						var description = bubbles[b].data.cover.data.description;
						var descriptionResult ="";
						//줄바꿈 처리
						if(description.indexOf("\n") != -1){
							var descriptions = description.split("\n");
							var descriptionResult ="";
							descriptionResult += descriptions[0]+ "<br>" + descriptions[1];		
						}else{
							descriptionResult = description;
						}
						//이미지-이미지로 출력
						if(bubbles[b].data.cover.type == 'image'){
							var linkurl="";
							var linktext="";
							
							for(var ct in bubbles[b].data.contentTable){
								var  ctdata = bubbles[b].data.contentTable[ct];//링크 1개나 버튼 1개
								for(var ctdataindex in ctdata){
									linkurl = ctdata[ctdataindex].data.data.action.data.url;
									linktitle = ctdata[ctdataindex].data.title;
									
									$(".chatbox__messages").append
									("<div class= 'messages__item messages__item--visitor'><img src='" + bubbles[b].data.cover.data.imageUrl 
									+"'style='border-radius : 20px; '><br>" 
									+"<div style='font-weight: bold;'>"+bubbles[b].data.cover.title +"</div>"
									+descriptionResult + "<br>"
									+ "<a href='" + linkurl + "'class='linkEffect' target='_blank'>" + linktitle + "</a><br>"
									+ "</div>");
								}								
							}//공통 for end							
							
						}
						//멀티링크답변 - 텍스트로 출력
						else if(bubbles[b].data.cover.type == 'text'){
							var linkurl="";
							var linktext="";
							
							$(".chatbox__messages").append
							("<div class= 'messages__item messages__item--visitor'>"+ descriptionResult + "<br>"
							+ "</div>");
							for(var ct in bubbles[b].data.contentTable){
								var  ctdata = bubbles[b].data.contentTable[ct];//링크 1개나 버튼 1개
									
								for(var ctdataindex in ctdata){
									linkurl = ctdata[ctdataindex].data.data.action.data.url;
									linktitle = ctdata[ctdataindex].data.title;
									
									$(".chatbox__messages").append
									("<div class= 'messages__item messages__item--visitor'>"
									+ "<a href='" + linkurl + "'class='linkEffect' target='_blank'>" + linktitle + "</a><br>"
									+ "</div>");
								}							
							}//공통 for end							
							
						}//else if end					
					}//else if end
					
				}//for end
			 },
		 error : function(){
				
		 }, 
		 complete : function(){
			 scroll();
		 }
	});//ajax end
	$("#inputMessageTest").val("");
}

//파일 선택
function fnUpload(){
	$("#file1").click();
}

//파일 전송, CFR
function uploadImage(){				
		var form = $("#uploadForm")[0]
		var data = new FormData(form);
		
		//파일 전송
		$.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "/fileuploadtest",
	        data: data,
	        dataType:"text",
	        processData: false,
	        contentType: false,
	        success: function (data) {
	        	var str="";
	        	//로컬
	        	//str="<img src='/upload/"+data+"'style='border-radius : 20px 20px 0px 20px;width:150px; height:auto;' >";
	        	//tomcat 서버
	        	str="<img src='/file/"+data+"'style='border-radius : 20px 20px 0px 20px;width:150px; height:auto;' >";
	        	$(".chatbox__messages").append("<div class= 'messages__item messages__item--image'>"+str+"</div>"); 
	        	
	        	//cfr 결과값
	        	$.ajax({
	        		type:"GET",
	        		url:"/chatbotfacetest",
	        		data:{"image": data},
	        		dataType: "json",
	        		success: function(response){
	        			/* console.log(response);  */ 		
	        			//데이터가 있는 경우
	        			if(Object.keys(response).length>0){
	        				var faceResult = "";
	        				if(response.info.faceCount == 0){
	        					faceResult ="얼굴인식이 되지 않았습니다.<br> 인물이 나오는 사진으로<br>다시 보내주세요."
	        					$(".chatbox__messages").append
	    	        			("<div class= 'messages__item messages__item--visitor'>"+faceResult + "</div>");
	        					scroll();
	        				}else if(response.info.faceCount > 1){
	        					faceResult ="한 사람만 나오도록 다시 보내주세요."
		        				$(".chatbox__messages").append
		    	        		("<div class= 'messages__item messages__item--visitor'>"+faceResult + "</div>");
		        				scroll();
	        				}else{
	        					
		        				var celebrity = response.faces[0].celebrity.value
		        				var confidence = response.faces[0].celebrity.confidence
		        				//확률 0.3 이상인 경우
		        				if(confidence > 0.3){ 
		        					faceResult += "닮은 연예인: "+ celebrity+"<br>";
			        				faceResult += "닮은 확률: " + Math.round(confidence * 100)+"%"+"<br>";
			        					
			        				$("#inputMessageTest").val(celebrity);
			        				
		        					$(".chatbox__messages").append
		    	        			("<div class= 'messages__item messages__item--visitor'>"+faceResult + "</div>");	
		    	        			chatbotSend();
		        				}else{
		        					faceResult += "닮은 연예인: "+ celebrity+"<br>";
			        				faceResult += "닮은 확률: " + Math.round(confidence * 100)+"%"+"<br>";			        				
		        					faceResult +="인식 결과 닮은 확률이 낮습니다. 다시 보내주세요."
			        				$(".chatbox__messages").append
			    	        		("<div class= 'messages__item messages__item--visitor'>"+faceResult + "</div>");
			        				scroll();
			        				
		        				}//else end		        				
	        				}//else end
	        			}//데이터 있는 경우 if end	        			
	        			
	        		}//cfr 결과값 ajax success end
	        	}); //cfr 결과값 ajax end
	        }, //파일 전송 ajax success end
	        error: function () {
	        	
	        }
	    });//파일 전송 ajax end
		$("#inputMessageTest").val("");
		$("#file1").val("");
		$("#fileNm").val("");

} //uploadImage end

//엔터키 입력
function enterkey(){	
	$(document).on('keydown', '#inputMessageTest', function(e){
		if(e.keyCode == 13 && !e.shiftKey){
			e.preventDefault();
			chatbotSend();
		}
	});	
}
//스크롤 
function scroll(){
	$('.chatbox__messages').animate( {scrollTop:9999}, 400);
	$("#inputMessageTest").click(function(){
		$('.chatbox__messages').animate( {scrollTop:9999}, 400);
	});
}
//웹캠 팝업창 실행
function showPopup(){
	window.open("cameratest", "a", "width=400, height=400, left=100, top=50");
}

</script>
</head>
<body>

<div class="container">
        <div class="chatbox">
            <div class="chatbox__support">
                <div class="chatbox__header">
                    <div class="chatbox__image--header">
                        <img src="<%=request.getContextPath() %>/resources/imgs/Yellow_Comb_Salon_Beauty_Logo2.png" alt="image">
                    </div>
                    <div class="chatbox__content--header">
                        <h4 class="chatbox__heading--header">어떡헤어 챗봇</h4>
                        <div class="chatbox__description--header">
                            <p>헤어스타일 추천 서비스입니다.</p>
                            <p>원하시는 서비스를 선택해주세요.</p>
                        </div>
                    </div>
                </div>
                <div class="chatbox__messages" onscroll="scroll()">                       
                       
                </div>
                <div class="chatbox__footer">
                    <img class="chatbox__camera--footer" src="<%=request.getContextPath() %>/resources/imgs/screenshot-32.png" alt="" onclick="showPopup()">
                    <dir class="chatbox__inputbox">
                        <input type="text" id="inputMessageTest" placeholder="메시지를 입력하세요...">
                    </dir>
                    <img class="chatbox__send--footer" src="<%=request.getContextPath() %>/resources/imgs/paper-plane-32.png" alt="" onclick="SendIF()"></img>                  
                                                           
                    <form name="formupload" method="post" enctype="multipart/form-data" id="uploadForm" class="clipform">
                    	<input type="text" id="fileNm" style="display:none;" readonly>
                   	 	<a id="clipImg" href="javascript:fnUpload();"><img class="chatbox__clip--footer" src="<%=request.getContextPath() %>/resources/imgs/paper-clip-2-18.png" alt=""></img></a>
						<input type="file" id = "file1" name="file1" style="display:none;" onchange="$('#fileNm').val(this.value)">						
					</form>
                    
                </div>
            </div>
            <div class="chatbox__button">
                <button>button</button>
            </div>
        </div>       
    </div>
    <script src="<%=request.getContextPath() %>/resources/js/Chat.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/app.js"></script>
</body>
</html>