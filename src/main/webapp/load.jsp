<%@ page import="DateBase.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%--<%@ page errorPage = "noValueError.jsp" %>--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"><title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="location.js"></script>

    <title>와이파이 정보 구하기</title>
</head>

<body>


<h1>와이파이 정보 구하기</h1>
<div>
    <ul class="nav justify-content-start bg-light float-left">
        <a class="nav-link" href="index.jsp">Home</a> |
        <a class="nav-link" href="history.jsp">History</a> |
        <a class="nav-link" href="load-wifi.jsp">Wi-Fi information</a>
    </ul>
</div>
<br/>

<%


    final String SQL_INSERT_HISTORY = "INSERT INTO History(X좌표, Y좌표, 조회날짜) VALUES(?,?,?)";

    Connection connection = DBConnection.getConnection();
    Double lat = Double.parseDouble(request.getParameter("lat"));
    Double lnt = Double.parseDouble(request.getParameter("lnt"));


    PreparedStatement preparedStatement = connection.prepareStatement(SQL_INSERT_HISTORY);
    preparedStatement.setDouble(1,lat);
    preparedStatement.setDouble(2,lnt);
    preparedStatement.setString(3, new Date().toString());
    preparedStatement.execute();


    String calcDistance = "SELECT *,\n" +
            "       (6371*acos(cos(radians("+ lat +"))*cos(radians(Y좌표))*cos(radians(X좌표)-radians("+ lnt +"))+sin(radians("+ lat +"))*sin(radians(Y좌표)))) \n" +
            "           AS dist\n" +
            "FROM WiFi ORDER BY dist ASC";

    preparedStatement = connection.prepareStatement(calcDistance);
    ResultSet resultSet = preparedStatement.executeQuery();




    int cnt = 0;

%>


<form method="get" action="/zerobase_part1_war_exploded/load.jsp">
    <p> Lat : <input type="text" id="location_lat" name="lat" value/>  LNT : <input type="text" id="location_lnt" name="lnt" value/> <input type="button", value="내 위치 가져오기" onclick="on()"/> <input type="submit", value="근처 Wi-Fi 정보 보기" onclick="noValueError()"/>
</form>


<table class="table table-bordered">
    <tr>
        <th scope="col">거리</th>
        <th scope="col">관리번호</th>
        <th scope="col">자치구</th>
        <th scope="col">와이파이명</th>
        <th scope="col">도로명주소</th>
        <th scope="col">상세주소</th>
        <th scope="col">설치위치</th>
        <th scope="col">설치기관</th>
        <th scope="col">서비스구분</th>
        <th scope="col">망종류</th>
        <th scope="col"> 설치년도</th>
        <th scope="col">실내외구분</th>
        <th scope="col">wifi접속환경</th>
        <th scope="col">X좌표</th>
        <th scope="col">Y좌표</th>
        <th scope="col">작업일자</th>
        <%
            while (resultSet.next() && cnt < 20){
                cnt++;
        %>

            <tr>
                <td><%= resultSet.getString("dist").substring(0,5) %></td>
                <td><%= resultSet.getString("관리번호") %></td>
                <td><%= resultSet.getString("자치구") %></td>
                <td><%= resultSet.getString("와이파이명") %></td>
                <td><%= resultSet.getString("도로명주소") %></td>
                <td><%= resultSet.getString("상세주소") %></td>
                <td><%= resultSet.getString("설치위치") %></td>
                <td><%= resultSet.getString("설치기관") %></td>
                <td><%= resultSet.getString("서비스구분") %></td>
                <td><%= resultSet.getString("망종류") %></td>
                <td><%= resultSet.getString("설치년도") %></td>
                <td><%= resultSet.getString("실내외구분") %></td>
                <td><%= resultSet.getString("wifi접속환경") %></td>
                <td><%= resultSet.getString("X좌표") %></td>
                <td><%= resultSet.getString("Y좌표") %></td>
                <td><%= resultSet.getString("작업일자") %></td>

            </tr>
        <%}%>
        <%
            connection.close();
            resultSet.close();
            preparedStatement.close();
        %>
    </tr>
</table>



</body>
</html>