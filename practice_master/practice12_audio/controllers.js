export default class AudioController {
  constructor(timer) {
    this.timer = timer;
    this.audio = document.querySelector("#player");
    this.audioController = document.querySelector("#audioController");
    this.psBtn = audioController.querySelector("#playPauseBtn");
    this.currentTime = document.querySelector("#current__time");
    this.maxTime = document.querySelector("#max__time");
    this.playRange = document.querySelector("#playRange");
    this.videoControls = document.querySelector("#videoController");
    this.controlsMovementTimeout = null;
    this.maxTime.innerText = this.timer.getTime();
    this.playRange.max = Math.floor(this.timer.getRealTime()) / 10;
    this.psBtn.addEventListener("click", this.handlePlayAndStop);
    this.audio.addEventListener("timeupdate", this.updateTime);
    this.playRange.addEventListener("input", this.handlePlayRange);
  }
  handlePlayAndStop = () => {
    if (this.audio.paused) {
      this.audio.play();
      this.psBtn.className = "fas fa-pause";
    } else {
      this.audio.pause();
      this.psBtn.className = "fas fa-play";
    }
  };

  formatTime = (time) => {
    const intTime = Math.floor(10 * time);
    const min = String(Math.floor(intTime / 600)).padStart(2, "0");
    const sec = String(Math.floor((intTime % 600) / 10)).padStart(2, "0");
    const msec = String(intTime % 10);
    return `${min}:${sec}:${msec}`;
  };

  updateTime = () => {
    this.currentTime.innerText = this.formatTime(this.audio.currentTime);
    this.playRange.value = this.audio.currentTime + 0.1;
  };

  handlePlayRange = (event) => {
    this.audio.currentTime = event.target.value;
  };
}
