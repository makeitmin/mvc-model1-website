<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "my.model.*, my.dao.*,java.sql.*,my.util.*,java.util.*" %> 
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.awt.Image"%>
<%@page import="com.sun.jimi.core.Jimi"%>
<%@page import="com.sun.jimi.core.JimiException"%>
<%@page import="com.sun.jimi.core.JimiUtils"%>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>영화등록완료</title>
<link href="qnadesign.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="page_header">
		<div class="toplogo"><a href="#"><img src="images/top_logo.jpg" width="276" height="40" alt="beautifullife"></a>
      	</div>
        <div class="topnav">
			<ul>
               	<li><a href="#"><img src="images/top_menu1.jpg" width="72" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu2.jpg" width="76" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu3.jpg" width="64" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu4.jpg" width="134" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu5.jpg" width="99" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu6.jpg" width="52" height="24" alt="ArtStory"></a></li>
            </ul>
        </div>
  	</div>
     
    <div class="page_subimg">
		<div class="subimgline"></div>
        <div class="subimg">
        	<div id="apDivSubimg"></div>
       	</div>
    </div>

	<div class="page_content">
       	<div class="leftmenu">
			<img src="images/left_title.jpg" width="152" height="24" alt="membership"> 
           	<ul>
            	<li></li>
               	<li><a href="#">고객등록</a></li>
                <li><a href="#">아이디찾기</a></li>
                <li><a href="#">비번찾기</a></li>
                <li><a href="#">마이페이지</a></li>
                <li><a href="#">1:1문의하기</a></li>
                <li><a href="#">질문내역</a></li>
                <li><a href="#">후기내역</a></li>
                <li><a href="#">쿠폰내격</a></li>
                <li><a href="#">적립금내역</a></li>
            </ul>
		</div>
		<div class="rightcon">
			<img src="images/title2.jpg" width="464" height="58" alt="고객등록">
			<div class="tablestyle">
		<%   
          	String uploadPath = "C:\\KPU_JSP2\\ws\\1023\\WebContent\\movie";//업로드할 이미지가 들어갈 파일명
          	String thumbPath = "C:\\KPU_JSP2\\ws\\1023\\WebContent\\thumb\\";
          	int maxSize = 1024 * 1024 * 10; // 한번에 올릴 수 있는 파일 용량 : 10M로 제한
            int thumbWidth = 30 ;//썸네일 가로
            int thumbHeight = 44 ;//썸네일 세로
           	MultipartRequest multi = null;
            multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
            String title = multi.getParameter("title");
            String maker = multi.getParameter("maker");
            int price = Integer.parseInt(multi.getParameter("price"));
            String movietype= multi.getParameter("movietype");
            String movieImage = multi.getOriginalFileName("movieImage");
            String fullName="/1023/movie/"+movieImage;
            String orgImg=uploadPath+"\\"+movieImage;
            String thumbImg=thumbPath+"small_"+movieImage;
            Image thumbnail = JimiUtils.getThumbnail(orgImg, thumbWidth, thumbHeight, Jimi.IN_MEMORY);// 썸네일 설정
            Jimi.putImage(thumbnail, thumbImg);// 썸네일 생성
            Connection conn = ConnectionProvider.getConnection();
            Movie movie= new Movie(title,maker,price,movieImage,movietype);//객체생성
            try{
				MovieDao dao = new MovieDao();
                dao.insert(conn, movie);
            }catch(SQLException e){ 	
            }
           %>   
        <%= title %> <br>
        <%= maker %> <br>
        <%= price %> <br>
        <%= movieImage %> <br>
        <img src=<%=fullName%>><br>
            	영화 등록이 완료되었습니다.
            </div>
		</div>
	</div>
</body>
</html>