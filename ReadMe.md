DBConnection
-DataBase와의 연결

WififDTO
-API의 데이터들을 처리하기 편리하게 하기위해 객체로 만듬

WIfiInfo
-API를 불러와 ArrayList에 저장


index.jsp
-첫 화면의 css부분


deleteServlet
-history의 작업을 처리하는 부분으로 조회했던 위도와 경도값을 DB에서 제거해줌


history.jsp
-deleteServlet과 연동해서 조회했던 위도와 경도값을 보여줌


load-wifi.jsp
-자바 코드와 섞여있음  Wi-Fi information 버튼을 누르면 해당 페이지로 이동
-DB에 WifiInfo에서 만든 ArrayList를 통해 DB에 데이터를 넣어줌

load.jsp
-자바 코드와 섞여있음  근처 WI-FI정보 보기 버튼을 누르면 해당 페이지로 이동
-데이터 베이스에 있던 자료를 가져와 화면에 보여줌


-location.js
geolocation을 활용 현재 위도와 경도값을 찾아와 jsp쪽으로 넘겨준다. 

