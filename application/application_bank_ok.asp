<%@ CodePage='65001'  Language="VBScript"%>
<%Response.CharSet = "UTF-8"%> 
<%
'on error resume next
Set uploadform = Server.CreateObject("DEXT.FileUpload")
uploadform.DefaultPath = Server.MapPath("../")&"\upload\"
uploadform.CodePage = 65001	'UTF-8
 
	'On Error Resume next
	'=====파일업로드 시작===========================================================
	fileCount=uploadform("files").Count	'업로드 파일의 갯수
	
	dim filename, fileMimeType, FileLength, fileYN, uploadedfile, filenameonly, fileext
	redim filename(uploadform("files").Count)	'파일명
	redim fileMimeType(uploadform("files").Count)	'마임타입
	redim FileLength(uploadform("files").Count)	'파일크기(Byte)
	redim fileYN(uploadform("files").Count)	'파일여부
	redim uploadedfile(uploadform("files").Count)	'경로포함한 중복되지 않은 파일명
	redim filenameonly(uploadform("files").Count)	'경로를 제외한 중복되지 않은 파일명
	redim fileext(uploadform("files").Count)	'확장자
	
	
	For i = 1 To uploadform("files").Count
			fileMimeType(i) =uploadform("files")(i).MimeType	'허용되지 않은 파일종류 체크
			'if fileMimeType(i)<>"hwp" or fileMimeType(i)="doc" or  or fileMimeType(i)="pdf" then
				'response.End()
			'end if
			FileLength(i) =uploadform("files")(i).FileLen		'허용되지 않은 파일크기
			'if FileLength(i) > 30000 then
				'response.End()
			'end if
	Next
	
	
	For i = 1 To uploadform("files").Count
		filename(i) =uploadform("files")(i).FileName
	
		if FileLength(i)>0 then
			fileYN(i)="Y"
		else
			fileYN(i)="N"	
		end if
	
		if FileLength(i)>0 then
'			uploadedfile(i) = uploadform.SaveAs(filename(i), False)	'중복파일이 있을 경우 괄호안에 숫자포함한 파일명으로 저장 (True이면 overwrite)
			uploadedfile(i) = uploadform("files")(i).Save( ,false)	'중복파일이 있을 경우 괄호안에 숫자포함한 파일명으로 저장 (True이면 overwrite)
			
			If InStrRev(uploadedfile(i), ".") <> 0 Then				
				filenameonly(i) = Mid(uploadedfile(i), InStrRev(uploadedfile(i), "\")+1) '경로를 제외한 파일명
				fileext(i) = Mid(uploadedfile(i), InStrRev(uploadedfile(i), ".")+1)	'확장자명
			Else
				filenameonly(i) = uploadedfile(i)
				fileext(i) = ""
			End If			 
		end if
		
		If Err Then
		'Response.Write "Error occured : <BR>"
		'Response.Write Err.Description
		End If
		' 외부 오류 발생으로 업로드 작업을 취소하고자 할 경우
		'uploadform.DeleteAllSavedFiles
	Next


	c_kind=UploadForm("kind")
	c_name=UploadForm("name")
	c_comName=UploadForm("comName")
	c_busu=UploadForm("busu")
	c_position=UploadForm("position")
	c_tel=UploadForm("tel")	'UploadForm("tel1")&"-"&UploadForm("tel2")&"-"&UploadForm("tel3")
	c_hp=UploadForm("hp")	'UploadForm("hp1")&"-"&UploadForm("hp2")&"-"&UploadForm("hp3")
	c_fax=UploadForm("fax")	'UploadForm("fax1")&"-"&UploadForm("fax2")&"-"&UploadForm("fax3")
	c_email=UploadForm("email")
	c_s_email=UploadForm("s_email")
	c_zip=UploadForm("zip")
	c_zonecode=UploadForm("zonecode")
	c_addr_1=UploadForm("addr_1")
	c_addr_2=UploadForm("addr_2")
	'c_app_upjong=UploadForm("upjong")
	'c_app_upmu=UploadForm("upmu")
	'c_app_favor=UploadForm("favorite")
	'c_app_path=UploadForm("path")
	'c_app_purpose=UploadForm("purpose")
	c_amount=Replace(Replace(UploadForm("account"), ",", ""),"원", "")
	c_check_yn= "N"
	c_check_type="B"	'UploadForm("check_type")
	s_date_check=UploadForm("s_date_check")

	c_privacy=UploadForm("privacy")
	'c_megazine=UploadForm("megazine")
	TaxBill=UploadForm("TaxBill")
	'bill-phone=UploadForm("bill-phone")


Set UploadForm = Nothing '객체는 항상 사용되지않는 즉시 Nothing 처리해줘야 부하가 적습니다. 
'=====파일업로드 끝===========================================================	
%>

<!--#include virtual="/inc/DbCon_ex.asp" -->

<%
if c_kind="VIP" then
	c_amount=250000
else
	c_kind="일반"
	c_amount=250000
end if
	

		set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open "intra_seminar_all","Driver={SQL Server};Server="&myServer&";UID="&myID&";PWD="&myPWD&";DataBase="&myDB&"",3,2,2
		rs.addNew
		
		rs.Fields("c_kind")=c_kind
		rs.Fields("c_name")=c_name
		rs.Fields("c_comName")=c_comName
		rs.Fields("c_busu")=c_busu
		rs.Fields("c_position")=c_position
		rs.Fields("c_tel")=c_tel
		rs.Fields("c_hp")=c_hp
		rs.Fields("c_fax")=c_fax
		rs.Fields("c_email")=c_email
		rs.Fields("c_s_email")=c_s_email
		rs.Fields("c_s_email")=c_s_email
		rs.Fields("c_zip")=c_zip
		rs.Fields("c_zonecode")=c_zonecode
		rs.Fields("c_addr_1")=c_addr_1
		rs.Fields("c_addr_2")=c_addr_2
		rs.Fields("c_app_upjong")=c_app_upjong
		rs.Fields("c_app_upmu")=c_app_upmu
		rs.Fields("c_app_favor")=c_app_favor
		rs.Fields("c_app_path")=c_app_path
		rs.Fields("c_app_purpose")=c_app_purpose
		rs.Fields("c_amount")=c_amount	 
		rs.Fields("c_regDate")=now&""
		rs.Fields("c_check_yn")= c_check_yn
		rs.Fields("c_check_type")=c_check_type
		'If s_date_check="A" then
			rs.Fields("c_check_type_date_A")="V"
		'elseIf s_date_check="B" then
		'	rs.Fields("c_check_type_date_B")="V"
		'elseIf s_date_check="C" then
		'	rs.Fields("c_check_type_date_C")="V"
		'End If
		rs.Fields("c_privacy")=c_privacy
		rs.Fields("c_megazine")=c_megazine
		rs.Fields("TaxBill")=TaxBill
		rs.Fields("type")="aisemicon2023"

		if fileYN(1)="Y" then
			rs.Fields("filename")=filename(1)
		end If
		
		if DC_YN="Y" then
			rs.Fields("c_bigo")=DC_bigo
		end If

		rs.Fields("c_ip")=request.ServerVariables("REMOTE_ADDR")

		rs.MoveNext     	
		rs.MovePrevious     	
		rs.close

	


DbCon.close 

'Response.Redirect "application_bank_thanks.asp"
%>
<form name="frmPay" method="post" action="../sub/thankyou/">
<input type="hidden" name="check_type" value="<%=c_check_type%>"/>
<input type="hidden" name="name" value="<%=c_name%>"/>
<input type="hidden" name="comName" value="<%=c_comName%>"/>
<input type="hidden" name="email" value="<%=c_email%>" />
<input type="hidden" name="tel" value="<%=c_tel%>"/>
<input type="hidden" name="hp" value="<%=c_hp%>"/>
<input type="hidden" name="amount" value="<%=c_amount%>"/>						
<%if DC_YN="Y" then%>	
	<input type="hidden" name="DC_YN" value="Y"/>
	<input type="hidden" name="DC_bigo" value="<%=DC_bigo%>"/>	
<%end if%>
</form>
<script type="text/javascript">
function go_ok(){
	frmPay.submit();
	return;
}
go_ok();
</script>
