package services;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class APILogistic {
    public  static  final String API_LOGISTIC_TOKEN="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTQwLjIzOC41NC4xMzYvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODE2MjQ5MjIsImV4cCI6MTY4MTYyNTUyMiwibmJmIjoxNjgxNjI0OTIyLCJqdGkiOiJHZ2hnaFQ4NU1sbU52N3BFIiwic3ViIjoiMmY1NmY3YjZmMTU0NGIxZWExZmQxZjBhM2Q3NzFhMTIiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.J2oQOXmMM0Zrcf3QK9dWUCPJkrsaZZAWqiumdNkDPkA";
    public static void main(String[] args) throws IOException {
        URL url = new URL("http://140.238.54.136/api/province") ;
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization", "Bearer "+API_LOGISTIC_TOKEN);


        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        System.out.println(response.toString());
    }
//        try {
//            // Tạo kết nối đến API đăng ký
//            URL url = new URL("http://140.238.54.136/api/province?Authorization=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTQwLjIzOC41NC4xMzYvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODE2MjQ5MjIsImV4cCI6MTY4MTYyNTUyMiwibmJmIjoxNjgxNjI0OTIyLCJqdGkiOiJHZ2hnaFQ4NU1sbU52N3BFIiwic3ViIjoiMmY1NmY3YjZmMTU0NGIxZWExZmQxZjBhM2Q3NzFhMTIiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.J2oQOXmMM0Zrcf3QK9dWUCPJkrsaZZAWqiumdNkDPkA");
//            HttpURLConnection con = (HttpURLConnection) url.openConnection();
//            con.setRequestMethod("POST");
//
//            // Set các tham số yêu cầu đăng ký
////            String postData = "name=Nhom30Project&email=201300121@st.hcmuaf.edu.vn&password=Nhom30@123&password_confirmation=Nhom30@123";
//            String postData = "email=201300121@st.hcmuaf.edu.vn&password=Nhom30@123";
//
//            // Gửi yêu cầu đăng ký lên server
//            con.setDoOutput(true);
//            con.getOutputStream().write(postData.getBytes("UTF-8"));
//
//            // Đọc phản hồi từ server
//            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
//            String response = "";
//            String line;
//            while ((line = in.readLine()) != null) {
//                response += line;
//            }
//            in.close();
//            System.out.println(response);
////            Gson gson = new Gson();
////            JsonObject jsonResponse = gson.fromJson(response, JsonObject.class);
////            JsonObject user = gson.fromJson(jsonResponse.get("user"),JsonObject.class);
////            System.out.println("Đăng ký thành công!" + jsonResponse.get("message") +"name = "+user.get("name")+" email= "+user.get("email")+" update at "+user.get("updated_at")+" created_at "+user.get("created_at")+" id= "+user.get("id"));
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }

