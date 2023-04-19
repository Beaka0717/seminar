<%@ CodePage='65001'  Language="VBScript"%>
<!--#include virtual="/inc/DbCon_ex.asp" -->
<% 
	email=request("email")
	c_type=request("c_type")
		
	TEXTS=""	

	SQL="select count(*) from intra_seminar_all where c_email='"&email&"' and type='aisemicon2023'"
	Set rs=DbCon.execute(SQL)
	if rs(0)=0 then
		TEXTS="사용가능 한 이메일주소 입니다."	
	else
		TEXTS="이미 사용중인 이메일주소 입니다."	
	end if
	
	if email="" then
		TEXTS="이메일주소를 입력하세요"	
	end if	
 
 Response.ContentType = "text/xml"
 RESPONSE.Charset="UTF-8"
 response.write(TEXTS)
%>