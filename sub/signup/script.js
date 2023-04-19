/*
const sign_in_btn = document.querySelector("#sign-in-btn");
const sign_up_btn = document.querySelector("#sign-up-btn");
const container = document.querySelector(".container");
*/

function validateform(){
  /*
  var user=document.myform.user.value;
  var password=document.myform.password.value;

  if (user==null || user==""){
    alert("Username can't be blank");
    return false;
  }else
  if (password.length<8) {
    alert("Password must be at least 8 characters long.");
    return false;
  }

  var x=document.myform.email.value;
  var atposition=x.indexOf("@");
  var dotposition=x.lastIndexOf(".");

  if (atposition<1 ||dotposition<atposition+2 || dotposition+2>=x.length) {
    alert("Please enter a valid email address");
    return false;
  }
  */


 
  if (document.getElementById("payType_bank").checked == true) {

      if (document.myform.TaxBill.checked == false) {
        alert('계산서 발급을 선택해주세요');
        return false;
      }
      if (document.getElementById("bill01").checked == true && document.myform.s_email.value == "") {
          alert("세금계산서 받는 이메일주소를 입력해주세요");
          myform.s_email.focus();
          return false;
      }
      if (document.getElementById("bill01").checked == true && document.myform.files[0].value == "") {
          alert("세금계산서 발행을 위해 사업자등록증을 첨부해 주세요");
          return false;
      }
      if (document.getElementById("bill01").checked == true && document.myform.s_email.value == "") {
          alert("현금영수증 (소득공제) 등록을 위한 핸드폰 번호를 입력해주세요");
          myform.bill-phone.focus();
          return false;
      }
      if (document.getElementById("bill03").checked == true && document.myform.files[1].value == "") {
          alert("현금영수증 (사업자 제출증빙) 등록을 위해 사업자등록증을 첨부해 주세요");
          return false;
      }

      document.myform.action = '../../application/application_bank_ok.asp';
      document.myform.encoding = "multipart/form-data";
      return true;

  } else {
      document.myform.action = '../../application/card_r_proc.asp';
      // document.myform.encoding = "application/x-www-form-urlencoded"
      return true;
  }
  
  //무료초청
  // else (val == 'M') {
  //     document.myform.action = '../../application/application_free_ok.asp';
  // }
  
}


