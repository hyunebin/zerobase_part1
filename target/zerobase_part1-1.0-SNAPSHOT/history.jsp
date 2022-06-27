<%@ page import="DateBase.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"><title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

    <title>위치 히스토리 목록</title>
</head>

<body>


<h1>위치 히스토리 목록</h1>
<div>
    <ul class="nav justify-content-start bg-light float-left">
        <a class="nav-link" href="index.jsp">Home</a> |
        <a class="nav-link" href="history.jsp">History</a> |
        <a class="nav-link" href="load-wifi.jsp">Wi-Fi information</a>
    </ul>
</div>
<br/>
<%
    String SQL_SELECT_HISTORY = "SELECT * FROM History";
    Connection connection = DBConnection.getConnection();
    PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_HISTORY);
    ResultSet resultSet = preparedStatement.executeQuery();
%>

<table class="table table-bordered">
    <thead>
    <th scope="col">ID</th>
    <th scope="col">X좌표</th>
    <th scope="col">Y좌표</th>
    <th scope="col">조회일자</th>
    <th scope="col">비고</th>
    </thead>
    <%
        while (resultSet.next()){
    %>

    <tr>
        <td><%= resultSet.getString("ID") %></td>
        <td><%= resultSet.getString("X좌표") %></td>
        <td><%= resultSet.getString("Y좌표") %></td>
        <td><%= resultSet.getString("조회날짜") %></td>
        <td>
            <form action="delete.jsp">
                <input type="submit" value="비고"><input type="hidden" name="idx" value=<%= resultSet.getString("ID") %>>
            </form>
        </td>
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