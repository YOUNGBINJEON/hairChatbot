package ai.project;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import org.springframework.stereotype.Service;

@Service("faceService")
public class NaverFaceServiceTest implements NaverService{

	@Override
	public String test(String image) {
		StringBuffer response = new StringBuffer();
        StringBuffer reqStr = new StringBuffer();
        String clientId = "uv7pdvhwqr";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "1lepueFpqJ2EIIlXyTx9NhPRSNBlDi0kLpN6WUpM";//애플리케이션 클라이언트 시크릿값";

        try { //<form method = post endtype = "multipart/form-data <input type = file name = "image"
            String paramName = "image"; // 파라미터명은 image로 지정
            //String imgFile = "C:/Users/parksoyeon/Desktop/images/"+image;
            String imgFile = "C:/upload/"+image;
            //1. 다른 유명인 사진 2. 내 사진(confidence값 확인) 3. 동물 사진(face 비었음) 4. 사물 사진(오류)
            File uploadFile = new File(imgFile);
            String apiURL = "https://naveropenapi.apigw.ntruss.com/vision/v1/celebrity"; // 유명인 얼굴 인식
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true); //서버 전송 데이터 추가 있다.
            // multipart request
            String boundary = "---" + System.currentTimeMillis() + "---";
            con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
            OutputStream outputStream = con.getOutputStream();
            PrintWriter writer = new PrintWriter(new OutputStreamWriter(outputStream, "UTF-8"), true);
            String LINE_FEED = "\r\n";
            // file 추가
            String fileName = uploadFile.getName();
            //System.out.println("'"+fileName+"'");
            writer.append("--" + boundary).append(LINE_FEED);
            writer.append("Content-Disposition: form-data; name=\"" + paramName + "\"; filename=\"" + fileName + "\"").append(LINE_FEED);
            writer.append("Content-Type: "  + URLConnection.guessContentTypeFromName(fileName)).append(LINE_FEED);
            writer.append(LINE_FEED);
            writer.flush();
            FileInputStream inputStream = new FileInputStream(uploadFile);
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            outputStream.flush();
            inputStream.close();
            writer.append(LINE_FEED).flush();
            writer.append("--" + boundary + "--").append(LINE_FEED);
            writer.close();
            //=================요청 보내기(id, 시크릿키, 이미지파일 읽어서)=====================
            
            //응답 받기
            BufferedReader br = null;
            int responseCode = con.getResponseCode();
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 오류 발생 400, 500 
            	System.out.println(con.getResponseMessage());
                System.out.println("error!!!!!!! responseCode= " + responseCode);
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            }
            String inputLine;
            if(br != null) {
                //StringBuffer response = new StringBuffer();
                while ((inputLine = br.readLine()) != null) {
                    response.append(inputLine);
                }
                br.close();
                System.out.println(response.toString());
            } else {
                System.out.println("error !!!");
            }
        } catch (Exception e) {
            System.out.println(e);
            return e.toString();//클라이언트 파일 ....오류메시지
        }
        System.out.println("face결과: "+response.toString());
        return response.toString(); //서버로부터의 결과(오류, 정상결과)
	}

}
