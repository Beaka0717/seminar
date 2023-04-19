<%@ CodePage='65001'  Language="VBScript"%>
<%Response.CharSet = "UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>
<body>

			계좌송금  안내
			<hr />
			[ 입금할 계좌번호 ]<br />
			기업은행 478-000704-04-014 / 예금주: 테크월드<br />

			<%if request("DC_YN")="Y" then%>
				할인대상 내역 : <%=request("DC_bigo")%><br />
			<%end if%>
			입금하실 금액 : <%=FormatNumber(request("amount"), 0)%>
			<hr />
			<a href="sign02.asp">홈으로</a>

</body>
</html>