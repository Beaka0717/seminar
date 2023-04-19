<%@ CodePage='65001'  Language="VBScript"%>
<%Response.CharSet = "UTF-8"%> 
<%
buyr_name=request("buyr_name")
amount=request("amount")
good_name=request("good_name")
tno=request("tno")
ordr_idxx=request("ordr_idxx")
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script type="text/javascript">
        /* 신용카드 영수증 */ 
        /* 실결제시 : "https://admin8.kcp.co.kr/assist/bill.BillAction.do?cmd=card_bill&tno=" */
        /* 테스트시 : "https://testadmin8.kcp.co.kr/assist/bill.BillAction.do?cmd=card_bill&tno=" */
         function receiptView( tno, ordr_idxx, amount ) 
        {
            receiptWin = "https://testadmin8.kcp.co.kr/assist/bill.BillAction.do?cmd=card_bill&tno=";						
            receiptWin += tno + "&";
            receiptWin += "order_no=" + ordr_idxx + "&";
            receiptWin += "trade_mony=" + amount ;

            window.open(receiptWin, "", "width=455, height=815");
        }

        /* 현금 영수증 */ 
        /* 실결제시 : "https://admin8.kcp.co.kr/assist/bill.BillActionNew.do" */ 
        /* 테스트시 : "https://testadmin8.kcp.co.kr/assist/bill.BillActionNew.do" */   
        function receiptView2( cash_no, ordr_idxx, amount ) 
        {
            receiptWin2 = "https://testadmin8.kcp.co.kr/assist/bill.BillActionNew.do?cmd=cash_bill&cash_no=";
            receiptWin2 += cash_no + "&";             
            receiptWin2 += "order_id="     + ordr_idxx + "&";
            receiptWin2 += "trade_mony="  + amount ;

            window.open(receiptWin2, "", "width=370, height=625"); 
        }

        /* 가상 계좌 모의입금 페이지 호출 */
        /* 테스트시에만 사용가능 */
        /* 실결제시 해당 스크립트 주석처리 */
        function receiptView3() 
        {
            receiptWin3 = "http://devadmin.kcp.co.kr/Modules/Noti/TEST_Vcnt_Noti.jsp";
            window.open(receiptWin3, "", "width=520, height=300");
        }
    </script>

</head>
<body>
	카드결제완료 안내
	<hr />
	결재내용 : <%=good_name%><br />
	결재금액 : <%=FormatNumber(amount, 0)%><br />
	<a href="javascript:receiptView('<%=tno%>','<%= ordr_idxx %>','<%= amount %>')">영수증 보기</a>
</body>
</html>