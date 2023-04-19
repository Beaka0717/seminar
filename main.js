
(function($) { "use strict";

		
	//Parallax & fade on scroll	
	
	function scrollBanner() {
	  $(document).on('scroll', function(){
		var scrollPos = $(this).scrollTop();
		$('.parallax-fade-top').css({
		  'top' : (scrollPos/2.8)+'px',
		  'opacity' : 1-(scrollPos/600)
		});
	  });    
	}
	scrollBanner();	
    
	//Page cursors

    document.getElementsByTagName("body")[0].addEventListener("mousemove", function(n) {
        t.style.left = n.clientX + "px", 
		t.style.top = n.clientY + "px", 
		e.style.left = n.clientX + "px", 
		e.style.top = n.clientY + "px", 
		i.style.left = n.clientX + "px", 
		i.style.top = n.clientY + "px"
    });
    var t = document.getElementById("cursor"),
        e = document.getElementById("cursor2"),
        i = document.getElementById("cursor3");
    function n(t) {
        e.classList.add("hover"), i.classList.add("hover")
    }
    function s(t) {
        e.classList.remove("hover"), i.classList.remove("hover")
    }
    s();
    for (var r = document.querySelectorAll(".hover-target"), a = r.length - 1; a >= 0; a--) {
        o(r[a])
    }
    function o(t) {
        t.addEventListener("mouseover", n), t.addEventListener("mouseout", s)
    }
		
	$(document).ready(function(){"use strict";
	
		//Scroll indicator
		
		var progressPath = document.querySelector('.progress-wrap path');
		var pathLength = progressPath.getTotalLength();
		progressPath.style.transition = progressPath.style.WebkitTransition = 'none';
		progressPath.style.strokeDasharray = pathLength + ' ' + pathLength;
		progressPath.style.strokeDashoffset = pathLength;
		progressPath.getBoundingClientRect();
		progressPath.style.transition = progressPath.style.WebkitTransition = 'stroke-dashoffset 10ms linear';		
		var updateProgress = function () {
			var scroll = $(window).scrollTop();
			var height = $(document).height() - $(window).height();
			var progress = pathLength - (scroll * pathLength / height);
			progressPath.style.strokeDashoffset = progress;
		}
		updateProgress();
		$(window).scroll(updateProgress);
		
		
	});
	
})(jQuery); 

// pause btn

var video = document.getElementById("myVideo");
var btn = document.getElementById("myBtn");

function myFunction() {
  if (video.paused) {
	video.play();
	btn.innerHTML = "Pause";
  } else {
	video.pause();
	btn.innerHTML = "Play";
  }
}
// CONFERENCE BOTTON
const buttons = document.querySelectorAll('.button');

buttons.forEach(button => {
    button.addEventListener('click', e => {
		console.log("clicked");
        let x = e.clientX;
		let y = e.clientY;

		let buttonTop = e.target.offsetTop;
		let buttonLeft = e.target.offsetLeft;

		let xInside = x - buttonLeft;
        let yInside = y - buttonTop;
        
        let ripple = document.createElement('span');
        ripple.classList.add('ripple');
        ripple.style.top = yInside + 'px';
        ripple.style.left = xInside + 'px';

        e.target.appendChild(ripple);

        setTimeout(() => {
            ripple.remove();
        }, 300);
    })
})

