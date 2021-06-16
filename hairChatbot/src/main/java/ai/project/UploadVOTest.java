package ai.project;

import org.springframework.web.multipart.MultipartFile;

public class UploadVOTest {//uploadform.jsp 4개 전달 받음
	
	MultipartFile file1;
	
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
}
