import type IBaseDomain from "@/domain/base/IBaseDomain";
import type IAuthService from "../auth/IAuthService";
import type IApiService from "./IApiService";
import { injectable, inject } from "inversify";
import TYPES from "@/config/inversify/types";
import axios, { type AxiosResponse } from "axios";
import HttpConfig from "@/config/http/HttpConfig";

@injectable()
export default class AxiosApiService implements IApiService {

    private baseURL = "localhost:8080"

    @inject(TYPES.AuthService) private _authService: IAuthService | undefined;
    
    private _axiosInstance = axios.create({
        baseURL: HttpConfig.getConfig().getBaseUrl() + "/api"
    })

    private getErrorResponse(response: AxiosResponse) {
        return `API returned with status: ${response.status}, status text: ${response.statusText}`;
    }

    async getAll<T>(endpoint: string): Promise<Array<T>> {
        return new Promise(async (resolve, reject) => {
            try {
                let response = await this._axiosInstance.get(endpoint)
                if (response.status !== 200) {
                    console.log(this.getErrorResponse(response) + " " + response.data)
                    reject(this.getErrorResponse(response))
                }
                if (response.data) {
                    resolve(response.data as Array<T>);
                    return;
                }
                resolve([])
            } catch (e) {
                reject(`Unable to retrieve item from api with error: ${e}.`)
            }
        })
    }

    async get<T>(endpoint: string, id: number): Promise<T> {
        return new Promise(async (resolve, reject) => {
            try {
                let response = await this._axiosInstance.get(endpoint, {data: 
                    {"id" : id}
                })
                if (response.status !== 200) {
                    reject(`API returned with status: ${response.status}, status text: ${response.statusText}`)
                }
                let converted =  (await response.data.json()) as T
                resolve(converted)
            } catch {
                reject("Unable to retrieve item from api.")
            }
        });
    }

    async post<T>(endpoint: string, payload: T): Promise<T> {
        return new Promise(async (resolve, reject) => {
            try {
                console.log("HERE 2")
                let response = await this._axiosInstance.post(endpoint, undefined, {
                    headers: {
                        "Content-Type": "application/json"
                    }, params: payload
                })
                console.log("HERE 3")
                if (response.status !== 200) {
                    reject(`API returned with status: ${response.status}, status text: ${response.statusText}`)
                }
                console.log(response.data)
                let converted =  (await response.data.json()) as T
                resolve(converted)
            } catch (e) {
                console.log(e)
                reject("Unable to retrieve item from api: " + e)
            }
        });
    }
}

export enum ApiVersion {
    V1 = "v1"
}