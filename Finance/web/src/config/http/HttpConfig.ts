import { initializeApp, type FirebaseApp } from "firebase/app";
import { getAuth, type Auth } from "firebase/auth";

export default class HttpConfig {

    private static config: HttpConfig = new HttpConfig();

    private constructor() {}
    
    getBaseUrl() {
        return "http://localhost:5063"
    }

    static getConfig(): HttpConfig {
        return HttpConfig.config;
    }
 }