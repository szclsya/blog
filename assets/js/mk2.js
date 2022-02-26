// Progress bar part
let progress_meter = document.getElementById("progress_meter");

let height = document.body.scrollHeight - screen.height;
let last_position = window.scrollY;

function update_progress_meter () {
  height = document.body.clientHeight - window.innerHeight;
  current_position = window.scrollY;

  progress = Math.ceil((current_position / height) * 100);
  // Makes it looks better...
  if (height == 0) {
    progress = 100;
  } else if (progress < 0) {
    progress = 0;
  } else if (progress > 100) {
    progress = 100;
  } 
  
  progress_meter.innerText = progress + "%";
}

let ticking = false;
window.addEventListener('scroll', function(e) {
  if (!ticking) {
	window.requestAnimationFrame(function() {
	  update_progress_meter();
	  ticking = false;
	});

	ticking = true;
  }
});

progress_meter.style.textDecoration = 'none';
update_progress_meter();
