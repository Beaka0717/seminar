function NoSeeOption() {
    document.querySelector(".TaxDoc").style.display = "none";
    document.querySelector(".signin-signup").style.top = "50%";
  }
  document.querySelector("#payType_card").addEventListener("click", NoSeeOption);
  
  
  
  
  function SeeOption() {
    document.querySelector(".TaxDoc").style.display = "block";
    document.querySelector(".signin-signup").style.top = "80%";
    
  }
  document.querySelector("#payType_bank").addEventListener("click", SeeOption);

  function dropdown() {
    let displayType = document.querySelector("#myDropdown").style.display;
    if(displayType != "" && displayType != "none") {
      document.querySelector("#myDropdown").style.display = "none";
      document.querySelector(".signin-signup").style.top = "50%";
    } else {
      document.querySelector("#myDropdown").style.display = "block";
      document.querySelector(".signin-signup").style.top = "80%";
    }
    
  }
  
