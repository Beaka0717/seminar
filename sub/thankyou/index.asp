<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./style.css">
    <title>결제 완료</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
</head>
<body>
    <div class="innerbox">
        <div class="videoback">
            <video autoplay muted loop id="myVideo">
                <source src="https://techworld.speedgabia.com/seminar/2023/thankyou_back.mov" type="video/mp4">
              </video>
        </div>
        
         <div class="thankyou">
    
            <div class="smaller">
                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                viewBox="0 0 60 60" style="enable-background:new 0 0 60 60;" xml:space="preserve">
                <path class="check" d="M40.61,23.03L26.67,36.97L13.495,23.788c-1.146-1.147-1.359-2.936-0.504-4.314
                c3.894-6.28,11.169-10.243,19.283-9.348c9.258,1.021,16.694,8.542,17.622,17.81c1.232,12.295-8.683,22.607-20.849,22.042
                c-9.9-0.46-18.128-8.344-18.972-18.218c-0.292-3.416,0.276-6.673,1.51-9.578"/>
                </svg>
            </div>  
            <%if request("check_type")="B" then%>
                <h2 class= "txt">계좌송금  안내</h2>
                <p class= "txtsmall">
                [ 입금할 계좌번호 ]<br />
                기업은행 478-000704-04-014 / 예금주: 테크월드<br />
                입금하실 금액 : 250,000 원
                </p>
            <%else%>
                <h2 class= "txt">결제 완료</h2>
                <p class= "txtsmall">"등록 및 결제가 완료됐습니다. 행사 페이지에서 계산서 및 참석증을 출력하실 수 있습니다." </p>
            <%end if%>
            <a href="../../"><h2 class="txt">처음으로 이동</h2></a>
        </div>
    </div>

</body>
</html>