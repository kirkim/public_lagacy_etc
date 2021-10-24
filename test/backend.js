const express = require('express');
const app = express();
const bodyParser = require('body-parser');

app.use('/test', express.static('test.html'));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.post('/test', (req, res) => {
  console.log();
  console.log(typeof req.body);
  console.log();
  return res.redirect('/test');
});

app.listen(8080, () => console.log(`http://localhost:8080`));
