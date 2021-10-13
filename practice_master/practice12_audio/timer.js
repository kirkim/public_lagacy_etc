export default class Timer {
  constructor() {
    this.time = -1;
    this.interval = null;
  }
  start = () => {
    this.interval = setInterval(() => {
      this.time += 1;
    }, 100);
  };
  getTime = () => {
    const min = String(Math.floor(this.time / 600)).padStart(2, "0");
    const sec = String(Math.floor((this.time % 600) / 10)).padStart(2, "0");
    const msec = String(this.time % 10);
    return `${min}:${sec}:${msec}`;
  };
  getRealTime = () => {
    return this.time;
  };
  stop = () => {
    clearTimeout(this.interval);
  };
  clear = () => {
    this.time = 0;
  };
}
