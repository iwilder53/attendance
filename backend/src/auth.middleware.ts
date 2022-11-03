import { Request, Response, NextFunction } from "express";
import { sign, verify } from "jsonwebtoken";
import { UserModel } from "./users/user";

export const createAccessToken = async (userId: any): Promise<string> => {

  let token = sign({ userId: userId }, process.env.ACCESS_TOKEN_SECRET!, {
    expiresIn: "150d",
  });
  return token;
};

export const verifyJwtToken = async (
  req: any,
  res: Response,
  next: NextFunction
) => {
  try {
    const authorization: string = req.headers.authorization || "";

    if (authorization) {
      const token = authorization.split(" ")[1];
      const payload: any = verify(token, process.env.ACCESS_TOKEN_SECRET!);


      const user = await UserModel.findOne(payload.user);
      if (user) {
        req.body.user = user._id;
        return next();
      } else {

        res.status(200).json({ message: "You are not authenticated." });
        return null;
      }


    };
  }
  catch (err) {

    res.status(400).json({ message: "You are not authenticated." });
  }
}
