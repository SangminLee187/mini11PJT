package com.model2.mvc.service.user.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.UserDao;;


//==> ȸ������ ���� ����
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
			///////////////////////////////������� request///////////////////////////////////////
			
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

		// ��û�� �ʿ��� Header�� ���Ե� ����
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

	public String makeSignature(String requestUrl, String timestamp, String method,
								String accessKey, String secretKey) throws Exception {
		String space = " ";						// one space
		String newLine = "\n";					// new line
	
		System.out.println("###########################################");
		System.out.println(requestUrl);
		System.out.println(timestamp);
		System.out.println(method);
		System.out.println(accessKey);
		System.out.println(secretKey);
		System.out.println("###########################################");

		String message = new StringBuilder()
			.append(method)
			.append(space)
			.append(requestUrl)
			.append(newLine)
			.append(timestamp)
			.append(newLine)
			.append(accessKey)
			.toString();

		SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
		Mac mac = Mac.getInstance("HmacSHA256");
		mac.init(signingKey);

		byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
		String encodeBase64String = Base64.encodeBase64String(rawHmac);

		System.out.println("###encodeBase64String : "+encodeBase64String);
	  return encodeBase64String;
	}
	
	public void sendSMS(String phone) throws Exception {
		String hostNameUrl = "https://sens.apigw.ntruss.com";     		// ȣ��Ʈ URL
		String requestUrl= "/sms/v2/services/";                   			// ��û URL
		String requestUrlType = "/messages";                      				// ��û URL
		String accessKey = "L5CjqUAH9JbC4lkHKeEx";                  	   	// ���̹� Ŭ���� �÷��� ȸ������ �߱޵Ǵ� ���� ����Ű			// Access Key : https://www.ncloud.com/mypage/manage/info > ����Ű ���� > Access Key ID
		String secretKey = "edd7236fa523492691e3c78e9306400c";  			// 2�� ������ ���� ���񽺸��� �Ҵ�Ǵ� service secret key	// Service Key : https://www.ncloud.com/mypage/manage/info > ����Ű ���� > Access Key ID	
		String serviceId = "ncp:sms:kr:285705455384:forrest";    		   // ������Ʈ�� �Ҵ�� SMS ���� ID							// service ID : https://console.ncloud.com/sens/project > Simple & ... > Project > ���� ID
		String method = "POST";												// ��û method
		String timestamp = LocalDateTime.now().toString(); 	// current timestamp (epoch)
		requestUrl += serviceId + requestUrlType;
		String apiUrl = hostNameUrl + requestUrl;
		String signature = makeSignature(requestUrl, timestamp, method, accessKey, secretKey);
		System.out.println("###signature : "+signature);
				
		
		// JSON �� Ȱ���� body data ����
		JSONObject bodyJson = new JSONObject();
		JSONObject toJson = new JSONObject();
	    JSONArray  toArr = new JSONArray();
	    
	    
	    bodyJson.put("type","SMS");							// Madantory, �޽��� Type (SMS | LMS | MMS), (�ҹ��� ����)
	    bodyJson.put("from","01033294534");					// Mandatory, �߽Ź�ȣ, ���� ��ϵ� �߽Ź�ȣ�� ��� ����		
	    bodyJson.put("content","[�׽�Ʈ�߼�] ���� �����ٸ�");	// Mandatory(�ʼ�), �⺻ �޽��� ����, SMS: �ִ� 80byte, LMS, MMS: �ִ� 2000byte
	    bodyJson.put("messages", toArr);					// Mandatory(�ʼ�), �Ʒ� �׸�� ���� (messages.XXX), �ִ� 1,000��
	    toJson.put("to",phone);						// Mandatory(�ʼ�), messages.to	���Ź�ȣ, -�� ������ ���ڸ� �Է� ����
	    toJson.put("content","[�׽�Ʈ�����߼�] �Ӿ����´�");
	    
	    toArr.add(toJson);

	    
	    
	    String body = bodyJson.toString();
	    
	    System.out.println("###body : "+body);
	    
        try {
            URL url = new URL(apiUrl);
            System.out.println("###url : "+url);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("Content-Type", "application/json");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", signature);
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            
            wr.write(body.getBytes());
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            System.out.println("responseCode" +" " + responseCode);
            if(responseCode == 202) { // ���� ȣ��
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // ���� �߻�
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            
            System.out.println(response.toString());

        } catch (Exception e) {
            System.out.println(e);
        }
	}
	
}