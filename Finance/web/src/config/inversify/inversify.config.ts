import { Container } from "inversify";
import "reflect-metadata";

import FirebaseUserService from "@/service/user/FirebaseUserService";
import type IUserService from "@/service/user/IUserService";

import AxiosApiService from "../../service/api/AxiosApiService";
import type IApiService from "../../service/api/IApiService";

import FirebaseAuthService from "../../service/auth/FirebaseAuthService";
import type IAuthService from "../../service/auth/IAuthService";

import TYPES from "./types";
import type IFormatter from "@/service/formatter/IFormatter";
import Formatter from "@/service/formatter/Formatter";

var container = new Container();
container.bind<IAuthService>(TYPES.AuthService).to(FirebaseAuthService)
container.bind<IApiService>(TYPES.APIService).to(AxiosApiService)
container.bind<IUserService>(TYPES.UserService).to(FirebaseUserService)
container.bind<IFormatter>(TYPES.FormatterService).to(Formatter)

export default container;