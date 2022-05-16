package com.model2.mvc.service.user.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.UserDao;;


//==> 회원관리 서비스 구현
@Service("userServiceImpl")
public class UserServiceImpl implements UserService{
	
	///Field
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	///Constructor
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
	}

	public User getUser(String userId) throws Exception {
		return userDao.getUser(userId);
	}

	public Map<String , Object > getUserList(Search search) throws Exception {
		List<User> list= userDao.getUserList(search);
		int totalCount = userDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);
	}

	public boolean checkDuplication(String userId) throws Exception {
		boolean result=true;
		User user=userDao.getUser(userId);
		if(user != null) {
			result=false;
		}
		return result;
	}
	
	public String getAccessToken(String authorization_code) throws Exception{
		
			System.out.println("### kakaoLogin Start ###");

			String access_Token = "";
			String refresh_Token = "";
			String reqURL = "https://kauth.kakao.com/oauth/token";
			
			URL url = new URL(reqURL);
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			
			sb.append("&client_id=ab70541f4fbb493e0fd22d7f73cd2940");
			sb.append("&redirect_uri=http://192.168.0.165:8080/user/kakaoLogin");
            
			sb.append("&code=" + authorization_code);
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			///////////////////////////////여기까지 request///////////////////////////////////////
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			
			JSONObject json = (JSONObject)JSONValue.parse(result);				
			System.out.println("json : "+json);
			
			refresh_Token = (String)json.get("refresh_token").toString();
			System.out.println("refresh_Token : "+refresh_Token);
			access_Token = (String)json.get("access_token").toString();
			System.out.println("access_Token : "+access_Token);

			System.out.println("### kakaoLogin End ###");
		return access_Token;
	}
	
	public Map<String, Object> getUserInfo(String access_Token) throws Exception{
		Map<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		
		URL url = new URL(reqURL);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");

		// 요청에 필요한 Header에 포함될 내용
		conn.setRequestProperty("Authorization", "Bearer " + access_Token);

		int responseCode = conn.getResponseCode();
		System.out.println("responseCode : " + responseCode);

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));

		String line = "";
		String result = "";

		while ((line = br.readLine()) != null) {
			result += line;
		}
		System.out.println("response body : " + result);

		JSONObject json = (JSONObject)JSONValue.parse(result);
		
		JSONObject properties = (JSONObject)json.get("properties");
		System.out.println("properties : "+properties);
		JSONObject kakao_account = (JSONObject)json.get("kakao_account");
		System.out.println("kakao_account : "+kakao_account);

		String nickname = properties.get("nickname").toString();
		System.out.println("nickname : "+nickname);
		String email = kakao_account.get("email").toString();
		System.out.println("email : "+email);

		userInfo.put("nickname", nickname);
		userInfo.put("email", email);

		return userInfo;
	}
	
}