const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = process.env.PORT || 3000;
const app = express();

app.use(express.json());
app.use(authRouter);

const DB ='mongodb+srv://tayyabniaxi:tayyabkhan@cluster0.yf5o3rt.mongodb.net/?retryWrites=true&w=majority';

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful to MongoDB");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
