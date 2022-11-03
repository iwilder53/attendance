"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const typegoose_1 = require("@typegoose/typegoose");
(() => __awaiter(void 0, void 0, void 0, function* () {
    const mainRoutes = require("./routes");
    const app = (0, express_1.default)();
    app.use((0, cors_1.default)({ origin: "*" }));
    app.use(express_1.default.json({ limit: "5000mb" }));
    app.use(express_1.default.urlencoded({
        limit: "5000mb",
        extended: true,
        parameterLimit: 50000000,
    }));
    typegoose_1.mongoose
        .connect("mongodb://127.0.0.1:27017/college", {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    })
        .then(() => {
        console.log("Connected to database!");
    })
        .catch((e) => {
        console.log("Connection failed!" + e.message);
    });
    typegoose_1.mongoose.set("debug", true);
    app.use("/api", mainRoutes);
    const port = process.env.PORT || 7200;
    try {
        app.listen(port, () => console.log(`API server started at http://localhost:${port}`));
    }
    catch (err) {
        console.log(err);
    }
}))();
