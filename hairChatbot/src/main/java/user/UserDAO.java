package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://101.101.208.133:3306/naverdb";
			String dbID = "naveruser";
			String dbPassword = "Naveruser_1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID, dbPassword);		
		}catch(Exception e) {
			e.printStackTrace();	
		}
	}
	
	public int login(String userID, String userPW) {
		String SQL = "SELECT userPW FROM USER where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPW))
					return 1;	// 로그인 성공
				else 
					return 0;	// 	PW 불일치
			}
			return -1;	// id 없음
		}catch(Exception e){
			e.printStackTrace();
		}
		return -2; // DB 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPW());
			pstmt.setString(3, user.getUserNAME());

			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}
