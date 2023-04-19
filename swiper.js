window.addEventListener("load", event => {

    var swiperWrapper = document.querySelector('.swiper-wrapper');

    /* The Team */
    var team = [{
            name: "김양팽",
            role: "산업연구원 전문연구원",
            speech:  "반도체 시장동향과 지형변화",
            desc: "현: 산업연구원 성장동력산업연구본부 전문연구원 <br>전: 주일본 한국대사관 경제과 전문연구원",       
            photo: "https://techworld.speedgabia.com/seminar/2023/img/profile.jpg",


        },
        {
            name: "최기창",
            role: "서울대학교 교수",
            speech: "커스터마이징 반도체 <br> 요구 증가와 산업별 대응은",
            desc: "현: 서울대학교 시스템반도체산업진흥센터 산학협력중점교수 <br>전: 서울대학교 SNU공학컨설팅센터 산업협력중점교수 <br>전: 한국방송통신대학교 산업협력중점교수<br> 전: 삼성전자 연구원",
            photo: "https://techworld.speedgabia.com/seminar/2023/img/profile5.png",

        },
        {
            name: "김동순",
            role: "세종대학교 교수",
            speech: "모빌리티 산업, AI반도체<br> 기술 현황과 발전 방향",
            desc: "현: 세종대학교 교수 <br>전: 한국전자기술연구원 반도체‧디스플레이 연구본부 본부장 <br> 전: 한국산업기술평가관리원 반도체PD",
            photo: "https://techworld.speedgabia.com/seminar/2023/img/profile2.jpg",

        },
        {
            name: " 황석중",
            role: "사피온코리아 R&D센터 아키텍처팀 리더",
            speech: "Chat GPT 등장,<br> 반도체 설계 시장 영향은 ",
            desc: "현: 사피온코리아 R&D센터 아키텍처팀 리더<br> 전: SK텔레콤 AIX R&D, 코어팀 리더 <br>전: 삼성종합기술원 프로세서 아키텍처 연구소 전문연구원",
            photo: "https://techworld.speedgabia.com/seminar/2023/img/profile1.jpg",

        },
        {
            name: "김한준",
            role: "CTO",
            speech: "데이터센터향 고성능<br> AI 반도체의 글로벌 경쟁 요건",
            desc: "현: FuriosaAI CTO <br>전: 삼성전자 Senior Engineer - Computer Architecture" ,
            photo: "https://techworld.speedgabia.com/seminar/2023/img/profile6.jpg",

        }

    ];

    /* Social Icons */


    /* Function to populate the team members */
    function addTeam() {
        for (let i = 0; i < team.length; i++) {

            /* Variables for the team */
            var name = team[i].name,
                role = team[i].role,
                desc = team[i].desc,
                photo = team[i].photo,
                speech = team[i].speech

            /* Template for the Team Cards */
            var template = `
                <div class="swiper-slide">
                <div class="card">
                    <span class="bg"></span>
                    <span class="more"></span>
                    <figure class="photo"><img src="${photo}"></figure>
                        <article class="text">
                            <p class="name">${name}</p>
                            <p class="role">${role}</p> 
                            <p class="speech"><span>주제: </span>${speech}</p> 
                            <p class="desc">약력 <br><br> ${desc}</p> 
                        </article>
                        
                        <div class="social">
                        <span class="pointer"></span>

                            </div>
                    </div>
                </div>`;

            swiperWrapper.insertAdjacentHTML('beforeend', template);
        }
    };


    addTeam();


    /* Swiper Settings */

    var mySwiper = new Swiper(".swiper-container", {
        // Optional parameters
        direction: "horizontal",
        loop: true,
        // centeredSlides: true,
        speed: 800,
        slidesPerView: 1.5,
        spaceBetween: 40,
        threshold: 5,
        slidesOffsetAfter:0,


        // If we need pagination
        pagination: {
            el: ".swiper-pagination",
            clickable: true
        },

        // Navigation arrows
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
        },
        breakpoints: {
            // 1180: {
            //     slidesPerView: 2,
            //     spaceBetween: 40,
            //     centeredSlides: false,
                
            // },
            799: {
                slidesPerView: 2,
                spaceBetween: 40
                // centeredSlides: true,
                
            }
        }
    });

    /* Show More */

    var btnShow = document.querySelectorAll('.more');



    btnShow.forEach(function (el) {
        el.addEventListener('click', showMore);
    });

    function showMore(event) {
        var card = event.target.closest(".swiper-slide");

        if (card.classList.contains('show-more')) {
            card.classList.remove('show-more');
        } else {
            card.classList.add('show-more')
        }

    }



    /* end */
});