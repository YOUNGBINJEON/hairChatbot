package ai.project;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatbotControllerTest {
	
	@Autowired
	NaverChatbotServiceTest chatbotservice;
	
	@Autowired
	@Qualifier("faceService")
	NaverFaceServiceTest faceservice; // 유명인 얼굴 인식 
	
	@RequestMapping("/cameratest")
	public String cameratest() {
		return "cameratest";
	}
	
	@RequestMapping("/chatbot2")
	public String chatbot2() {
		return "chatbot2";
	}
	
	@RequestMapping("/login")
	public String loginpage() {
		return "login";
	}
	
	@RequestMapping("/signup")
	public String signuppage() {
		return "sign_up";
	}
	
	@RequestMapping("/LoginAction")
	public String LoginActionpage() {
		return "LoginAction";
	}
	
	@RequestMapping("/JoinAction")
	public String JoinActionpage() {
		return "JoinAction";
	}
	
	@RequestMapping("/chatbottest")
	@ResponseBody
	public String chatbot(String message) {// 클라이언트 질문 없으면 open , 있으면 send
		String action = null;
		if(message == "") {
			action = "open";
		}
		else {
			action = "send";
		}
		String chatbotResult = chatbotservice.test(message, action);
		return chatbotResult;
	}	 
	
	//이미지 파일 업로드 
	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-","").substring(0,10);
	}
	
	@RequestMapping("/fileuploadtest")
	@ResponseBody
	public String uploadresult(@ModelAttribute("vo") UploadVOTest vo) throws IOException{
		//업로드한 파일 객체로 선언
		MultipartFile multipartfile1= vo.getFile1();		
		System.out.println(multipartfile1.getOriginalFilename());		
		//업로드한 파일명 추출(=클라이언트원본파일명)
		String filename1 = multipartfile1.getOriginalFilename();
		
		Path path = Paths.get(filename1);
		System.out.println("path: "+path.toAbsolutePath()); 
		
		//서버 저장 경로 설정
		String savePath = "tmp/tomcat.8080.***/work/Tomcat/localhost/ROOT/" + "\\";		
		//서버저장파일명(클라이언트원본파일명).확장자		
		// 중복파일처리1 : 
		String ext1 = filename1.substring(filename1.lastIndexOf("."));				
		System.out.println("확장자: "+ext1);
		filename1 = getUuid() + "("+ multipartfile1.getOriginalFilename() + ")" + ext1;
		System.out.println("파일 이름: "+filename1);	
		System.out.println("이미지 경로: "+savePath + filename1);	
		File file1 = new File(savePath + filename1);
		//서버 지정 경로에 파일 저장
		multipartfile1.transferTo(file1);
		
		//return "이미지 잘받았습니다"; //파이썬과 연결, @ResponseBody 추가
		return filename1;
	}
	
	//유명인 인식 결과
	@RequestMapping("/chatbotfacetest")
	@ResponseBody	
	public String face(String image) {// 경로없이 파일명만 전달
		String result = faceservice.test(image);
		return result;
	}
}

