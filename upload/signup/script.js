const sign_in_btn = document.querySelector("#sign-in-btn");
const sign_up_btn = document.querySelector("#sign-up-btn");
const container = document.querySelector(".container");

function validateform(){
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
}