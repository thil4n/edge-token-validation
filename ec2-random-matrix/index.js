const compute  = require("./compute.js");

const express = require('express')
const app = express()
const port = 4444

app.get('/', async (req, res) => {
	const result = await compute.computation();
	res.send(result);
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})