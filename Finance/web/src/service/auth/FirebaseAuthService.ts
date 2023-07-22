import type IAuthService from "./IAuthService";
import { signInWithEmailAndPassword, getAuth, type Auth, getIdToken } from "firebase/auth"
import { injectable } from "inversify";
import FirebaseConfig from "@/config/firebase/FirebaseConfig";

@injectable()
export default class FirebaseAuthService implements IAuthService {
    

    async getAuthToken(): Promise<string> {
        const auth = FirebaseConfig.getConfig().getAuth()
        return new Promise(async (resolve, reject) => {
            if (auth !== null && auth.currentUser !== null) {
                let token = await getIdToken(auth.currentUser)
                resolve(token)
                return;
            }
            reject("No user is logged in");
        })
    }

    isLoggedIn(): boolean {
        const auth = FirebaseConfig.getConfig().getAuth()
        return auth !== null && auth.currentUser !== null;
    }

    async signInUser(email: string, password: string): Promise<string|null> {
        const auth = FirebaseConfig.getConfig().getAuth()
        if (auth !== null) {
            let credentials = await signInWithEmailAndPassword(auth, email, password);
            let idToken = await credentials.user.getIdToken()
            return idToken;
        }
        return null;
    }
    
}