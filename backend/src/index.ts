import "dotenv/config";
import express, { Application } from "express";
import cors from "cors";
import { mongoose } from "@typegoose/typegoose";
import { ConnectionOptions } from "tls";
import { env } from 'process';

(async () => {
  const mainRoutes = require("./routes");
  const app: Application = express();

  app.use(cors({ origin: "*" }));
  app.use(express.json({ limit: "5000mb" }));
  app.use(
    express.urlencoded({
      limit: "5000mb",
      extended: true,
      parameterLimit: 50000000,
    })
  );

  mongoose
    .connect(
      env.DB_CONNECTION_STRING as string, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
      } as ConnectionOptions
    )
    .then(() => {
      console.log("Connected to database!");
    })
    .catch((e) => {
      console.log("Connection failed!" + e.message);
    });

  mongoose.set("debug", true);


  app.use("/api", mainRoutes);


  const port = process.env.PORT || 7200;
  try {
    app.listen(port, () =>
      console.log(`API server started at http://localhost:${port}`)
    );
  } catch (err) {
    console.log(err);
  }
})();
