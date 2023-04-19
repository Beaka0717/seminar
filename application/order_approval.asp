    <!-- #include file = "./m_cfg/site_conf_inc.asp" -->
<%
    Set chc = Server.CreateObject( "con_cli_com.CHKCP.1" )

' Request 데이터 영역 ( 기존 영역 )
    siteCode        = Request("site_cd")
    orderID         = Request("ordr_idxx")
    paymentAmount   = Request("good_mny")
    returnUrl       = Request("Ret_URL")
    paymentMethod   = Request("pay_method")
    productName     = Request("good_name")
    escrow          = Request("escw_used")

    chc.setSite_cd   (siteCode      )
    chc.setOrdr_idxx (orderID       )
    chc.setGood_mny  (paymentAmount )
    chc.setRet_URL   (returnUrl     )
    chc.setPay_method(paymentMethod )
    chc.setGood_name (productName   )
    chc.setEscw_used (escrow        )

' 옵션 데이터 영역
    hashType    = "MD5"                         ' hash 처리 타입
    chc.setHashData_type(hashtype)

    hashData    = chc.lf_CH_CLI__HASH ( paymentAmount & orderID & siteCode , hashtype ) ' 검증용 hash 데이터 생성
    chc.setHashData(hashData)

    corpID      = "KCP"                         ' 가맹점 상호 약자
    chc.setRequestID(corpID)

    chc.setResponse_type(Request("response_type"))              ' 리턴정보 타입
    chc.setAgent(Request.ServerVariables("HTTP_USER_AGENT"))    ' 유저 agent 정보
    chc.setRemoteip("0.0.0.0")                                  ' 요청 IP
    chc.setEng_flag("N")      
    chc.setRequest_type("ConnectionKCP")  
    
    chc.setEncoding_trans("EUC-KR")

' 고정 데이터 영역
    chc.setSoap_version("0.1")
    chc.setRequestApp("WEB")

    response.write chc.lf_CH_CLI__CON(g_conf_server)
%>