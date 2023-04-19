<%@ CodePage='65001'  Language="VBScript"%>
<%Response.CharSet = "UTF-8"%> 
<%
    '/* ============================================================================== */
    '/* =   PAGE : 지불 요청 및 결과 처리 PAGE                                       = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   연동시 오류가 발생하는 경우 아래의 주소로 접속하셔서 확인하시기 바랍니다.= */
    '/* =   접속 주소 : http://kcp.co.kr/technique.requestcode.do                    = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   Copyright (c)  2016  NHN KCP Inc.   All Rights Reserverd.                = */
    '/* ============================================================================== */


    '/* ============================================================================== */
    '/* =   환경 설정 파일 Include                                                   = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   ※ 필수                                                                  = */
    '/* =   테스트 및 실결제 연동시 site_conf_inc.asp파일을 수정하시기 바랍니다.     = */
    '/* = -------------------------------------------------------------------------- = */
%>
    <!-- #include file = "site_conf_inc.asp" -->         <!-- ' 환경설정 파일 include -->
    <!-- #include file = "pp_cli_hub_lib.asp" -->              <!-- ' library [수정불가] -->
<%
    '/* = -------------------------------------------------------------------------- = */
    '/* =   환경 설정 파일 Include END                                               = */
    '/* ============================================================================== */
%>
<%
    '/* ============================================================================== */
    '/* =   POST 형식 체크부분                                                            = */
    '/* = -------------------------------------------------------------------------- = */
    if Request.ServerVariables("REQUEST_METHOD") <> "POST" then 
        Response.write "정상적으로 접근하셔야 합니다." 
        Response.end 
    end if 
    '/* ============================================================================== */
%> 
<%
    '/* ============================================================================== */
    '/* =   01. 지불 요청 정보 설정                                                  = */
    '/* = -------------------------------------------------------------------------- = */    
    req_tx         = Request(  "req_tx"          )             ' 요청 종류
    tran_cd        = Request(  "tran_cd"         )             ' 처리 종류
    '/* = -------------------------------------------------------------------------- = */
    cust_ip        = Request.ServerVariables( "REMOTE_ADDR" )  ' 요청 IP
    ordr_idxx      = Request(  "ordr_idxx"       )             ' 쇼핑몰 주문번호
    good_name      = Request(  "good_name"       )             ' 상품명
    '/* = -------------------------------------------------------------------------- = */
    res_cd         = ""                                        ' 응답코드
    res_msg        = ""                                        ' 응답메시지
    tno            = Request(  "tno"             )             ' KCP 거래 고유 번호
    '/* = -------------------------------------------------------------------------- = */
    buyr_name      = Request(  "buyr_name"       )             ' 주문자명
    buyr_tel1      = Request(  "buyr_tel1"       )             ' 주문자 전화번호
    buyr_tel2      = Request(  "buyr_tel2"       )             ' 주문자 핸드폰 번호
    buyr_mail      = Request(  "buyr_mail"       )             ' 주문자 E-mail 주소
    '/* = -------------------------------------------------------------------------- = */
    use_pay_method = Request(  "use_pay_method"  )             ' 결제 방법
    bSucc          = ""                                        ' 업체 DB 처리 성공 여부
    '/* = -------------------------------------------------------------------------- = */
    app_time       = ""                                        ' 승인시간(모든 결제 수단 공통)
    amount         = ""                                        ' KCP 실제 거래금액
    total_amount   = 0                                         ' 복합결제시 총 거래금액
    coupon_mny     = ""                                        ' 쿠폰결제금액
    '/* = -------------------------------------------------------------------------- = */
    card_cd        = ""                                        ' 신용카드 코드
    card_name      = ""                                        ' 신용카드 명    
    app_no         = ""                                        ' 신용카드 승인번호
    noinf          = ""                                        ' 신용카드 무이자 여부
    quota          = ""                                        ' 신용카드 할부개월
    partcanc_yn    = ""                                        ' 부분취소 가능유무
    card_bin_type_01 = ""                                      ' 카드구분1
    card_bin_type_02 = ""                                      ' 카드구분2
    card_mny       = ""                                        ' 카드결제금액
    '/* = -------------------------------------------------------------------------- = */
    bank_name      = ""                                        ' 은행명
    bank_code      = ""                                        ' 은행코드
    bk_mny         = ""                                        ' 계좌이체결제금액
    '/* = -------------------------------------------------------------------------- = */
    bankname       = ""                                        ' 입금 은행명
    depositor      = ""                                        ' 입금 계좌 예금주 성명
    account        = ""                                        ' 입금 계좌 번호
    va_date        = ""                                        ' 가상계좌 입금마감시간
    '/* = -------------------------------------------------------------------------- = */
    pnt_issue      = ""                                        ' 결제 포인트사 코드
    pnt_amount     = ""                                        ' 적립금액 or 사용금액
    pnt_app_time   = ""                                        ' 승인시간
    pnt_app_no     = ""                                        ' 승인번호
    add_pnt        = ""                                        ' 발생 포인트
    use_pnt        = ""                                        ' 사용가능 포인트
    rsv_pnt        = ""                                        ' 총 누적 포인트
    '/* = -------------------------------------------------------------------------- = */
    commid         = ""                                        ' 통신사 코드
    mobile_no      = ""                                        ' 휴대폰 번호
    '/* = -------------------------------------------------------------------------- = */
    shop_user_id   = Request(  "shop_user_id"    )             ' 가맹점 고객 아이디
    tk_van_code    = ""                                        ' 발급사 코드
    tk_app_no      = ""                                        ' 승인 번호
    '/* = -------------------------------------------------------------------------- = */
    cash_yn        = Request(  "cash_yn"         )             ' 현금영수증 등록 여부
    cash_authno    = ""                                        ' 현금 영수증 승인 번호
    cash_tr_code   = Request(  "cash_tr_code"    )             ' 현금 영수증 발행 구분
    cash_id_info   = Request(  "cash_id_info"    )             ' 현금 영수증 등록 번호
    cash_no        = ""                                        ' 현금 영수증 거래 번호    
    '/* = -------------------------------------------------------------------------- = */
    '/* =   01. 지불 요청 정보 설정 END                                              = */
    '/* ============================================================================== */


    '/* ============================================================================== */
    '/* =   02. 인스턴스 생성 및 초기화(변경 불가)                                   = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   결제에 필요한 인스턴스를 생성하고 초기화 합니다.                         = */
    '/* =   ※ 주의 ※ 이 부분은 변경하지 마십시오                                   = */
    '/* = -------------------------------------------------------------------------- = */

    Set c_Mesg = New c_PayPlusData             ' 전문처리용 Class (library에서 정의됨)
    c_Mesg.InitialTX

    Set c_Payplus = Server.CreateObject( "pp_cli_com.KCP" )
    c_Payplus.lf_PP_CLI_LIB__init g_conf_key_dir, g_conf_log_dir, "03", g_conf_gw_url, g_conf_gw_port

    '/* = -------------------------------------------------------------------------- = */
    '/* =   02. 인스턴스 생성 및 초기화 END                                          = */
    '/* ============================================================================== */


    '/* ============================================================================== */
    '/* =   03. 처리 요청 정보 설정                                                  = */
    '/* = -------------------------------------------------------------------------- = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   03-1. 승인 요청 정보 설정                                                = */
    '/* = -------------------------------------------------------------------------- = */

    If req_tx = "pay" Then

        '/ 1 원은 실제로 업체에서 결제하셔야 될 원 금액을 넣어주셔야 합니다. 결제금액 유효성 검증'/
        payx_data_set = ""
        ordr_data_set = ""

        'ordr_data_set = c_Mesg.mf_set_ordr_data( "ordr_mony", "1") '금액 체크
				ordr_data_set = c_Mesg.mf_set_ordr_data( "ordr_mony", request("good_mny")) '금액 체크

        c_Mesg.InitialTX

        tx_req_data_set = c_Mesg.mf_set_req_data( ordr_data_set )
        c_Mesg.InitialTX

        c_PayPlus.lf_PP_CLI_LIB__set_plan_data tx_req_data_set
        c_Mesg.InitialTX

        c_PayPlus.lf_PP_CLI_LIB__set_crypto_info trace_no, request("enc_info"), request("enc_data")

    End If
    '/* = -------------------------------------------------------------------------- = */
    '/* =   03. 처리 요청 정보 설정 END                                              = */
    '/* ============================================================================== */


    '/* ============================================================================== */
    '/* =   04. 실행                                                                 = */
    '/* = -------------------------------------------------------------------------- = */
    If tran_cd <> "" Then

        c_Payplus.lf_PP_CLI_LIB__do_tx g_conf_site_cd, g_conf_site_key, tran_cd, "", ordr_idxx
        resp_mesg = c_Payplus.lf_PP_CLI_LIB__get_data
        c_Mesg.mf_set_res_data(resp_mesg)                               ' 응답 전문 처리

    Else

        res_cd  = "9562"
        res_msg = "연동 오류| tran_cd값이 설정되지 않았습니다."

    End If

        res_cd  = c_Mesg.mf_get_data ("res_cd")                         ' 결과 코드
        res_msg = c_Mesg.mf_get_data ("res_msg")                        ' 결과 메시지

    '/* = -------------------------------------------------------------------------- = */
    '/* =   04. 실행 END                                                             = */
    '/* ============================================================================== */


    '/* ============================================================================== */
    '/* =   05. 승인 결과 값 추출                                                    = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   수정하지 마시기 바랍니다.                                                = */
    '/* = -------------------------------------------------------------------------- = */
    If  req_tx = "pay" Then
        If  res_cd    = "0000" Then
            tno       = c_Mesg.mf_get_data( "tno"       )  ' KCP 거래 고유 번호
            amount    = c_Mesg.mf_get_data( "amount"    )  ' KCP 실제 거래 금액
            pnt_issue = c_Mesg.mf_get_data( "pnt_issue" )  ' 결제 포인트사 코드
            coupon_mny = c_Mesg.mf_get_data ( "coupon_mny" ) ' 쿠폰금액

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-1. 신용카드 승인 결과 처리                                            = */
        '/* = -------------------------------------------------------------------------- = */
            If  use_pay_method = "100000000000" Then
                card_cd   = c_Mesg.mf_get_data ( "card_cd"   ) ' 카드사 코드
                card_name = c_Mesg.mf_get_data ( "card_name" ) ' 카드사 명
                app_time  = c_Mesg.mf_get_data ( "app_time"  ) ' 승인시간
                app_no    = c_Mesg.mf_get_data ( "app_no"    ) ' 승인번호
                noinf     = c_Mesg.mf_get_data ( "noinf"     ) ' 무이자 여부
                quota     = c_Mesg.mf_get_data ( "quota"     ) ' 할부 개월 수
                partcanc_yn = c_Mesg.mf_get_data ( "partcanc_yn" ) ' 부분취소 가능유무
                card_bin_type_01 = c_Mesg.mf_get_data ( "card_bin_type_01" ) ' 카드구분1
                card_bin_type_02 = c_Mesg.mf_get_data ( "card_bin_type_02" ) ' 카드구분2
                card_mny   = c_Mesg.mf_get_data ( "card_mny"   ) ' 카드결제금액

            '/* = -------------------------------------------------------------- = */
            '/* =   05-1.1. 복합결제(포인트+신용카드) 승인 결과 처리             = */
            '/* = -------------------------------------------------------------- = */
                If ((pnt_issue = "SCSK") Or (pnt_issue = "SCWB")) Then
                    pnt_amount   = c_Mesg.mf_get_data( "pnt_amount"   ) ' 적립금액 or 사용금액
                    pnt_app_time = c_Mesg.mf_get_data( "pnt_app_time" ) ' 승인시간
                    pnt_app_no   = c_Mesg.mf_get_data( "pnt_app_no"   ) ' 승인번호
                    add_pnt      = c_Mesg.mf_get_data( "add_pnt"      ) ' 발생 포인트
                    use_pnt      = c_Mesg.mf_get_data( "use_pnt"      ) ' 사용가능 포인트
                    rsv_pnt      = c_Mesg.mf_get_data( "rsv_pnt"      ) ' 총 누적 포인트
                    total_amount = amount + pnt_amount                  ' 복합결제시 총 거래금액
                End If

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-2. 계좌이체 승인 결과 처리                                            = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "010000000000" Then
                app_time  = c_Mesg.mf_get_data ( "app_time"   ) ' 승인시간
                bank_name = c_Mesg.mf_get_data ( "bank_name"  ) ' 은행명
                bank_code = c_Mesg.mf_get_data ( "bank_code"  ) ' 은행코드
                bk_mny     = c_Mesg.mf_get_data ( "bk_mny"     ) ' 계좌이체결제금액

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-3. 가상계좌 승인 결과 처리                                            = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "001000000000" Then
                bankname  = c_Mesg.mf_get_data ( "bankname"  ) ' 입금할 은행 이름
                depositor = c_Mesg.mf_get_data ( "depositor" ) ' 입금할 계좌 예금주
                account   = c_Mesg.mf_get_data ( "account"   ) ' 입금할 계좌 번호
                va_date   = c_Mesg.mf_get_data ( "va_date"   ) ' 가상계좌 입금마감시간

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-4. 포인트 승인 결과 처리                                              = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "000100000000" Then
                pnt_amount   = c_Mesg.mf_get_data ( "pnt_amount"   ) ' 적립금액 or 사용금액
                pnt_app_time = c_Mesg.mf_get_data ( "pnt_app_time" ) ' 승인시간
                pnt_app_no   = c_Mesg.mf_get_data ( "pnt_app_no"   ) ' 승인번호
                add_pnt      = c_Mesg.mf_get_data ( "add_pnt"      ) ' 발생 포인트
                use_pnt      = c_Mesg.mf_get_data ( "use_pnt"      ) ' 사용가능 포인트
                rsv_pnt      = c_Mesg.mf_get_data ( "rsv_pnt"      ) ' 총 누적 포인트

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-5. 휴대폰 승인 결과 처리                                              = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "000010000000" Then
                app_time  = c_Mesg.mf_get_data ( "hp_app_time"  ) ' 승인 시간
                commid    = c_Mesg.mf_get_data ( "commid"       ) ' 통신사 코드
                mobile_no = c_Mesg.mf_get_data ( "mobile_no"    ) ' 휴대폰 번호

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-6. 상품권 승인 결과 처리                                              = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "000000001000" Then
                app_time    = c_Mesg.mf_get_data ( "tk_app_time"  ) ' 승인 시간
                tk_van_code = c_Mesg.mf_get_data ( "tk_van_code"  ) ' 발급사 코드
                tk_app_no   = c_Mesg.mf_get_data ( "tk_app_no"    ) ' 승인 번호

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-7. 현금영수증 승인 결과 처리                                          = */
        '/* = -------------------------------------------------------------------------- = */
            End If

            cash_authno = c_Mesg.mf_get_data ( "cash_authno" )   ' 현금영수증 승인번호\
            cash_no     = c_Mesg.mf_get_data ( "cash_no"     )   ' 현금영수증 거래번호            
        End If
    End If
    '/* = -------------------------------------------------------------------------- = */
    '/* =   05. 승인 결과 처리 END                                                   = */
    '/* ============================================================================== */


    '/* = ========================================================================== = */
    '/* =   06. 승인 및 실패 결과 DB 처리                                            = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =      결과를 업체 자체적으로 DB 처리 작업하시는 부분입니다.                 = */
    '/* = -------------------------------------------------------------------------- = */

    If  req_tx = "pay" Then

    '/* = -------------------------------------------------------------------------- = */
    '/* =   06-1. 승인 결과 DB 처리(res_cd == "0000")                                = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =        각 결제수단을 구분하시어 DB 처리를 하시기 바랍니다.                 = */
    '/* = -------------------------------------------------------------------------- = */
        If  res_cd = "0000" Then

            ' 06-1-1. 신용카드
            If  use_pay_method = "100000000000" Then

                ' 06-1-1-1. 복합결제(신용카드+포인트)
                If  ((pnt_issue = "SCSK") Or  (pnt_issue = "SCWB" )) Then

                End If

								myServer="211.43.212.183"
								myID="techworld"
								myPWD="xpzmdnjfem#"
								myDB="techworld_co_kr"
			
								set DbCon = server.CreateObject("ADODB.connection") 
								DbCon.Open "Provider=SQLOLEDB.1;Password="&myPWD&";Persist Security Info=False;User ID="&myID&";Initial Catalog="&myDB&";Data Source="&myServer
                                'sql="update intra_seminar_all set c_check_YN='Y' where idx="&param_opt_1
								sql="update intra_seminar_all set c_check_YN='Y' where c_name='"&buyr_name&"' and c_email='"&buyr_mail&"' and type='aisemicon2023'"
								DbCon.execute(sql)

            ' 06-1-2. 계좌이체
            ElseIf  use_pay_method = "010000000000" Then

            ' 06-1-3. 가상계좌
            ElseIf  use_pay_method = "001000000000" Then

            ' 06-1-4. 포인트
            ElseIf  use_pay_method = "000100000000" Then

            ' 06-1-5. 휴대폰
            ElseIf  use_pay_method = "000010000000" Then

            ' 06-1-6. 상품권
            ElseIf  use_pay_method = "000000001000" Then

            End If

        '/* = -------------------------------------------------------------------------- = */
        '/* =   06-2. 승인 실패 DB 처리(res_cd != "0000")                                = */
        '/* = -------------------------------------------------------------------------- = */
        ElseIf  res_cd <> "0000"  Then
'					response.Write(res_cd)
'	        Response.end()
					
        End If
    End If
    '/* = -------------------------------------------------------------------------- = */
    '/* =   06. 승인 및 실패 결과 DB 처리 END                                        = */
    '/* = ========================================================================== = */


    '/* = ========================================================================== = */
    '/* =   07. 승인 결과 DB 처리 실패시 : 자동취소                                  = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =      승인 결과를 DB 작업 하는 과정에서 정상적으로 승인된 건에 대해         = */
    '/* =      DB 작업을 실패하여 DB update 가 완료되지 않은 경우, 자동으로          = */
    '/* =      승인 취소 요청을 하는 프로세스가 구성되어 있습니다.                   = */
    '/* =                                                                            = */
    '/* =      DB 작업이 실패 한 경우, bSucc 라는 변수(String)의 값을 "false"        = */
    '/* =      로 설정해 주시기 바랍니다. (DB 작업 성공의 경우에는 "false" 이외의    = */
    '/* =      값을 설정하시면 됩니다.)                                              = */
    '/* = -------------------------------------------------------------------------- = */

    ' 승인 결과 DB 처리 에러시 bSucc값을 false로 설정하여 거래건을 취소 요청
    bSucc = ""

    If  req_tx = "pay" Then
        If  res_cd = "0000" Then
            If bSucc = "false" Then

                c_Payplus.lf_PP_CLI_LIB__init g_conf_key_dir, g_conf_log_dir, "03", g_conf_gw_url, g_conf_gw_port

                tran_cd = "00200000"

                mod_data = c_Mesg.mf_set_modx_data( "tno",      tno     )  ' KCP 원거래 거래번호
                mod_data = c_Mesg.mf_set_modx_data( "mod_type", "STSC"  )  ' 원거래 변경 요청 종류
                mod_data = c_Mesg.mf_set_modx_data( "mod_ip",   cust_ip )  ' 변경 요청자 IP
                mod_data = c_Mesg.mf_set_modx_data( "mod_desc", "가맹점 결과 처리 오류 - 가맹점에서 취소 요청" ) ' 변경 사유

                c_PayPlus.lf_PP_CLI_LIB__set_plan_data mod_data

                c_Payplus.lf_PP_CLI_LIB__do_tx g_conf_site_cd, g_conf_site_key, tran_cd, "", ordr_idxx
                resp_mesg = c_Payplus.lf_PP_CLI_LIB__get_data
                c_Mesg.mf_set_res_data(resp_mesg)                               ' 응답 전문 처리

                res_cd  = c_Mesg.mf_get_data ("res_cd")                         ' 결과 코드
                res_msg = c_Mesg.mf_get_data ("res_msg")                        ' 결과 메시지

            End If
        End If
    End If
        ' End of [res_cd = "0000"]
    '/* = -------------------------------------------------------------------------- = */
    '/* =   07. 승인 결과 DB 처리 END                                                = */
    '/* = ========================================================================== = */


    '/* ============================================================================== */
    '/* =   08. 인스턴스 CleanUp                                                     = */
    '/* = -------------------------------------------------------------------------- = */
    set  c_Payplus = nothing
    set  c_Mesg    = nothing
    '/* ============================================================================== */


    '/* ============================================================================== */
    '/* =   09. 폼 구성 및 결과페이지 호출                                           = */
    '/* = -------------------------------------------------------------------------- = */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <title>*** NHN KCP Online Payment System Ver 6.0[AX-HUB Version] ***</title>
        <script type="text/javascript">
            function goResult()
            {
                var openwin = window.open( 'proc_win.html', 'proc_win', '' )
                document.pay_info.submit()
                openwin.close()
            }

            // 결제 중 새로고침 방지 샘플 스크립트
            function noRefresh()
            {
                /* CTRL + N키 막음. */
                if ((event.keyCode == 78) && (event.ctrlKey == true))
                {
                    event.keyCode = 0;
                    return false;
                }
                /* F5 번키 막음. */
                if(event.keyCode == 116)
                {
                    event.keyCode = 0;
                    return false;
                }
            }
            document.onkeydown = noRefresh ;
        </script>
    </head>


   <body onload="goResult();" >
    <form name="pay_info" method="post" action="../sub/thankyou/">
        <input type="hidden" name="site_cd"         value="<%= g_conf_site_cd %>">     <!-- 사이트코드 -->
        <input type="hidden" name="req_tx"          value="<%= req_tx         %>">     <!-- 요청 구분 -->
        <input type="hidden" name="use_pay_method"  value="<%= use_pay_method %>">     <!-- 사용한 결제 수단 -->
        <input type="hidden" name="bSucc"           value="<%= bSucc          %>">     <!-- 쇼핑몰 DB 처리 성공 여부 -->

        <input type="hidden" name="amount"          value="<%= amount         %>">     <!-- KCP 실제 거래 금액 -->
        <input type="hidden" name="res_cd"          value="<%= res_cd         %>">     <!-- 결과 코드 -->
        <input type="hidden" name="res_msg"         value="<%= res_msg        %>">     <!-- 결과 메세지 -->
        <input type="hidden" name="ordr_idxx"       value="<%= ordr_idxx      %>">     <!-- 주문번호 -->
        <input type="hidden" name="tno"             value="<%= tno            %>">     <!-- KCP 거래번호 -->
        <input type="hidden" name="good_name"       value="<%= good_name      %>">     <!-- 상품명 -->
        <input type="hidden" name="buyr_name"       value="<%= buyr_name      %>">     <!-- 주문자명 -->
        <input type="hidden" name="buyr_tel1"       value="<%= buyr_tel1      %>">     <!-- 주문자 전화번호 -->
        <input type="hidden" name="buyr_tel2"       value="<%= buyr_tel2      %>">     <!-- 주문자 휴대폰번호 -->
        <input type="hidden" name="buyr_mail"       value="<%= buyr_mail      %>">     <!-- 주문자 E-mail -->

        <input type="hidden" name="app_time"        value="<%= app_time       %>">     <!-- 승인시간 -->
        <!-- 신용카드 정보 -->
        <input type="hidden" name="card_cd"         value="<%= card_cd        %>">     <!-- 카드코드 -->
        <input type="hidden" name="card_name"       value="<%= card_name      %>">     <!-- 카드이름 -->
        <input type="hidden" name="app_no"          value="<%= app_no         %>">     <!-- 승인번호 -->
        <input type="hidden" name="noinf"           value="<%= noinf          %>">     <!-- 무이자여부 -->
        <input type="hidden" name="quota"           value="<%= quota          %>">     <!-- 할부개월 -->
        <input type="hidden" name="partcanc_yn"     value="<%= partcanc_yn    %>">     <!-- 부분취소가능유무 -->
        <input type="hidden" name="card_bin_type_01" value="<%= card_bin_type_01 %>">  <!-- 카드구분1 -->
        <input type="hidden" name="card_bin_type_02" value="<%= card_bin_type_02 %>">  <!-- 카드구분2 -->
        <!-- 계좌이체 정보 -->
        <input type="hidden" name="bank_code"       value="<%= bank_code      %>">     <!-- 은행코드 -->
        <input type="hidden" name="bank_name"       value="<%= bank_name      %>">     <!-- 은행명 -->
        <!-- 가상계좌 정보 -->
        <input type="hidden" name="bankname"        value="<%= bankname       %>">     <!-- 입금 은행 -->
        <input type="hidden" name="depositor"       value="<%= depositor      %>">     <!-- 입금계좌 예금주 -->
        <input type="hidden" name="account"         value="<%= account        %>">     <!-- 입금계좌 번호 -->
        <input type="hidden" name="va_date"         value="<%= va_date        %>">     <!-- 가상계좌 입금마감시간 -->
        <!-- 포인트 정보 -->
        <input type="hidden" name="pnt_issue"       value="<%= pnt_issue      %>">     <!-- 포인트 서비스사 -->
        <input type="hidden" name="pnt_amount"      value="<%= pnt_amount     %>">     <!-- 적립금액 or 사용금액 -->
        <input type="hidden" name="pnt_app_time"    value="<%= pnt_app_time   %>">     <!-- 승인시간 -->
        <input type="hidden" name="pnt_app_no"      value="<%= pnt_app_no     %>">     <!-- 승인번호 -->
        <input type="hidden" name="add_pnt"         value="<%= add_pnt        %>">     <!-- 발생 포인트 -->
        <input type="hidden" name="use_pnt"         value="<%= use_pnt        %>">     <!-- 사용가능 포인트 -->
        <input type="hidden" name="rsv_pnt"         value="<%= rsv_pnt        %>">     <!-- 총 누적 포인트 -->
        <!-- 휴대폰 정보 -->
        <input type="hidden" name="commid"          value="<%= commid         %>">     <!-- 통신사 코드 -->
        <input type="hidden" name="mobile_no"       value="<%= mobile_no      %>">     <!-- 휴대폰 번호 -->
        <!-- 상품권 정보 -->
        <input type="hidden" name="tk_van_code"     value="<%= tk_van_code    %>">     <!-- 발급사 코드 -->
        <input type="hidden" name="tk_app_no"       value="<%= tk_app_no      %>">     <!-- 승인 번호 -->
        <!-- 현금영수증 정보 -->
        <input type="hidden" name="cash_yn"         value="<%= cash_yn        %>">     <!-- 현금영수증 등록 여부 -->
        <input type="hidden" name="cash_authno"     value="<%= cash_authno    %>">     <!-- 현금 영수증 승인 번호 -->
        <input type="hidden" name="cash_tr_code"    value="<%= cash_tr_code   %>">     <!-- 현금 영수증 발행 구분 -->
        <input type="hidden" name="cash_id_info"    value="<%= cash_id_info   %>">     <!-- 현금 영수증 등록 번호 -->
        <input type="hidden" name="cash_no"         value="<%= cash_no        %>">     <!-- 현금 영수증 거래 번호 -->        
        
        
    </form>
    </body>
</html>
