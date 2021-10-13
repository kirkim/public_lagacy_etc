import Timer from "./timer.js";
import AudioController from "./controllers.js";
const audio = document.querySelector("#preview");
const recordBtn = document.querySelector("#recordBtn");
const viewTime = document.querySelector("#viewTime");
const viewRecord = document.querySelector("#viewRecord");
const previewAudio = document.querySelector("#player");
const downloadBtn = document.querySelector("#downloadBtn");

let stream;
let recorder;
let audioFile;
const RECORD_TIME = 5;
let timer;
let timerIntarval;

const init = async () => {
  stream = await navigator.mediaDevices.getUserMedia({
    audio: true,
    video: false,
  });
  audio.srcObject = stream;
  //audio.play();
};
init();
const downloadRecord = () => {
  const a = document.createElement("a");
  a.href = audioFile;
  a.download = "MyRecording.webm";
  document.body.appendChild(a);
  a.click();
};

const makePlayer = () => {
  viewRecord.classList.remove("hidden");
  const audioController = new AudioController(timer);
};

const stopRecord = () => {
  recordBtn.innerText = "Start Recording";
  recordBtn.removeEventListener("click", stopRecord);
  recordBtn.addEventListener("click", startRecord);
  downloadBtn.classList.remove("hidden");
  downloadBtn.removeEventListener("click", downloadRecord);
  downloadBtn.addEventListener("click", downloadRecord);
  clearTimeout(timerIntarval);
  timer.stop();
  recorder.stop();
  makePlayer();
};

const startRecord = () => {
  timer = new Timer();
  let recordTime = 10 * RECORD_TIME;
  recordBtn.innerText = "Stop Recording";
  recordBtn.removeEventListener("click", startRecord);
  recordBtn.addEventListener("click", stopRecord);
  recorder = new MediaRecorder(stream);
  timer.start();
  timerIntarval = setInterval(() => {
    recordTime--;
    viewTime.innerText = timer.getTime();
    if (recordTime === 0) {
      stopRecord();
    }
  }, 100);
  recorder.ondataavailable = (event) => {
    audioFile = URL.createObjectURL(event.data);
    // audio.srcObject = null;
    // audio.src = audioFile;
    // audio.loop = true;
    previewAudio.src = audioFile;
  };
  recorder.start();
};

recordBtn.addEventListener("click", startRecord);
