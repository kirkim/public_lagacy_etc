//const http = require('http');
const form = document.querySelector('form');

const postSample = async (event) => {
  event.preventDefault();
  console.log(event);
  //return http.fetch('http://localhost:8080', { method: 'GET' });
};

form.addEventListener('submit', postSample);
