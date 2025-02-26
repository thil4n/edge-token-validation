// app.js

const express = require("express");
const app = express();

// Middleware to log request details
app.use((req, res, next) => {
  const { method, url, headers, body } = req;
  const logMessage = `
    Method: ${method}
    URL: ${url}
    Headers: ${JSON.stringify(headers)}
    Body: ${JSON.stringify(body)}
  `;

  console.log(req);
  next();
});

// Sample route
app.all("/", (req, res) => {
  res.send("Ack!");
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
