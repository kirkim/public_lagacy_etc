const video = document.querySelector("video");
const videoController = document.getElementById("videoController");
const psBtn = videoController.querySelector("#playPauseBtn");
const volumeBtn = videoController.querySelector("#volume");
const volumeRange = videoController.querySelector("#volumeRange");
const currentTime = document.querySelector("#current__time");
const maxTime = document.querySelector("#max__time");
const playRange = document.querySelector("#playRange");
const fullScreenBtn = document.querySelector("#fullScreen");
const videoContainer = document.querySelector("#videoContainer");
const videoControls = document.querySelector("#videoController");

let controlsMovementTimeout = null;
let volumeValue = 0.5;
video.volume = volumeValue;

const handlePlayAndStop = () => {
  if (video.paused) {
    video.play();
    psBtn.className = "fas fa-pause";
  } else {
    video.pause();
    psBtn.className = "fas fa-play";
  }
};

const handleSound = () => {
  if (video.muted) {
    video.muted = false;
    volumeRange.value = volumeValue;
    volumeBtn.className = "fas fa-volume-up";
  } else {
    video.muted = true;
    volumeRange.value = 0;
    volumeBtn.className = "fas fa-volume-mute";
  }
};

const handleVolume = (event) => {
  const {
    target: { value },
  } = event;
  if (video.muted) {
    video.muted = false;
    volumeBtn.className = "fas fa-volume-mute";
  }
  if (value === "0") {
    volumeBtn.className = "fas fa-volume-off";
  } else {
    volumeBtn.className = "fas fa-volume-up";
  }
  video.volume = volumeValue = value;
};

const formatTime = (time) => {
  const intTime = Math.floor(time);
  const min = String(Math.floor(intTime / 60)).padStart(2, "0");
  const sec = String(intTime % 60).padStart(2, "0");
  return `${min}:${sec}`;
};

if (video.readyState === 4) {
  maxTime.innerText = formatTime(video.duration);
  playRange.max = video.duration;
}

const loadedMetadata = () => {
  maxTime.innerText = formatTime(video.duration);
  playRange.max = video.duration;
};

const updateTime = () => {
  currentTime.innerText = formatTime(video.currentTime);
  playRange.value = video.currentTime;
};

const handlePlayRange = (event) => {
  video.currentTime = event.target.value;
};

const handleFullscreen = () => {
  const fullscreen = document.fullscreenElement;
  if (fullscreen) {
    fullScreenBtn.innerText = "Enter Full Screen";
    document.exitFullscreen();
  } else {
    fullScreenBtn.innerText = "Exit Full Screen";
    videoContainer.requestFullscreen();
  }
};

const handleKey = (event) => {
  console.log(event.keyCode);
  if (event.keyCode === 32) {
    handlePlayAndStop();
  } else if (event.keyCode === 70 && !document.fullscreenElement) {
    fullScreenBtn.innerText = "Exit Full Screen";
    videoContainer.requestFullscreen();
  } else if (event.keyCode === 27) {
    fullScreenBtn.innerText = "Enter Full Screen";
    document.exitFullscreen();
  } else if (event.keyCode === 39) {
    video.currentTime += 1;
  } else if (event.keyCode === 37) {
    video.currentTime -= 1;
  }
};

psBtn.addEventListener("click", handlePlayAndStop);
volumeBtn.addEventListener("click", handleSound);
volumeRange.addEventListener("input", handleVolume);
video.addEventListener("loadedmetadata", loadedMetadata);
video.addEventListener("timeupdate", updateTime);
playRange.addEventListener("input", handlePlayRange);
fullScreenBtn.addEventListener("click", handleFullscreen);
document.addEventListener("keydown", handleKey);
document.onfullscreenchange = (event) => {
  console.log(event);
};
