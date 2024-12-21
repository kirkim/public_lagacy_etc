import Timer from "./timer.js";
import AudioController from "./controllers.js";
const audio = document.querySelector("#preview");
const recordBtn = document.querySelector("#recordBtn");
const viewTime = document.querySelector("#viewTime");
const viewRecord = document.querySelector("#viewRecord");

let stream;
let recorder;
let audioFile;
const RECORD_TIME = 50;
let timer;
let timerIntarval;
let index = 0;

const init = async () => {
  stream = null;
  recorder = null;
  audioFile = null;
  timer = null;
  timerIntarval = null;
  stream = await navigator.mediaDevices.getUserMedia({
    audio: true,
    video: false,
  });
  audio.srcObject = stream;
};

const makePlayer = () => {
  viewRecord.classList.remove("hidden");
  recorder.ondataavailable = (event) => {
    audioFile = URL.createObjectURL(event.data);
    index++;
    new AudioController(timer, stream.id, audioFile, index);
    console.dir(recorder);
  };
};

const stopRecord = () => {
  recordBtn.innerText = "Start Recording";
  recordBtn.removeEventListener("click", stopRecord);
  recordBtn.addEventListener("click", startRecord);
  clearTimeout(timerIntarval);
  audio.pause();
  timer.stop();
  recorder.stop();
  makePlayer();
};

const startRecord = async () => {
  let recordTime = RECORD_TIME + 1;
  await init();
  timer = new Timer();
  audio.play();

  recordBtn.innerText = "Stop Recording";
  recordBtn.removeEventListener("click", startRecord);
  recordBtn.addEventListener("click", stopRecord);
  recorder = new MediaRecorder(stream);
  recorder.start();
  timer.start();
  timerIntarval = setInterval(() => {
    recordTime--;
    viewTime.innerText = timer.getTime();
    if (recordTime === 0) {
      stopRecord();
    }
  }, 100);
};

recordBtn.addEventListener("click", startRecord);
