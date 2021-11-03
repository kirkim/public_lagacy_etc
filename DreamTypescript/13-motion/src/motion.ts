'use strict';

import PopImage from './class/popImage.js';
import PopWindow from './class/popWindow.js';

const addNavForm = document.querySelector('#add__navigator');
let popWin: PopWindow;
const popForm = document.querySelector('#pop__section');

function handleAddNav(event) {
  switch (event.target.id) {
    case 'image__btn':
      popWin = new PopImage('Title', 'URL');
      break;
    case 'video__btn':
      //popWin = new PopWindow('Title', 'URL');
      break;
    case 'note__btn':
      //popWin = new PopWindow('Title', 'Body');
      break;
    case 'task__btn':
      //popWin = new PopWindow('Title', 'Body');
      break;
  }
  popWin.open();
}

function handlePopForm(event) {
  switch (event.target.id) {
    case 'pop__close__btn':
      popWin.close();
      break;
    case 'pop__submit':
      popWin.make();
      break;
  }
}

addNavForm?.addEventListener('click', handleAddNav);
popForm?.addEventListener('click', handlePopForm);
