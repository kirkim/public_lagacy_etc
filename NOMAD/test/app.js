const bodyParser = require('body-parser');
const express = require('express');
const morgan = require('morgan');

const app = express();
app.use(morgan('dev'));

//app.use(bodyParser.json());
//app.use(bodyParser.text());
app.use(bodyParser.urlencoded({ extended: true }));
//app.use(express.urlencoded({ extended: false }));

app.post('/test', (req, res) => {
  console.log(req.body);
  return res.send(req.body);
});

app.use('/test2', express.static('test.html'));

app.post('/test2', (req, res) => {
  console.log(req.body);
  return res.redirect('/test2');
});

app.listen(8080, () => console.log(`http://localhost:8080`));
