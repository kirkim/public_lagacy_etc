const EventEmitter = require('events');

const videoContainer = document.querySelector('#videoContainer');
const form = document.querySelector('#commentForm');
const deleteBtn = document.querySelector(`#delete__btn`);
const videoComments = document.querySelector('.video__comments ul');

const addComment = (text, id) => {
  const newComment = document.createElement('li');
  newComment.dataset.id = id;
  newComment.className = 'video__comment';
  const icon = document.createElement('i');
  icon.className = 'fas fa-comment';
  const span = document.createElement('span');
  span.innerText = ` ${text}`;
  const span2 = document.createElement('span');
  span2.innerText = ' ❌';
  span2.id = 'delete__btn';
  newComment.appendChild(icon);
  newComment.appendChild(span);
  newComment.appendChild(span2);
  videoComments.prepend(newComment);
};

const handleSubmit = async (event) => {
  event.preventDefault();
  const textarea = form.querySelector('textarea');
  const text = textarea.value;
  const videoId = videoContainer.dataset.id;
  if (text === '') {
    return;
  }
  const response = await fetch(`/api/videos/${videoId}/comment`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ text }),
  });
  textarea.value = '';
  const { newCommentId } = await response.json();
  if (response.status === 201) {
    addComment(text, newCommentId);
  }
};

const delteComment = async (event) => {
  const id = event.target.parentNode.dataset.id;
  const comment = event.target.parentNode;
  const response = await fetch(`/api/comments/${id}`, {
    method: 'DELETE',
  });
  if (response.status === 200) {
    videoComments.removeChild(comment);
  }
};

if (form) {
  form.addEventListener('submit', handleSubmit);
}

if (videoComments) {
  videoComments.addEventListener('click', (event) => {
    if (event.target.id === 'delete__btn') {
      delteComment(event);
    }
  });
}
