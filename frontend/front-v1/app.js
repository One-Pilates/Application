const express = require("express");
const path = require("path")
const app = express();

app.use(express.json())

app.use(express.static(path.join(__dirname, "public")))

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "cadastro.html"));
});

app.listen(3000, () => {
  console.log("Server is running on http://localhost:3000");
});