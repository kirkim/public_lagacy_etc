"use strict";

const video = document.querySelector("video");
const playBtn = document.querySelector("#play i");
const muteBtn = document.querySelector("#mute i");
const volumeRange = document.getElementById("volume");
const currentTime = document.getElementById("currentTime");
const totalTime = document.getElementById("totalTime");
const timeline = document.getElementById("timeline");
const fullScreenBtn = document.querySelector("#fullScreen i");
const videoContainer = document.getElementById("videoContainer");
const videoControls = document.getElementById("videoControls");

const SPACE = 32;
const RIGHT = 39;
const LEFT = 37;
const UP = 38;
const DOWN = 40;

let controlsTimeout = null;
let controlsMovementTimeout = null;
let volumeValue = 0.5;
video.volume = volumeValue;

const setVideoMax = () => {
  totalTime.innerText = formatTime(video.duration);
  timeline.max = Math.floor(video.duration);
};

const formatTime = (time) => {
  const intTime = Math.floor(time);
  const min = String(Math.floor(intTime / 60)).padStart(2, "0");
  const sec = String(intTime % 60).padStart(2, "0");
  return `${min}:${sec}`;
};

if (video.readyState === 4) {
  setVideoMax();
}

const handleLoaderMetadata = () => {
  setVideoMax();
};

const togglePlay = (event) => {
  // if the video is playing, pause it
  if (video.paused) {
    video.play();
  } else {
    video.pause();
  }
  playBtn.classList = video.paused ? "fas fa-play" : "fas fa-pause";
  // else play the video
};

const handleMute = (event) => {
  if (video.muted) {
    video.muted = false;
  } else {
    video.muted = true;
  }
  muteBtn.classList = video.muted ? "fas fa-volume-mute" : "fas fa-volume-up";
  volumeRange.value = video.muted ? 0 : volumeValue;
};

const handleVolumeChange = (event) => {
  const {
    target: { value },
  } = event;
  if (video.muted) {
    video.muted = false;
    muteBtn.classList = "fas fa-volume-mute";
  }
  volumeValue = value;
  video.volume = value;
};

const handleTimeUpdate = () => {
  currentTime.innerText = formatTime(Math.floor(video.currentTime));
  timeline.value = Math.floor(video.currentTime);
};

const handleTimelineChange = (event) => {
  const { value } = event.target;
  video.currentTime = value;
};

const toggleFullscreen = () => {
  const fullscreen = document.fullscreenElement;
  if (fullscreen) {
    document.exitFullscreen();
    fullScreenBtn.classList = "fas fa-expand";
  } else {
    videoContainer.requestFullscreen();
    fullScreenBtn.classList = "fas fa-compress";
  }
};

const hideControls = () => videoControls.classList.remove("showing");

const handleMouseMove = () => {
  //   if (controlsTimeout) {
  //     clearTimeout(controlsTimeout);
  //     controlsTimeout = null;
  //   }
  if (controlsMovementTimeout) {
    clearTimeout(controlsMovementTimeout);
    controlsMovementTimeout = null;
  }
  videoControls.classList.add("showing");
  controlsMovementTimeout = setTimeout(hideControls, 3000);
};

// const handleMouseLeave = () => {
//   controlsTimeout = setTimeout(hideControls, 3000);
// };

const handleKeycode = (event) => {
  switch (event.keyCode) {
    case SPACE:
      togglePlay();
      break;
    case UP:
      if (video.volume <= 0.9) video.volume += 0.1;
      break;
    case DOWN:
      if (video.volume >= 0.1) video.volume -= 0.1;
      break;
    case RIGHT:
      video.currentTime += 1;
      break;
    case LEFT:
      video.currentTime -= 1;
      break;
    default:
      break;
  }
};

const handleVolumeUpdate = () => {
  volumeRange.value = video.volume;
};

const handleEnded = () => {
  const { id } = videoContainer.dataset;
  fetch(`/api/videos/${id}/view`, { method: "POST" });
};

video.addEventListener("click", togglePlay);
playBtn.addEventListener("click", togglePlay);
muteBtn.addEventListener("click", handleMute);
volumeRange.addEventListener("input", handleVolumeChange);
video.addEventListener("loadedmetadata", handleLoaderMetadata);
video.addEventListener("timeupdate", handleTimeUpdate);
video.addEventListener("ended", handleEnded);
video.addEventListener("volumechange", handleVolumeUpdate);
timeline.addEventListener("input", handleTimelineChange);
fullScreenBtn.addEventListener("click", toggleFullscreen);
video.addEventListener("mousemove", handleMouseMove);
//video.addEventListener("mouseleave", handleMouseLeave);
document.addEventListener("keydown", handleKeycode);
