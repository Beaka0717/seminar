<!DOCTYPE HTML>
<html>
<head>
<title></title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="/js/checkChar.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function Postcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var fullAddr = ''; // 최종 주소 변수
                    var extraAddr = ''; // 조합형 주소 변수
                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        fullAddr = data.roadAddress;
                    }
                    else { // 사용자가 지번 주소를 선택했을 경우(J)
                        fullAddr = data.jibunAddress;
                    }
                    // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                    if (data.userSelectedType === 'R') {
                        //법정동명이 있을 경우 추가한다.
                        if (data.bname !== '') {
                            extraAddr += data.bname;
                        }
                        // 건물명이 있을 경우 추가한다.
                        if (data.buildingName !== '') {
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                        fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                    }
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("zip").value = data.postcode; //6자리 우편번호 사용
                    document.getElementById("zonecode").value = data.zonecode; //5자리 기초구역번호 사용
                    document.getElementById("addr_1").value = fullAddr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("addr_2").focus();
                }
            }).open();
        }
    </script>
    <script type="text/javascript">
        // MonthPerDay AJAX
        var httpRequest;
        //chk_email start
        function chk_reduplication_email() {
            //이메일 필터링---------------------
            if (form.email.value == "") {
                alert("이메일을 입력하세요"); 
                //document.getElementById("reduplication_email").value = "이메일을 입력하세요";
                document.getElementById("Confirm_Email").value = "false";
                document.getElementById("email").focus();
                return;
            }
            var exclude = /[^@\-\.\w]|^[_@\.\-]|[\._\-]{2}|[@\.]{2}|(@)[^@]*\1/;
            var check = /@[\w\-]+\./;
            var checkend = /\.[a-zA-Z]{2,3}$/;
            var emailad = form.email.value;
            if (((emailad.search(exclude) != -1) || (emailad.search(check)) == -1) || (emailad.search(checkend) == -1)) {
                alert("이메일주소 형식에 맞지 않습니다.");
                //document.getElementById("reduplication_email").value = "이메일주소 형식에 맞지 않습니다.";
                document.getElementById("Confirm_Email").value = "false";
                document.getElementById("email").focus();
                return;
            }
            //---------------------------------
            var pageUrl = 'application_chk_email.asp?email=' + document.getElementById("email").value;
            if (window.XMLHttpRequest) { // Mozilla, Safari, ...
                httpRequest = new XMLHttpRequest();
            }
            else if (window.ActiveXObject) { // IE
                try {
                    httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
                }

                catch (e) {
                    try {
                        httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {}
                }
            }
            if (!httpRequest) {
                alert('Giving up :( Cannot create an XMLHTTP instance');
                return false;
            }
            httpRequest.onreadystatechange = alertContentsEmail;
            httpRequest.open('POST', pageUrl, true);
            httpRequest.setRequestHeader("Content-Type", "application/xml");
            httpRequest.setRequestHeader("Cache-Control", "no-cache");
            httpRequest.setRequestHeader("Pragma", "no-cache");
            httpRequest.send();
        }

        function alertContentsEmail() {
            if (httpRequest.readyState === 4) {
                if (httpRequest.status === 200) {
                    document.getElementById("reduplication_email").value = httpRequest.responseText;
                    if (httpRequest.responseText == "사용가능 한 이메일주소 입니다.") {
                        document.getElementById("Confirm_Email").value = "true";
												alert(httpRequest.responseText);
												return;
                    }
                    else {
                        document.getElementById("Confirm_Email").value = "false";
												alert(httpRequest.responseText);
                    }
                }
                else {
                    alert('There was a problem with the Email Address request.');
                }
            }
        }
        //chk_email end
        //-->
    </script>
    <script type="text/javascript">
        function chk(val) {

            var s_name;
            s_name = document.form.name.value.replace(' ', '');
            document.form.name.value = s_name.replace(' ', '');

            if (document.form.name.value == '') {
                alert('이름을 입력해주세요');
                return false;
            }
            if (document.form.hp.value == '' ) {
                alert('휴대전화번호를 입력해주세요');
                return false;
            }
						if (!containsCharsOnly(document.getElementById("hp"),"+-1234567890")) {
							alert("휴대전화번호는 숫자와 하이픈('-') 으로 입력해주세요\n 예) 010-1234-1234");
							document.getElementById("hp").focus();
							return;
						}
						if (document.form.email.value == '') {
                alert('이메일을 입력해주세요');
                return false;
            }
            if (document.getElementById("Confirm_Email").value == "false") {
                alert("이메일중복 확인을 체크하세요");
                return;
            }
            if (document.getElementById("addr_1").value == "" || document.getElementById("addr_2").value == "") {
                alert("주소를 정확히 입력해 주세요");
                return;
            }
            if (document.getElementById("comName").value == "") {
                alert("회사/소속을 입력해주세요");
                return;
            }
/*
            if (document.getElementById("busu").value == "") {
                alert("부서/전공을 입력해주세요");
                return;
            }
            if (document.getElementById("position").value == "") {
                alert("직급/직책을 입력해주세요");
                return;
            }
*/
            if (document.form.TaxBill.checked == false) {
                alert('계산서 발급을 선택해주세요');
                return false;
            }
            if (document.getElementById("bill01").checked == true && document.form.s_email.value == "") {
                alert("세금계산서 받는 이메일주소를 입력해주세요");
								form.s_email.focus();
                return false;
            }
            if (document.getElementById("bill01").checked == true && document.form.files[0].value == "") {
                alert("세금계산서 발행을 위해 사업자등록증을 첨부해 주세요");
                return false;
            }
            if (document.getElementById("bill01").checked == true && document.form.s_email.value == "") {
                alert("현금영수증 (소득공제) 등록을 위한 핸드폰 번호를 입력해주세요");
								form.bill-phone.focus();
                return false;
            }
            if (document.getElementById("bill03").checked == true && document.form.files[1].value == "") {
                alert("현금영수증 (사업자 제출증빙) 등록을 위해 사업자등록증을 첨부해 주세요");
                return false;
            }


            if (val == 'B') {
                document.form.action = 'application_bank_ok.asp';
                document.form.submit();
            }
            else if (val == 'M') {
                document.form.action = 'application_free_ok.asp';
                document.form.submit();
            }
            else {
                document.form.action = 'card_r_proc.asp';
                document.form.submit();
            }
        }
    </script>
<style>
	ul {list-style:none;}
	.bill-text {display: none;}
	input#bill01:checked + label + div.bill-text01 {display: inherit; margin-bottom:30px;}
	input#bill02:checked + label + div.bill-text02 {display: inherit; margin-bottom:30px;}
	input#bill03:checked + label + div.bill-text03 {display: inherit; margin-bottom:30px;}
</style>	
</head>
<body>
<form name="form" method="post" enctype="multipart/form-data">
	<input type="hidden" name="kind" value="일반">
	<input type="hidden" id="account" name="account" value="250000" />
	<input type="hidden" id="s_date_check" name="s_date_check" value="A" />			
	
	<p>등록 신청</p>
	
	<ul>
		<li><input type="text" name="name" id="name" placeholder="* 성명"></li>
		<li><input type="text" name="hp" id="hp" placeholder="* 휴대폰"></li>
		<li>
			<input type="text" name="email" id="email" placeholder="* 이메일">
			<input type="hidden" name="Confirm_Email" id="Confirm_Email" value="false">
			<!-- 이메일 오류 시 텍스트로 표시 부분 -->								
			<button id="email-check" onclick="chk_reduplication_email(); return false;">이메일 중복확인</button>
			<input type="hidden" name="reduplication_email" id="reduplication_email">
		</li>
		<li>
			<input type="text" name="zonecode" id="zonecode" placeholder="* 우편번호">
			<input type="hidden" name="zip" id="zip" size="10" title="우편번호">
			<button id="address-check" onclick="Postcode(); return false;">우편번호 찾기</button><br />
			<input type="text" name="addr_1" id="addr_1" placeholder="* 주소를 입력해주세요.">
			<input type="text" name="addr_2" id="addr_2" placeholder="* 상세주소">
		</li>	
		<li><input type="text" name="comName" id="comName" placeholder="* 회사명"></li>
		<li><input type="text" name="busu" id="busu" placeholder="담당부서"></li>
		<li><input type="text" name="position" id="position" placeholder="직급"></li>
		<li><input type="text" name="tel" id="tel" placeholder="전화"></li>
		<li><input type="text" name="fax" id="fax" placeholder="팩스"></li>
	</ul>	
	
	<ul>
		<li>
			<input type="radio" name="TaxBill" id="bill01" value="T"><label for="bill01">세금계산서</label>
			<div class="bill-text01 bill-text">								
				<p><input type="text" name="s_email" id="s_email" placeholder="계산서 받는 이메일 입력"></p>
				<p><small>사업자등록증 첨부</small><br /><input type="File" name="files" id="files"></p>
			</div>
		</li>
	</ul>
	
	<ul>		
		<li>
			<input type="radio" name="TaxBill" id="bill02" value="C1"><label for="bill02">현금영수증 (소득공제)</label>
			<div class="bill-text02 bill-text">
				<p><input type="text" name="bill-phone" id="bill-phone" placeholder="휴대폰번호 입력 '-' 없이"></p>
			</div>
		</li>
	</ul>
	
	<ul>
		<li>
			<input type="radio" name="TaxBill" id="bill03" value="C2"><label for="bill03">현금영수증 (사업자 제출증빙)</label>
			<div class="bill-text03 bill-text">
				<p><small>사업자등록증 첨부</small><br /><input type="file" name="files" id="files"></p>
			</div>
		</li>
	</ul>
	
	<ul>
		<li><input type="radio" name="TaxBill" id="bill04" value="N" checked><label for="bill04">불필요</label></li>
	</ul>
	
	<hr />

	<a href="javascript:;" onClick="chk('C');"><button type="button" style="cursor:pointer">카드 결제</button></a>
	<a href="javascript:;" onClick="chk('B');"><button type="button" style="cursor:pointer">무통장 입금</button></a>
  
</form>
</body>
</html>
