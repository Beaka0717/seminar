    <!-- #include file = "./m_cfg/site_conf_inc.asp" -->
<%
    Set chc = Server.CreateObject( "con_cli_com.CHKCP.1" )

' Request ������ ���� ( ���� ���� )
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

' �ɼ� ������ ����
    hashType    = "MD5"                         ' hash ó�� Ÿ��
    chc.setHashData_type(hashtype)

    hashData    = chc.lf_CH_CLI__HASH ( paymentAmount & orderID & siteCode , hashtype ) ' ������ hash ������ ����
    chc.setHashData(hashData)

    corpID      = "KCP"                         ' ������ ��ȣ ����
    chc.setRequestID(corpID)

    chc.setResponse_type(Request("response_type"))              ' �������� Ÿ��
    chc.setAgent(Request.ServerVariables("HTTP_USER_AGENT"))    ' ���� agent ����
    chc.setRemoteip("0.0.0.0")                                  ' ��û IP
    chc.setEng_flag("N")      
    chc.setRequest_type("ConnectionKCP")  
    
    chc.setEncoding_trans("EUC-KR")

' ���� ������ ����
    chc.setSoap_version("0.1")
    chc.setRequestApp("WEB")

    response.write chc.lf_CH_CLI__CON(g_conf_server)
%>