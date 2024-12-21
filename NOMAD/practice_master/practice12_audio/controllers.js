export default class AudioController {
  constructor(timer, id, audioFile, index) {
    this.timer = timer;
    this.zone = document.querySelector("#viewRecord");
    this.div;
    this.audioFile = audioFile;
    this.makeNode(id, index);
    this.audio = document.querySelector(`#player${id}`);
    this.audio.src = this.audioFile;
    this.controller = document.querySelector(`#audioController${id}`);
    this.psBtn = this.controller.querySelector(`#playPauseBtn${id}`);
    this.currentTime = this.controller.querySelector(`#current__time${id}`);
    this.maxTime = this.controller.querySelector(`#max__time${id}`);
    this.playRange = this.controller.querySelector(`#playRange${id}`);
    this.videoControls = this.controller.querySelector(`#videoController${id}`);
    this.deleteBtn = this.controller.querySelector(`#delete${id}`);
    this.downloadBtn = document.querySelector(`#download${id}`);
    this.controlsMovementTimeout = null;
    this.maxTime.innerText = this.timer.getTime();
    this.playRange.max = Math.floor(this.timer.getRealTime()) / 10;
    this.psBtn.addEventListener("click", this.handlePlayAndStop);
    this.audio.addEventListener("timeupdate", this.updateTime);
    this.playRange.addEventListener("input", this.handlePlayRange);
    this.deleteBtn.addEventListener("click", this.deleteAudio);
    this.downloadBtn.addEventListener("click", this.downloadRecord);
    this.audio.addEventListener("pause", this.handlePause);
  }
  handlePause = () => {
    this.psBtn.className = "fas fa-play";
  };

  downloadRecord = () => {
    const a = document.createElement("a");
    a.href = this.audioFile;
    a.download = "MyRecording.webm";
    document.body.appendChild(a);
    a.click();
  };

  makeNode = (id, index) => {
    this.div = document.createElement("div");
    this.div.innerHTML = `
	<audio id="player${id}"></audio>
	<div class="record__set">
	<div id="audioController${id}" class="pre__controllers">
        <div class="audioRange">
          <input type="range" step="0.1" value="0" min="0" id="playRange${id}" />
        </div>
        <div class="record__tool">
          <i id="playPauseBtn${id}" class="fas fa-play"></i>
          <span id="current__time${id}">00:00:0</span>
          <span> / </span>
          <span id="max__time${id}">00:00:0</span>
		  <span class="record__index">${index}</span>
		  <span id="delete${id}" class="record__delete">❌</span>
        </div>
      </div>
	  <div id="download${id}" class="record__download">download</div>
	  </div>`;
    this.zone.appendChild(this.div);
  };

  deleteAudio = () => {
    this.div.remove();
  };
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
    this.playRange.value = this.audio.currentTime;
  };

  handlePlayRange = (event) => {
    this.audio.currentTime = event.target.value;
  };
}
