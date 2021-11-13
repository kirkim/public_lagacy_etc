var clone;
var cloneId;

function dragStart(ev) {
  ev.dataTransfer.effectsAllowed = 'copy';
  console.log(ev.dataTransfer);
  ev.dataTransfer.setData('text', ev.target.getAttribute('id'));
  ev.dataTransfer.setDragImage(ev.target, 0, 0);

  clone = ev.target.cloneNode(true);
  cloneId = ev.target.getAttribute('id');
  clone.className += ' ' + 'selected';
  ev.target.parentNode.appendChild(clone);

  return true;
}

function dragEnter(ev) {
  event.preventDefault();
  return true;
}

function dragOver(ev) {
  return false;
}

function dragDrop(ev) {
  var src = ev.dataTransfer.getData('text');
  clone.className += ' ' + 'cloned';
  clone.id = cloneId + '_cloned';
  ev.target.appendChild(document.getElementById(src));
  document.getElementById(src).removeAttribute('draggable');
  ev.stopPropagation();
  return false;
}
