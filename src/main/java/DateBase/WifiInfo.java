package DateBase;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

public class WifiInfo {
    static BufferedReader rd;
    static HttpURLConnection conn;
    static ObjectMapper mapper = new ObjectMapper();
    static ArrayList<WifiDTO> wifiInfo;
    static JsonObject TbPublicWifiInfo;
    static JsonParser parser;
    static JsonObject object;
    static JsonArray row;

    public ArrayList<WifiDTO> getWifiInfo() throws IOException {
        int cnt = 0;
        wifiInfo = new ArrayList<>();
        for(int i = 0 ; i < 15; i++){
            StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088/4b6e4f576e716f723130386850666c71/json/TbPublicWifiInfo");

            urlBuilder.append("/" + URLEncoder.encode(String.valueOf(cnt = cnt + 1),"UTF-8"));
            urlBuilder.append("/" + URLEncoder.encode(String.valueOf(cnt = cnt + 999),"UTF-8"));

            URL url = new URL(urlBuilder.toString());
            System.out.println(urlBuilder);

            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/xml");
            System.out.println("Response code: " + conn.getResponseCode()); /* 연결자체에 대한 확인이 필요하므로 추가합니다.*/



            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream() ,"UTF-8"));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
            }


            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }

            parser = new JsonParser();
            object = (JsonObject) parser.parse(sb.toString());
            TbPublicWifiInfo = (JsonObject) object.get("TbPublicWifiInfo");
            row = (JsonArray) TbPublicWifiInfo.get("row");

            Gson gson = new Gson();
            for(int j = 0 ; j < row.size(); j++){
                JsonObject tmp = (JsonObject) row.get(j);
                WifiDTO wifiDto = gson.fromJson(tmp.toString(), WifiDTO.class);
                if(wifiDto != null){
                    wifiInfo.add(wifiDto);
                }
            }

        }

        rd.close();
        conn.disconnect();


        return wifiInfo;
    }


}