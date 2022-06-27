<%--
Created by IntelliJ IDEA.
User: qortj
Date: 2022-06-20
Time: 오후 6:34
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="DateBase.DBConnection" %>
<%@ page import="DateBase.WifiInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DateBase.WifiDTO" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>

<%
    Connection connection = DBConnection.getConnection();

    final String SQL_CREATE_History = "CREATE TABLE IF NOT EXISTS History"
            + "("
            + " ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,"
            + " X좌표 DOUBLE NOT NULL,"
            + " Y좌표 DOUBLE NOT NULL,"
            + " 조회날짜 varchar(45) NOT NULL"
            + ")";

    final String SQL_CREATE = "CREATE TABLE IF NOT EXISTS WiFi"
            + "("
            + " 관리번호 varchar(45) NOT NULL,"
            + " 자치구 varchar(45) NOT NULL,"
            + " 와이파이명 varchar(45) NOT NULL,"
            + " 도로명주소 varchar(45) NOT NULL,"
            + " 상세주소 varchar(45),"
            + " 설치위치 varchar(45),"
            + " 설치유형 varchar(45) NOT NULL,"
            + " 설치기관 varchar(45) NOT NULL,"
            + " 서비스구분 varchar(45) NOT NULL,"
            + " 망종류 varchar(45) NOT NULL,"
            + " 설치년도 varchar(45) NOT NULL,"
            + " 실내외구분 varchar(45) NOT NULL,"
            + " wifi접속환경 varchar(45),"
            + " X좌표 DOUBLE NOT NULL,"
            + " Y좌표 DOUBLE NOT NULL,"
            + " 작업일자 varchar(45) NOT NULL"
            + ")";

    final String SQL_Insert = "INSERT into WiFi VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    final String SQL_Drop = "Drop Table IF EXISTS WiFi";

    ArrayList<WifiDTO> wifi = null;
    WifiInfo wifiInfo = new WifiInfo();
    PreparedStatement preparedStatement;
    Statement statement;

    try {
        statement = connection.createStatement();
        statement.execute(SQL_Drop);

        statement = connection.createStatement();
        statement.execute(SQL_CREATE_History);

        statement = connection.createStatement();
        statement.execute(SQL_CREATE);

        preparedStatement = connection.prepareStatement(SQL_Insert);



        wifi = wifiInfo.getWifiInfo();
        for (int i = 0; i < wifi.size(); i++) {
            preparedStatement.setString(1, (wifi.get(i).getX_SWIFI_MGR_NO()));
            preparedStatement.setString(2, (wifi.get(i).getX_SWIFI_WRDOFC()));
            preparedStatement.setString(3, (wifi.get(i).getX_SWIFI_MAIN_NM()));
            preparedStatement.setString(4, (wifi.get(i).getX_SWIFI_ADRES1()));
            preparedStatement.setString(5, (wifi.get(i).getX_SWIFI_ADRES2()));
            preparedStatement.setString(6, (wifi.get(i).getX_SWIFI_INSTL_FLOOR()));
            preparedStatement.setString(7,(wifi.get(i).getX_SWIFI_INSTL_TY()));
            preparedStatement.setString(8, (wifi.get(i).getX_SWIFI_INSTL_MBY()));
            preparedStatement.setString(9, (wifi.get(i).getX_SWIFI_SVC_SE()));
            preparedStatement.setString(10, (wifi.get(i).getX_SWIFI_CMCWR()));
            preparedStatement.setString(11,(wifi.get(i).getX_SWIFI_CNSTC_YEAR()));
            preparedStatement.setString(12, (wifi.get(i).getX_SWIFI_INOUT_DOOR()));
            preparedStatement.setString(13, (wifi.get(i).getX_SWIFI_REMARS3()));
            preparedStatement.setDouble(14, wifi.get(i).getLAT());
            preparedStatement.setDouble(15, wifi.get(i).getLNT());
            preparedStatement.setString(16, (wifi.get(i).getWORK_DTTM()));

            preparedStatement.execute();

            System.out.println(i + "번째 처리중...");
        }
        statement.close();
        preparedStatement.close();

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (connection != null) {
            try {
                connection.close();

                System.out.println("연결해제");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

<html>
<head>
    <title>Title</title>
</head>
<body>

    <H3 align="center"><%=wifi.size()%>개의 WiFi정보를 정상적으로 저장하였습니다.</H3>
    <H3 align="center"><a href="index.jsp">홈으로</a></H3>

</body>
</html>
