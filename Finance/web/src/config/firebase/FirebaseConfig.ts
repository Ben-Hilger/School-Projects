import { initializeApp, type FirebaseApp } from "firebase/app";
import { getAuth, type Auth } from "firebase/auth";

export default class FirebaseConfig {

    private static config: FirebaseConfig = new FirebaseConfig();

    private constructor() {}
    
    private app: FirebaseApp|null = null
    private auth: Auth|null = null

    init() {
        const firebaseConfig = {
            apiKey: "AIzaSyBICYzazVFb9z0Wsxapligs2_FNsEbvkpk",
            authDomain: "academic-planner-8e1e3.firebaseapp.com",
            projectId: "academic-planner-8e1e3",
            storageBucket: "academic-planner-8e1e3.appspot.com",
            messagingSenderId: "74517238751",
            appId: "1:74517238751:web:4398c1efa50bb93cfa2a6a",
            measurementId: "G-N0Q5VZN5ZE"
        };

        // Initialize Firebase
        this.app = initializeApp(firebaseConfig);
        this.auth = getAuth(this.app);
    }

    getAuth(): Auth | null {
        return this.auth;
    }

    static getConfig(): FirebaseConfig {
        return FirebaseConfig.config;
    }
 }