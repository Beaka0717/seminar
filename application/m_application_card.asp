<%
    '/* ============================================================================== */
    '/* =   PAGE : ���� ��û PAGE                                                    = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   �� �������� Payplus Plug-in�� ���ؼ� �����ڰ� ���� ��û�� �ϴ� ������    = */
    '/* =   �Դϴ�. �Ʒ��� �� �ʼ�, �� �ɼ� �κа� �Ŵ����� �����ϼż� ������        = */
    '/* =   �����Ͽ� �ֽñ� �ٶ��ϴ�.                                                = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   ������ ������ �߻��ϴ� ��� �Ʒ��� �ּҷ� �����ϼż� Ȯ���Ͻñ� �ٶ��ϴ�.= */
    '/* =   ���� �ּ� : http://kcp.co.kr/technique.requestcode.do                    = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   Copyright (c)  2016  NHN KCP Inc.   All Rights Reserverd.                = */
    '/* ============================================================================== */
%>
<%
    '/* ============================================================================== */
    '/* =   ȯ�� ���� ���� Include                                                   = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   �� �ʼ�                                                                  = */
    '/* =   �׽�Ʈ �� �ǰ��� ������ site_conf_inc.asp������ �����Ͻñ� �ٶ��ϴ�.     = */
    '/* = -------------------------------------------------------------------------- = */
%>
    <!-- #include file = "./m_cfg/site_conf_inc.asp" -->         <!-- ' ȯ�漳�� ���� include -->
<%
    '/* = -------------------------------------------------------------------------- = */
    '/* =   ȯ�� ���� ���� Include END                                               = */
    '/* ============================================================================== */
%>
<%
    ' kcp�� ����� kcp �������� ���۵Ǵ� ���� ��û ����
    req_tx          = request( "req_tx"         )  ' ��û ����
    res_cd          = request( "res_cd"         )  ' ���� �ڵ�
    tran_cd         = request( "tran_cd"        )  ' Ʈ����� �ڵ�
    ordr_idxx       = request( "ordr_idxx"      )  ' ���θ� �ֹ���ȣ
    good_name       = request( "good_name"      )  ' ��ǰ��
    good_mny        = request( "good_mny"       )  ' ���� �ѱݾ�
    buyr_name       = request( "buyr_name"      )  ' �ֹ��ڸ�
    buyr_tel1       = request( "buyr_tel1"      )  ' �ֹ��� ��ȭ��ȣ
    buyr_tel2       = request( "buyr_tel2"      )  ' �ֹ��� �ڵ��� ��ȣ
    buyr_mail       = request( "buyr_mail"      )  ' �ֹ��� E-mail �ּ�
    use_pay_method  = request( "use_pay_method" )  ' ���� ���    
    enc_info        = request( "enc_info"       )  ' ��ȣȭ ����
    enc_data        = request( "enc_data"       )  ' ��ȣȭ ������    
    cash_yn         = request( "cash_yn"        )
    cash_tr_code    = request( "cash_tr_code"   )
    '��Ÿ �Ķ���� �߰� �κ� - Start -
    param_opt_1    = request( "param_opt_1"     )  ' ��Ÿ �Ķ���� �߰� �κ�
    param_opt_2    = request( "param_opt_2"     )  ' ��Ÿ �Ķ���� �߰� �κ�
    param_opt_3    = request( "param_opt_3"     )  ' ��Ÿ �Ķ���� �߰� �κ�
    '��Ÿ �Ķ���� �߰� �κ� - End -

    tablet_size     = "1.0"                        ' ȭ�� ������ ����
    url             = "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("path_info")
		
'	sql = "SELECT * FROM intra_seminar_all WHERE type = '"&request("type")&"' and c_name='"&buyr_name&"' and c_email='"&buyr_mail&"'"
'	Set rs = dbcon.execute(sql)

%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title></title>
		<link rel="stylesheet" href="./style.css">
		
<!-- �ŷ���� �ϴ� kcp ������ ����� ���� ��ũ��Ʈ-->
<script type="text/javascript" src="m_js/approval_key.js"></script>

<script type="text/javascript">
  var controlCss = "css/style_mobile.css";
  var isMobile = {
    Android: function() {
      return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
      return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
      return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
      return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
      return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
      return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
  };

  if( isMobile.any() )
    document.getElementById("cssLink").setAttribute("href", controlCss);
</script>
<script type="text/javascript">
   /* �ֹ���ȣ ���� ���� */
  function init_orderid()
  {
    var today = new Date();
    var year  = today.getFullYear();
    var month = today.getMonth() + 1;
    var date  = today.getDate();
    var time  = today.getTime();

    if (parseInt(month) < 10)
      month = "0" + month;

    if (parseInt(date) < 10)
      date  = "0" + date;

    var order_idxx = "aisemicon(M)" + year + "" + month + "" + date + "" + time;
    var ipgm_date  = year + "" + month + "" + date;

    document.order_info.ordr_idxx.value = order_idxx;
    document.order_info.ipgm_date.value = ipgm_date;
  }

   /* kcp web ����â ȣ�� (����Ұ�) */
  function call_pay_form()
  {
    var v_frm = document.order_info;   
   
    v_frm.action = PayUrl;

    if (v_frm.Ret_URL.value == "")
    {
	  /* Ret_URL���� �� �������� URL �Դϴ�. */
	  alert("������ Ret_URL�� �ݵ�� �����ϼž� �˴ϴ�.");
      return false;
    }
    else
    {
      v_frm.submit();
    }
  }

   /* kcp ����� ���� ���� ��ȣȭ ���� üũ �� ���� ��û (����Ұ�) */
  function chk_pay()
  {
	
    self.name = "tar_opener";
    var pay_form = document.pay_form;

    if (pay_form.res_cd.value == "3001" )
    {
      alert("����ڰ� ����Ͽ����ϴ�.");
      pay_form.res_cd.value = "";
    }

    if (pay_form.enc_info.value)
      pay_form.submit();
		 
  }

  function jsf__chk_type()
  {
    if ( document.order_info.ActionResult.value == "card" )
    {
      document.order_info.pay_method.value = "CARD";
    }
    else if ( document.order_info.ActionResult.value == "acnt" )
    {
      document.order_info.pay_method.value = "BANK";
    }
    else if ( document.order_info.ActionResult.value == "vcnt" )
    {
      document.order_info.pay_method.value = "VCNT";
    }
    else if ( document.order_info.ActionResult.value == "mobx" )
    {
      document.order_info.pay_method.value = "MOBX";
    }
    else if ( document.order_info.ActionResult.value == "ocb" )
    {
      document.order_info.pay_method.value = "TPNT";
      document.order_info.van_code.value = "SCSK";
    }
    else if ( document.order_info.ActionResult.value == "tpnt" )
    {
      document.order_info.pay_method.value = "TPNT";
      document.order_info.van_code.value = "SCWB";
    }
    else if ( document.order_info.ActionResult.value == "scbl" )
    {
      document.order_info.pay_method.value = "GIFT";
      document.order_info.van_code.value = "SCBL";
    }
    else if ( document.order_info.ActionResult.value == "sccl" )
    {
      document.order_info.pay_method.value = "GIFT";
      document.order_info.van_code.value = "SCCL";
    }
    else if ( document.order_info.ActionResult.value == "schm" )
    {
      document.order_info.pay_method.value = "GIFT";
      document.order_info.van_code.value = "SCHM";
    }
  }
	
	function btnSubmit() {
		document.getElementById('btn_submit').click();
		return;
	}
</script>

</head>
<body onload="jsf__chk_type();init_orderid();chk_pay();">
    <div class="container sign-up-mode">
        <div class="forms-container">
            <div class="signin-signup">
<form name="order_info" method="post">

<!-- <input type="hidden" name="ActionResult" value="card">
<input type="hidden" name="ordr_idxx" value="<%=ordr_idxx%>">
<input type="hidden" name="good_name" value="����AI �ô�, �ݵ�ü Ŀ���͸���¡ �̽��� ���� ��� ���̳�">
<input type="hidden" name="good_mny" value="<%=good_mny%>">
<input type="hidden" name="buyr_name" value="<%=buyr_name%>">
<input type="hidden" name="buyr_mail" value="<%=buyr_mail%>">
<input type="hidden" name="buyr_tel1" value="<%=buyr_tel1%>">
<input type="hidden" name="buyr_tel2" value="<%=buyr_tel2%>"> -->

<input type="hidden" name="ActionResult" value="card">
<input type="hidden" name="ordr_idxx" value="<%=ordr_idxx%>">
<input type="hidden" name="good_name" value="����AI �ô�, �ݵ�ü Ŀ���͸���¡ �̽��� ���� ��� ���̳�">
<input type="hidden" name="good_mny" value="<%=request("amount")%>">
<input type="hidden" name="buyr_name" value="<%=request("name")%>">
<input type="hidden" name="buyr_mail" value="<%=request("email")%>">
<input type="hidden" name="buyr_tel1" value="<%=request("tel")%>">
<input type="hidden" name="buyr_tel2" value="<%=request("hp")%>">
	
	
	                      
  <!-- �������� -->
  <input type="hidden" name="req_tx"          value="pay">                         <!-- ��û ���� -->
  <input type="hidden" name="shop_name"       value="<%= g_conf_site_name %>">     <!-- ����Ʈ �̸� --> 
  <input type="hidden" name="site_cd"         value="<%= g_conf_site_cd   %>">     <!-- ����Ʈ �ڵ� -->
  <input type="hidden" name="currency"        value="410"/>                        <!-- ��ȭ �ڵ� -->

  <!-- ������� Ű -->
  <input type="hidden" name="approval_key"    id="approval">
  <!-- ������ �ʿ��� �Ķ����(����Ұ�)-->
  <input type="hidden" name="escw_used"       value="N">
  <input type="hidden" name="pay_method"      value="">
  <input type="hidden" name="van_code"        value="<%=van_code%>">
  <!-- �ſ�ī�� ���� -->
  <input type="hidden" name="quotaopt"        value="12"/>                           <!-- �ִ� �Һΰ����� -->
  <!-- ������� ���� -->
  <input type="hidden" name="ipgm_date"       value=""/>

  <!-- ���� URL (kcp�� ����� ������ ��û�� �� �ִ� ��ȣȭ �����͸� ���� ���� �������� �ֹ������� URL) -->
  <input type="hidden" name="Ret_URL"         value="<%=url%>">
  <!-- ȭ�� ũ������ -->
  <input type="hidden" name="tablet_size"     value="<%=tablet_size%>">

  <!-- ���� ���� ��Ͻ� ���� Ÿ�� ( �ʵ尡 ���ų� ���� '' �ϰ�� TEXT, ���� XML �Ǵ� JSON ���� -->
  <input type="hidden" name='response_type'              value="TEXT"/>
  <input type="hidden" name="PayUrl"   id="PayUrl"       value=""/>
  <input type="hidden" name="traceNo"  id="traceNo"      value=""/>

  <!-- �߰� �Ķ���� ( ���������� ������ �����޽� param_opt �� ����Ͽ� �� ���� ) -->
  <input type="hidden" name="param_opt_1"     value="<%=param_opt_1%>">
  <input type="hidden" name="param_opt_2"     value="<%=param_opt_2%>">
  <input type="hidden" name="param_opt_3"     value="<%=param_opt_3%>">

<%
    '/* ============================================================================== */
    '/* =   �ɼ� ����                                                                = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   �� �ɼ� - ������ �ʿ��� �߰� �ɼ� ������ �Է� �� �����մϴ�.             = */
    '/* = -------------------------------------------------------------------------- = */
    ' ī��� ����Ʈ ����
    '��) ��ī��� ����ī�� ��� ������
    '<input type="hidden" name='used_card'    value="CCBC:CCLG">

    '  ������ �ɼ�
    '        �� �����Һ�    (������ ������ �������� ���� �� ������ ������ ������)                             - "" �� ����
    '        �� �Ϲ��Һ�    (KCP �̺�Ʈ �̿ܿ� ���� �� ��� ������ ������ �����Ѵ�)                           - "N" �� ����
    '        �� ������ �Һ� (������ ������ �������� ���� �� ������ �̺�Ʈ �� ���ϴ� ������ ������ �����Ѵ�)   - "Y" �� ����
    '<input type="hidden" name="kcp_noint"       value=""/>

    '  ������ ����
    '        �� ���� 1 : �Һδ� �����ݾ��� 50,000 �� �̻��� ��쿡�� ����
    '        �� ���� 2 : ������ �������� ������ �ɼ��� Y�� ��쿡�� ���� â�� ����
    '        ��) �� ī�� 2,3,6���� ������(����,��,����,�Ｚ,����,����,�Ե�,��ȯ) : ALL-02:03:04
    '        BC 2,3,6����, ���� 3,6����, �Ｚ 6,9���� ������ : CCBC-02:03:06,CCKM-03:06,CCSS-03:06:04
    '<input type="hidden" name="kcp_noint_quota" value="CCBC-02:03:06,CCKM-03:06,CCSS-03:06:09"/>

    ' KCP�� ������ǰ�� �������ǰ�� ���ÿ� �Ǹ��ϴ� ��ü���� ���������� ���� ���Ǽ��� �����ص帮����, 
    '   ���հ��� ���� ����Ʈ�ڵ带 ������ �帮�� �� �ݾ׿� ���� ���հ��� ó���� �����ϵ��� �����ϰ� �ֽ��ϴ�
    '   ���հ��� ���� ����Ʈ �ڵ�� ����Ͻ� ���������� �ش��� �˴ϴ�
    '   ��ǰ���� �ƴ϶� �ݾ����� �����Ͽ� ��û�ϼž� �մϴ�
    '   �Ѱ��� �ݾ��� �����ݾ� + �ΰ��� + ������ݾ��� �հ� ���ƾ� �մϴ�. 
    '   (good_mny = comm_tax_mny + comm_vat_mny + comm_free_mny)
    
    '    <input type="hidden" name="tax_flag"       value="TG03">  <!-- ����Ұ�    -->
    '    <input type="hidden" name="comm_tax_mny"   value=""    >  <!-- �����ݾ�    --> 
    '    <input type="hidden" name="comm_vat_mny"   value=""    >  <!-- �ΰ���      -->
    '    <input type="hidden" name="comm_free_mny"  value=""    >  <!-- ����� �ݾ� --> */
	
	' ���������� �����ϴ� �� ���̵� ������ �ؾ� �մϴ�. ��ǰ�� ���� �� �ݵ�� �Է��Ͻñ� �ٶ��ϴ�.
    ' <input type="hidden" name="shop_user_id"    value=""/>
	
    ' ��������Ʈ ������ �������� �Ҵ�Ǿ��� �ڵ� ���� �Է��ؾ��մϴ�.
    ' <input type="hidden" name="pt_memcorp_cd"   value=""/>
		  
    ' ����â ���ݿ����� ���� ���� �ɼ� (Y : ����)
    ' <input type="hidden" name="disp_tax_yn"     value="Y"/>
	
	' ����â �ѱ���/���� ���� �ɼ� (Y : ����)
	' <input type="hidden" name="eng_flag"        value="Y"/>                          
	
    '/* = -------------------------------------------------------------------------- = */
    '/* =   �ɼ� ���� END                                                            = */
    '/* ============================================================================== */
%>
				
				
        <div class="paycheck-btn">
						<button type="button" onclick="location.href='../';" style="cursor:pointer" class="btn">Ȩ����</button>
            <button type="button"  onclick="kcp_AJAX();" style="cursor:pointer" id="btn_submit" class="btn">�����ϱ�</button>
        </div>
</form>

		
<form name="pay_form" method="post" action="m_pp_cli_hub.asp">
    <input type="hidden" name="req_tx"         value="<%=req_tx%>">               <!-- ��û ����          -->
    <input type="hidden" name="res_cd"         value="<%=res_cd%>">               <!-- ��� �ڵ�          -->
    <input type="hidden" name="tran_cd"        value="<%=tran_cd%>">              <!-- Ʈ����� �ڵ�      -->
    <input type="hidden" name="ordr_idxx"      value="<%=ordr_idxx%>">            <!-- �ֹ���ȣ           -->
    <input type="hidden" name="good_mny"       value="<%=request("amount")%>">             <!-- �޴��� �����ݾ�    -->
    <input type="hidden" name="good_name"      value="����AI �ô�, �ݵ�ü Ŀ���͸���¡ �̽��� ���� ��� ���̳�">            <!-- ��ǰ��             -->
    <input type="hidden" name="buyr_name"      value="<%=request("name")%>">            <!-- �ֹ��ڸ�           -->
    <input type="hidden" name="buyr_tel1"      value="<%=request("tel")%>">            <!-- �ֹ��� ��ȭ��ȣ    -->
    <input type="hidden" name="buyr_tel2"      value="<%=request("hp")%>">            <!-- �ֹ��� �޴�����ȣ  -->
    <input type="hidden" name="buyr_mail"      value="<%=request("email")%>">            <!-- �ֹ��� E-mail      -->
    <input type="hidden" name="cash_yn"        value="<%=cash_yn%>">              <!-- ���ݿ����� ��Ͽ���-->
    <input type="hidden" name="enc_info"       value="<%=enc_info%>">
    <input type="hidden" name="enc_data"       value="<%=enc_data%>">
    <input type="hidden" name="use_pay_method" value="<%=use_pay_method%>">
    <input type="hidden" name="cash_tr_code"   value="<%=cash_tr_code%>">

    <!-- �߰� �Ķ���� -->
    <input type="hidden" name="param_opt_1"	   value="<%=param_opt_1%>">
    <input type="hidden" name="param_opt_2"	   value="<%=param_opt_2%>">
    <input type="hidden" name="param_opt_3"	   value="<%=param_opt_3%>">
</form>


    <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
            </div>
        </div>
    </div>
</body>
</html>
