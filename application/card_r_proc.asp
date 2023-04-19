<%@ CodePage='65001'  Language="VBScript"%>
<%Response.CharSet = "UTF-8"%> 

<%
Dim targetAction, bln_mobile

	Function checkMobileBrauswer()
			Dim str_mobile, arr_str_mobile, str_user_agent
			'// RESPONSE.WRITE Request.ServerVariables("HTTP_USER_AGENT")
			str_user_agent = Request.ServerVariables("HTTP_USER_AGENT")
			str_user_agent = Lcase(str_user_agent)
			'// response.write "0---->" & str_user_agent  & "<br>"
			bln_mobile = false
			str_mobile = "iPod|iPhone|Android|BlackBerry|SymbianOS|SCH-M\d+|Opera Mini|Windows CE|Nokia|SonyEricsson|webOS|PalmOS"
			str_mobile = Lcase(str_mobile)
			arr_str_mobile = split(str_mobile, "|")
			FOR tempI=0 TO Ubound(arr_str_mobile)
			 '// response.write "1---->" & arr_str_mobile(tempI)  & "<br>"
			 IF (Instr(str_user_agent, arr_str_mobile(tempI))) THEN
				'// RESPONSE.WRITE "2---->" & arr_str_mobile(tempI) & "<br>"
				bln_mobile = true
			 END IF
			NEXT
			IF (bln_mobile = true) THEN
				'RESPONSE.WRITE bln_mobile
				'RESPONSE.REDIRECT "m_sign02.asp?" & request.serverVariables("QUERY_STRING")
				'response.end

				targetAction="m_application_card.asp"
			Else
				targetAction="application_card.asp"
			END If
	End Function 
	
	checkMobileBrauswer()
%>

<%
c_kind=request("kind")
c_name=request("name")
c_comName=request("comName")
c_busu=request("busu")
c_position=request("position")
c_tel=request("tel")	'request("tel1")&"-"&request("tel2")&"-"&request("tel3")
c_hp=request("hp")	'request("hp1")&"-"&request("hp2")&"-"&request("hp3")
c_fax=request("fax")	'request("fax1")&"-"&request("fax2")&"-"&request("fax3")
c_email=request("email")
c_s_email=request("s_email")
c_zip=request("zip")
c_zonecode=request("zonecode")
c_addr_1=request("addr_1")
c_addr_2=request("addr_2")
c_app_upjong=request("upjong")
c_app_upmu=request("upmu")
c_app_favor=request("favorite")
c_app_path=request("path")
c_app_purpose=request("purpose")
c_amount=Replace(Replace(request("account"), ",", ""),"원", "")
c_check_yn= "N"
c_check_type="C"	'request("check_type")
s_date_check=request("s_date_check")

c_privacy=request("privacy")
c_megazine=request("megazine")
TaxBill=request("TaxBill")


if c_kind="VIP" then
	c_amount=250000
else
	c_kind="일반"
	c_amount=250000
end if

'sql="select * from intra_seminar_all where type='aisemicon2023' and c_email='"&c_email&"'"
'set rs=DbCon.execute(sql)
'if not rs.eof then
'	DC_YN="Y"
'	DC_bigo="2018참가DC"
'end if
'rs.close

'sql="select count(*) from intra_seminar_all where type='aisemicon2023'"
'set rs=DbCon.execute(sql)
'if rs(0) < 51 then
'	DC_YN="Y"
'	DC_bigo="얼리버드DC"
'end if
'rs.close

'if DC_YN="Y" then	
'	c_amount=c_amount - ((c_amount / 10) * 4)
'end if


if c_name&"" ="" then
	response.redirect ("../")
end if

%>
<!--#include virtual="/inc/DbCon_ex.asp" -->
<%
		set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open "intra_seminar_all",DbCon,3,2,2
		rs.addNew
		
		rs.Fields("c_kind")=c_kind
		rs.Fields("c_name")=c_name
		rs.Fields("c_comName")=c_comName
		'rs.Fields("c_busu")=c_busu
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
		'rs.Fields("TaxBill")=TaxBill
		rs.Fields("type")="aisemicon2023"

		'if fileYN(1)="Y" then
		'	rs.Fields("filename")=filename(1)
		'end If
		
		if DC_YN="Y" then
			rs.Fields("c_bigo")=DC_bigoe
		end If

		rs.Fields("c_ip")=request.ServerVariables("REMOTE_ADDR")

		rs.MoveNext     	
		rs.MovePrevious     	
		rs.close


		sql="select max(idx) from intra_seminar_all"
		set rs=DbCon.execute(sql)
		max_idx=rs(0)
		rs.close

		DbCon.close 
%>

<html>
	<body>
		<form name="frm01" action="<%=targetAction%>" method="post" <% IF (bln_mobile = true) THEN %>accept-charset="euc-kr"<% end if %>>		
			<input type="hidden" name="param_opt_1" value="<%=max_idx%>">
			<input type="hidden" name="type" value="aisemicon2023">
			<input type="hidden" name="s_date_check" value="<%=s_date_check%>">
			<input type="hidden" name="name" value="<%=c_name%>">
			<input type="hidden" name="comName" value="<%=c_comName%>">
			<input type="hidden" name="tel" value="<%=c_tel%>">
			<input type="hidden" name="hp" value="<%=c_hp%>">
			<input type="hidden" name="email" value="<%=c_email%>">
			<input type="hidden" name="zip" value="<%=c_zip%>">
			<input type="hidden" name="amount" value="<%=c_amount%>">
			<input type="hidden" name="kind" value="<%=c_kind%>">
			<input type="hidden" name="DC_YN" value="<%=DC_YN%>">
			<input type="hidden" name="DC_bigo" value="<%=DC_bigo%>">
		</form>
	</body>
</html>

<script>
	document.frm01.submit();
</script>
