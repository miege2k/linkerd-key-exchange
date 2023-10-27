//now it load express module with `require` directive
var express = require('express')

const fetch = require("node-fetch");

var app = express()
//Define request response in root URL (/) and response with text Hello World!
app.get('/', function (req, res) {
  console.log('get')
  res.send('Goodbye short World!')
})

let i = 0;
app.get('/goodbyeworld/', function (req, res) {
  i++;
  if ( (i % 3) === 0 ){
    console.log('Not Found')
    res.status(500).send('Not Found');
  }else{
    console.log('get')
    res.send('Goodbye World!')
  }
})

app.get('/goodbyeworld/error', function (req, res) {
  console.log('get')
  res.status(400);
  res.send('Fehler beim laden')
})

app.get('/goodbyeworld/:id', function (req, res) {
  var id = req.params.id;
  console.log('get by id'+id)
  var url='http://nameapi.default.svc.cluster.local:80/nameapi/'+id
  fetch(url)
    .then(res => res.json())
    .then(json => res.send('Goodbye, '+json.name+'!'));
})

//Launch listening server on port 8080 and consoles the log.
app.listen(8080, function () {
  console.log('app listening on port 8080!')
})
