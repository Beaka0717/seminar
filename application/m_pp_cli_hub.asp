<%
    '/* ============================================================================== */
    '/* =   PAGE : ���� ��û �� ��� ó�� PAGE                                       = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   ������ ������ �߻��ϴ� ��� �Ʒ��� �ּҷ� �����ϼż� Ȯ���Ͻñ� �ٶ��ϴ�.= */
    '/* =   ���� �ּ� : http://kcp.co.kr/technique.requestcode.do                    = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   Copyright (c)  2016  NHN KCP Inc.   All Rights Reserverd.                = */
    '/* ============================================================================== */

    '/* ============================================================================== */
    '/* =   ȯ�� ���� ���� Include                                                   = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   �� �ʼ�                                                                  = */
    '/* =   �׽�Ʈ �� �ǰ��� ������ site_conf_inc.asp������ �����Ͻñ� �ٶ��ϴ�.     = */
    '/* = -------------------------------------------------------------------------- = */
%>
    <!-- #include file = "./m_cfg/site_conf_inc.asp" -->      <!-- ' ȯ�漳�� ���� include -->
    <!-- #include file = "./m_pp_cli_hub_lib.asp" -->              <!-- ' library [�����Ұ�] -->
<%
    '/* = -------------------------------------------------------------------------- = */
    '/* =   ȯ�� ���� ���� Include END                                               = */
    '/* ============================================================================== */
%>
<%
    '/* ============================================================================== */
    '/* =   POST ���� üũ�κ�                                                            = */
    '/* = -------------------------------------------------------------------------- = */
    if Request.ServerVariables("REQUEST_METHOD") <> "POST" then 
        Response.write "���������� �����ϼž� �մϴ�." 
        Response.end 
    end if 
    '/* ============================================================================== */
%> 
<%
    '/* ============================================================================== */
    '/* =   01. ���� ��û ���� ����                                                  = */
    '/* = -------------------------------------------------------------------------- = */
    req_tx         = Request( "req_tx"         )               ' ��û ����
    tran_cd        = Request( "tran_cd"        )               ' ó�� ����
    '/* = -------------------------------------------------------------------------- = */
    cust_ip        = Request.ServerVariables( "REMOTE_ADDR" )  ' ��û IP
    ordr_idxx      = Request( "ordr_idxx"      )               ' ���θ� �ֹ���ȣ
    good_name      = Request( "good_name"      )               ' ��ǰ��
    '/* = -------------------------------------------------------------------------- = */
    res_cd         = ""                                        ' �����ڵ�
    res_msg        = ""                                        ' ���� �޼���
    tno            = Request( "tno"            )               ' KCP �ŷ� ���� ��ȣ
    '/* = -------------------------------------------------------------------------- = */
    buyr_name      = Request( "buyr_name"      )               ' �ֹ��ڸ�
    buyr_tel1      = Request( "buyr_tel1"      )               ' �ֹ��� ��ȭ��ȣ
    buyr_tel2      = Request( "buyr_tel2"      )               ' �ֹ��� �ڵ��� ��ȣ
    buyr_mail      = Request( "buyr_mail"      )               ' �ֹ��� E-mail �ּ�
    '/* = -------------------------------------------------------------------------- = */
    use_pay_method = Request( "use_pay_method" )               ' ���� ���
    bSucc          = ""                                        ' ��ü DB ó�� ���� ����
    '/* = -------------------------------------------------------------------------- = */
    app_time       = ""                                        ' ���νð� (��� ���� ���� ����)
    amount         = ""                                        ' KCP ���� �ŷ��ݾ�         
    '/* = -------------------------------------------------------------------------- = */
    card_cd        = ""                                        ' �ſ�ī�� �ڵ�
    card_name      = ""                                        ' �ſ�ī�� ��
    app_no         = ""                                        ' �ſ�ī�� ���ι�ȣ
    noinf          = ""                                        ' �ſ�ī�� ������ ����
    quota          = ""                                        ' �ſ�ī�� �Һΰ���
    partcanc_yn    = ""                                        ' �κ���� ��������
    card_bin_type_01 = ""                                      ' ī�屸��1
    card_bin_type_02 = ""                                      ' ī�屸��2
    '/* = -------------------------------------------------------------------------- = */
    bank_name      = ""                                        ' �����
    bank_code      = ""                                        ' �����ڵ�
    '/* = -------------------------------------------------------------------------- = */
    bankname       = ""                                        ' �Ա� �����
    depositor      = ""                                        ' �Ա� ���� ������ ����
    account        = ""                                        ' �Ա� ���� ��ȣ
    va_date        = ""                                        ' ������� �Աݸ����ð�
    '/* = -------------------------------------------------------------------------- = */
    pnt_issue      = ""                                        ' ���� ����Ʈ�� �ڵ�
    pnt_amount     = ""                                        ' �����ݾ� or ���ݾ�
    pnt_app_time   = ""                                        ' ���νð�
    pnt_app_no     = ""                                        ' ���ι�ȣ
    add_pnt        = ""                                        ' �߻� ����Ʈ
    use_pnt        = ""                                        ' ��밡�� ����Ʈ
    rsv_pnt        = ""                                        ' �� ���� ����Ʈ
    '/* = -------------------------------------------------------------------------- = */
    commid         = ""                                        ' ��Ż��ڵ�
    mobile_no      = ""                                        ' �޴�����ȣ
    '/* = -------------------------------------------------------------------------- = */
    tk_van_code    = ""                                        ' �߱޻��ڵ�
    tk_app_no      = ""                                        ' ���ι�ȣ
    '/* = -------------------------------------------------------------------------- = */
    cash_yn        = Request( "cash_yn"        )               ' ���� ������ ��� ����
    cash_authno    = ""                                        ' ���� ������ ���� ��ȣ
    cash_tr_code   = Request( "cash_tr_code"   )               ' ���� ������ ���� ����
    cash_id_info   = Request( "cash_id_info"   )               ' ���� ������ ��� ��ȣ
    cash_no        = ""                                        ' ���� ������ �ŷ� ��ȣ      

    param_opt_1    = Request( "param_opt_1" )
    param_opt_2    = Request( "param_opt_2" )
    param_opt_3    = Request( "param_opt_3" )

    '/* ============================================================================== */
    '/* =   01. ���� ��û ���� ���� END
    '/* ============================================================================== */

    '/* ============================================================================== */
    '/* =   02. �ν��Ͻ� ���� �� �ʱ�ȭ(���� �Ұ�)                                   = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   ������ �ʿ��� �ν��Ͻ��� �����ϰ� �ʱ�ȭ �մϴ�.                         = */
    '/* =   �� ���� �� �� �κ��� �������� ���ʽÿ�                                   = */
    '/* = -------------------------------------------------------------------------- = */
    Set c_Mesg = New c_PayPlusData             ' ����ó���� Class (library���� ���ǵ�)
    c_Mesg.InitialTX

    Set c_Payplus = Server.CreateObject( "pp_cli_com.KCP" )
    c_Payplus.lf_PP_CLI_LIB__init g_conf_key_dir, g_conf_log_dir, "03", g_conf_gw_url, g_conf_gw_port

    '/* = -------------------------------------------------------------------------- = */
    '/* =   02. �ν��Ͻ� ���� �� �ʱ�ȭ END                                          = */
    '/* ============================================================================== */

    '/* ============================================================================== */
    '/* =   03. ó�� ��û ���� ����                                                  = */
    '/* = -------------------------------------------------------------------------- = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   03-1. ���� ��û ���� ����                                                = */
    '/* = -------------------------------------------------------------------------- = */

    If req_tx = "pay" Then

        '/ 1 ���� ������ ��ü���� �����ϼž� �� �� �ݾ��� �־��ּž� �մϴ�. �����ݾ� ��ȿ�� ����'/
        payx_data_set = ""
        ordr_data_set = ""

        'ordr_data_set = c_Mesg.mf_set_ordr_data( "ordr_mony", "1") '�ݾ� üũ
		ordr_data_set = c_Mesg.mf_set_ordr_data( "ordr_mony", request("amount")) '�ݾ� üũ

        c_Mesg.InitialTX

        tx_req_data_set = c_Mesg.mf_set_req_data( ordr_data_set )
        c_Mesg.InitialTX

        c_PayPlus.lf_PP_CLI_LIB__set_plan_data tx_req_data_set
        c_Mesg.InitialTX

        c_PayPlus.lf_PP_CLI_LIB__set_crypto_info trace_no, request("enc_info"), request("enc_data")

    End If
    '/* = -------------------------------------------------------------------------- = */
    '/* =   03. ó�� ��û ���� ���� END                                              = */
    '/* ============================================================================== */

    '/* ============================================================================== */
    '/* =   04. ����                                                                 = */
    '/* = -------------------------------------------------------------------------- = */
    If tran_cd <> "" Then

        c_Payplus.lf_PP_CLI_LIB__do_tx g_conf_site_cd, g_conf_site_key, tran_cd, "", ordr_idxx
        resp_mesg = c_Payplus.lf_PP_CLI_LIB__get_data
        c_Mesg.mf_set_res_data(resp_mesg)                               ' ���� ���� ó��

    Else

        res_cd  = "9562"
        res_msg = "���� ����|tran_cd���� �������� �ʾҽ��ϴ�."

    End If

        res_cd  = c_Mesg.mf_get_data ("res_cd")                         ' ��� �ڵ�
        res_msg = c_Mesg.mf_get_data ("res_msg")                        ' ��� �޽���

    '/* = -------------------------------------------------------------------------- = */
    '/* =   04. ���� END                                                             = */
    '/* ============================================================================== */

    '/* ============================================================================== */
    '/* =   05. ���� ��� �� ����                                                    = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   �������� ���ñ� �ٶ��ϴ�.                                                = */
    '/* = -------------------------------------------------------------------------- = */
    If  req_tx = "pay" Then

        If  res_cd    = "0000" Then

          tno             = c_Mesg.mf_get_data( "tno"       ) ' KCP �ŷ� ���� ��ȣ
          amount          = c_Mesg.mf_get_data( "amount"    ) ' KCP ���� �ŷ� �ݾ�
          app_time        = c_Mesg.mf_get_data( "app_time"  ) ' ���νð�
          pnt_issue       = c_Mesg.mf_get_data( "pnt_issue" ) ' ���� ����Ʈ�� �ڵ�

    '/* = -------------------------------------------------------------------------- = */
    '/* =   05-1. �ſ�ī�� ���� ��� ó��                                            = */
    '/* = -------------------------------------------------------------------------- = */
            If  use_pay_method = "100000000000" Then

                card_cd   = c_Mesg.mf_get_data ( "card_cd"   ) ' ī��� �ڵ�
                card_name = c_Mesg.mf_get_data ( "card_name" ) ' ī��� ��
                app_no    = c_Mesg.mf_get_data ( "app_no"    ) ' ���ι�ȣ
                noinf     = c_Mesg.mf_get_data ( "noinf"     ) ' ������ ����
                quota     = c_Mesg.mf_get_data ( "quota"     ) ' �Һ� ���� ��
                partcanc_yn = c_Mesg.mf_get_data ( "partcanc_yn" ) ' �κ���� ��������

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-2. ������ü ���� ��� ó��                                            = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "010000000000" Then

                bank_name = c_Mesg.mf_get_data ( "bank_name"  ) ' �����
                bank_code = c_Mesg.mf_get_data ( "bank_code"  ) ' �����ڵ�

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-3. ������� ���� ��� ó��                                            = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "001000000000" Then

                bankname  = c_Mesg.mf_get_data ( "bankname"  ) ' �Ա��� ���� �̸�
                depositor = c_Mesg.mf_get_data ( "depositor" ) ' �Ա��� ���� ������
                account   = c_Mesg.mf_get_data ( "account"   ) ' �Ա��� ���� ��ȣ
                va_date   = c_Mesg.mf_get_data ( "va_date"   ) ' ������� �Աݸ����ð�

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-4. ����Ʈ ���� ��� ó��                                              = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "000100000000" Then

                pnt_amount   = c_Mesg.mf_get_data ( "pnt_amount"   ) ' �����ݾ� or ���ݾ�
                pnt_app_time = c_Mesg.mf_get_data ( "pnt_app_time" ) ' ���νð�
                pnt_app_no   = c_Mesg.mf_get_data ( "pnt_app_no"   ) ' ���ι�ȣ
                add_pnt      = c_Mesg.mf_get_data ( "add_pnt"      ) ' �߻� ����Ʈ
                use_pnt      = c_Mesg.mf_get_data ( "use_pnt"      ) ' ��밡�� ����Ʈ
                rsv_pnt      = c_Mesg.mf_get_data ( "rsv_pnt"      ) ' �� ���� ����Ʈ

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-5. �޴��� ���� ��� ó��                                              = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "000010000000" Then

                app_time  = c_Mesg.mf_get_data ( "hp_app_time"  ) ' ���� �ð�
                commid    = c_Mesg.mf_get_data ( "commid"       ) ' ��Ż� �ڵ�
                mobile_no = c_Mesg.mf_get_data ( "mobile_no"    ) ' �޴��� ��ȣ

        '/* = -------------------------------------------------------------------------- = */
        '/* =   05-6. ��ǰ�� ���� ��� ó��                                              = */
        '/* = -------------------------------------------------------------------------- = */
            ElseIf  use_pay_method = "000000001000" Then

                app_time    = c_Mesg.mf_get_data ( "tk_app_time"  ) ' ���� �ð�
                tk_van_code = c_Mesg.mf_get_data ( "tk_van_code"  ) ' �߱޻� �ڵ�
                tk_app_no   = c_Mesg.mf_get_data ( "tk_app_no"    ) ' ���� ��ȣ

            End If

    '/* = -------------------------------------------------------------------------- = */
    '/* =   05-7. ���ݿ����� ���� ��� ó��                                          = */
    '/* = -------------------------------------------------------------------------- = */
            cash_authno = c_Mesg.mf_get_data ( "cash_authno" )   ' ���ݿ����� ���ι�ȣ
            cash_no     = c_Mesg.mf_get_data ( "cash_no"     )   ' ���ݿ����� �ŷ���ȣ            

        End If

    End If
    '/* = -------------------------------------------------------------------------- = */
    '/* =   05. ���� ��� ó�� END                                                   = */
    '/* ============================================================================== */

    '/* = ========================================================================== = */
    '/* =   06. ���� �� ���� ��� DB ó��                                            = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =      ����� ��ü ��ü������ DB ó�� �۾��Ͻô� �κ��Դϴ�.                 = */
    '/* = -------------------------------------------------------------------------- = */

    If  req_tx = "pay" Then

    '/* = -------------------------------------------------------------------------- = */
    '/* =   06-1. ���� ��� DB ó��(res_cd == "0000")                                = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =        �� ���������� �����Ͻþ� DB ó���� �Ͻñ� �ٶ��ϴ�.                 = */
    '/* = -------------------------------------------------------------------------- = */
        If  res_cd = "0000" Then

            ' 06-1-1. �ſ�ī��
            If  use_pay_method = "100000000000" Then

            ' 06-1-2. ������ü
            ElseIf  use_pay_method = "010000000000" Then

            ' 06-1-3. �������
            ElseIf  use_pay_method = "001000000000" Then

            ' 06-1-4. ����Ʈ
            ElseIf  use_pay_method = "000100000000" Then

            ' 06-1-5. �޴���
            ElseIf  use_pay_method = "000010000000" Then

            ' 06-1-6. ��ǰ��
            ElseIf  use_pay_method = "000000001000" Then

        	End If
						
            myServer="211.43.212.183"
            myID="techworld"
            myPWD="xpzmdnjfem#"
            myDB="techworld_co_kr"

            set DbCon = server.CreateObject("ADODB.connection") 
            DbCon.Open "Provider=SQLOLEDB.1;Password="&myPWD&";Persist Security Info=False;User ID="&myID&";Initial Catalog="&myDB&";Data Source="&myServer
            'sql="update intra_seminar_all set c_check_YN='Y' where c_name='"&buyr_name&"' and c_email='"&buyr_mail&"' and type='aisemicon2023'"
			 sql="update intra_seminar_all set c_check_YN='Y', c_memo='����ϰ���' where idx="&param_opt_1
'Response.write sql
'Response.End()
            DbCon.execute(sql)
            
        '/* = -------------------------------------------------------------------------- = */
        '/* =   06-2. ���� ���� DB ó��(res_cd != "0000")                                = */
        '/* = -------------------------------------------------------------------------- = */
        ElseIf  res_cd <> "0000"  Then

            myServer="211.43.212.183"
            myID="techworld"
            myPWD="xpzmdnjfem#"
            myDB="techworld_co_kr"

            set DbCon = server.CreateObject("ADODB.connection") 
            DbCon.Open "Provider=SQLOLEDB.1;Password="&myPWD&";Persist Security Info=False;User ID="&myID&";Initial Catalog="&myDB&";Data Source="&myServer
             sql="update intra_seminar_all set c_memo='����� ��������/"&res_cd&"/"&res_msg&"' where idx="&param_opt_1
'Response.write sql&"<br>"
'Response.write res_cd&"<br>"
'Response.write res_msg&"<br>"
'Response.End()
            DbCon.execute(sql)

        End If

    End If

    '/* = -------------------------------------------------------------------------- = */
    '/* =   06. ���� �� ���� ��� DB ó�� END                                        = */
    '/* = ========================================================================== = */


    '/* = ========================================================================== = */
    '/* =   07. ���� ��� DB ó�� ���н� : �ڵ����                                  = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =      ���� ����� DB �۾� �ϴ� �������� ���������� ���ε� �ǿ� ����         = */
    '/* =      DB �۾��� �����Ͽ� DB update �� �Ϸ���� ���� ���, �ڵ�����          = */
    '/* =      ���� ��� ��û�� �ϴ� ���μ����� �����Ǿ� �ֽ��ϴ�.                   = */
    '/* =                                                                            = */
    '/* =      DB �۾��� ���� �� ���, bSucc ��� ����(String)�� ���� "false"        = */
    '/* =      �� ������ �ֽñ� �ٶ��ϴ�. (DB �۾� ������ ��쿡�� "false" �̿���    = */
    '/* =      ���� �����Ͻø� �˴ϴ�.)                                              = */
    '/* = -------------------------------------------------------------------------- = */


    ' ���� ��� DB ó�� ������ bSucc���� false�� �����Ͽ� �ŷ����� ��� ��û
    bSucc = ""

    If  req_tx = "pay" Then

        If  res_cd = "0000" Then

            If bSucc = "false" Then

                c_Payplus.lf_PP_CLI_LIB__init g_conf_key_dir, g_conf_log_dir, "03", g_conf_gw_url, g_conf_gw_port

                tran_cd = "00200000"

                mod_data = c_Mesg.mf_set_modx_data( "tno",      tno     )  ' KCP ���ŷ� �ŷ���ȣ
                mod_data = c_Mesg.mf_set_modx_data( "mod_type", "STSC"  )  ' ���ŷ� ���� ��û ����
                mod_data = c_Mesg.mf_set_modx_data( "mod_ip",   cust_ip )  ' ���� ��û�� IP
                mod_data = c_Mesg.mf_set_modx_data( "mod_desc", "������ ��� ó�� ���� - ���������� ��� ��û" ) ' ���� ����

                c_PayPlus.lf_PP_CLI_LIB__set_plan_data mod_data

                c_Payplus.lf_PP_CLI_LIB__do_tx g_conf_site_cd, g_conf_site_key, tran_cd, cust_ip, ordr_idxx
                resp_mesg = c_Payplus.lf_PP_CLI_LIB__get_data
                c_Mesg.mf_set_res_data(resp_mesg)                               ' ���� ���� ó��

                res_cd  = c_Mesg.mf_get_data ("res_cd")                         ' ��� �ڵ�
                res_msg = c_Mesg.mf_get_data ("res_msg")                        ' ��� �޽���

            Else
			


            End If

        End If

    End If

        ' End of [res_cd = "0000"]
    '/* = -------------------------------------------------------------------------- = */
    '/* =   07. ���� ��� DB ó�� END                                                = */
    '/* = ========================================================================== = */

    '/* ============================================================================== */
    '/* =   08. �ν��Ͻ� CleanUp                                                     = */
    '/* = -------------------------------------------------------------------------- = */
    set  c_Payplus = nothing
    set  c_Mesg    = nothing
    '/* ============================================================================== */

    '/* ============================================================================== */
    '/* =   09. �� ���� �� ��������� ȣ��                                           = */
    '/* -----------------------------------------------------------------------------= */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>����Ʈ�� �� ����â</title>
        <script type="text/javascript">
            function goResult()
            {
                document.pay_info.submit()
            }

            // ���� �� ���ΰ�ħ ���� ���� ��ũ��Ʈ
            function noRefresh()
            {
                /* CTRL + NŰ ����. */
                if ((event.keyCode == 78) && (event.ctrlKey == true))
                {
                    event.keyCode = 0;
                    return false;
                }
                /* F5 ��Ű ����. */
                if(event.keyCode == 116)
                {
                    event.keyCode = 0;
                    return false;
                }
            }
            document.onkeydown = noRefresh ;
        </script>
</head>

<body onload="goResult();">
<form name="pay_info" method="post" action="../sub/thankyou/">
        <input type="hidden" name="site_cd"         value="<%= g_conf_site_cd   %>">    <!-- ����Ʈ �ڵ� -->
        <input type="hidden" name="req_tx"          value="<%= req_tx           %>">    <!-- ��û ���� -->
        <input type="hidden" name="use_pay_method"  value="<%= use_pay_method   %>">    <!-- ����� ���� ���� -->
        <input type="hidden" name="bSucc"           value="<%= bSucc            %>">    <!-- ���θ� DB ó�� ���� ���� -->

        <input type="hidden" name="res_cd"          value="<%= res_cd           %>">    <!-- ��� �ڵ� -->
        <input type="hidden" name="res_msg"         value="<%= res_msg          %>">    <!-- ��� �޼��� -->
        <input type="hidden" name="ordr_idxx"       value="<%= ordr_idxx        %>">    <!-- �ֹ���ȣ -->
        <input type="hidden" name="tno"             value="<%= tno              %>">    <!-- KCP �ŷ���ȣ -->
        <input type="hidden" name="good_name"       value="<%= good_name        %>">    <!-- ��ǰ�� -->
        <input type="hidden" name="buyr_name"       value="<%= buyr_name        %>">    <!-- �ֹ��ڸ� -->
        <input type="hidden" name="buyr_tel1"       value="<%= buyr_tel1        %>">    <!-- �ֹ��� ��ȭ��ȣ -->
        <input type="hidden" name="buyr_tel2"       value="<%= buyr_tel2        %>">    <!-- �ֹ��� �޴�����ȣ -->
        <input type="hidden" name="buyr_mail"       value="<%= buyr_mail        %>">    <!-- �ֹ��� E-mail -->
        <input type="hidden" name="app_time"        value="<%= app_time         %>">    <!-- ���νð� -->
        <input type="hidden" name="amount"          value="<%= amount           %>">    <!-- KCP ���� �ŷ� �ݾ� -->        

        <!-- �ſ�ī�� ���� -->
        <input type="hidden" name="card_cd"         value="<%= card_cd          %>">    <!-- ī���ڵ� -->
        <input type="hidden" name="card_name"       value="<%= card_name        %>">    <!-- ī���̸� -->
        <input type="hidden" name="app_no"          value="<%= app_no           %>">    <!-- ���ι�ȣ -->
        <input type="hidden" name="noinf"           value="<%= noinf            %>">    <!-- �����ڿ��� -->
        <input type="hidden" name="quota"           value="<%= quota            %>">    <!-- �Һΰ��� -->
        <input type="hidden" name="partcanc_yn"     value="<%= partcanc_yn      %>">    <!-- �κ���Ұ������� -->
        <input type="hidden" name="card_bin_type_01"value="<%= card_bin_type_01 %>">    <!-- ī�屸��1 -->
        <input type="hidden" name="card_bin_type_02"value="<%= card_bin_type_02 %>">    <!-- ī�屸��2 -->
        <!-- ������ü ���� -->
        <input type="hidden" name="bank_name"       value="<%= bank_name        %>">    <!-- ����� -->
        <input type="hidden" name="bank_code"       value="<%= bank_code        %>">    <!-- �����ڵ� -->
        <!-- ������� ���� -->
        <input type="hidden" name="bankname"        value="<%= bankname         %>">    <!-- �Ա� ���� -->
        <input type="hidden" name="depositor"       value="<%= depositor        %>">    <!-- �Աݰ��� ������ -->
        <input type="hidden" name="account"         value="<%= account          %>">    <!-- �Աݰ��� ��ȣ -->
        <input type="hidden" name="va_date"         value="<%= va_date          %>">    <!-- ������� �Աݸ����ð� -->
        <!-- ����Ʈ ���� -->
        <input type="hidden" name="pnt_issue"       value="<%= pnt_issue        %>">    <!-- ����Ʈ ���񽺻� -->
        <input type="hidden" name="pnt_app_time"    value="<%= pnt_app_time     %>">    <!-- ���νð� -->
        <input type="hidden" name="pnt_app_no"      value="<%= pnt_app_no       %>">    <!-- ���ι�ȣ -->
        <input type="hidden" name="pnt_amount"      value="<%= pnt_amount       %>">    <!-- �����ݾ� or ���ݾ� -->
        <input type="hidden" name="add_pnt"         value="<%= add_pnt          %>">    <!-- �߻� ����Ʈ -->
        <input type="hidden" name="use_pnt"         value="<%= use_pnt          %>">    <!-- ��밡�� ����Ʈ -->
        <input type="hidden" name="rsv_pnt"         value="<%= rsv_pnt          %>">    <!-- �� ���� ����Ʈ -->
        <!-- �޴��� ���� -->
        <input type="hidden" name="commid"          value="<%= commid           %>">    <!-- ��Ż� �ڵ� -->
        <input type="hidden" name="mobile_no"       value="<%= mobile_no        %>">    <!-- �޴��� ��ȣ -->

        <!-- ��ǰ�� ���� -->
        <input type="hidden" name="tk_van_code"     value="<%= tk_van_code      %>">    <!-- �߱޻� �ڵ� -->
        <input type="hidden" name="tk_app_no"       value="<%= tk_app_no        %>">    <!-- ���� ��ȣ -->
        <!-- ���ݿ����� ���� -->
        <input type="hidden" name="cash_yn"         value="<%= cash_yn          %>">    <!-- ���ݿ����� ��� ���� -->
        <input type="hidden" name="cash_authno"     value="<%= cash_authno      %>">    <!-- ���� ������ ���� ��ȣ -->
        <input type="hidden" name="cash_tr_code"    value="<%= cash_tr_code     %>">    <!-- ���� ������ ���� ���� -->
        <input type="hidden" name="cash_id_info"    value="<%= cash_id_info     %>">    <!-- ���� ������ ��� ��ȣ -->
        <input type="hidden" name="cash_no"         value="<%= cash_no          %>">    <!-- ���� ������ �ŷ� ��ȣ -->            

        <input type="hidden" name="param_opt_1"     value="<%= param_opt_1 %>">
        <input type="hidden" name="param_opt_2"     value="<%= param_opt_2 %>">
        <input type="hidden" name="param_opt_3"     value="<%= param_opt_3 %>">
</form>
</body>
</html>
