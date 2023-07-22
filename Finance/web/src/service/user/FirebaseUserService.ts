import type IUserService from "@/service/user/IUserService";
import { updateProfile, type Auth } from "firebase/auth";
import FirebaseConfig from "@/config/firebase/FirebaseConfig";
import User from "@/domain/user/User";
import { injectable } from "inversify";

@injectable()
export default class FirebaseUserService implements IUserService {

    private getAuth() {
        return FirebaseConfig.getConfig().getAuth()
    }

    getUser(): User|null {
        const auth = this.getAuth()
        if (auth && auth.currentUser) {
            let user = new User();
            user.uuid = auth.currentUser.uid
            user.email = auth.currentUser.email
            user.displayName = auth.currentUser.displayName
            user.emailVerified = auth.currentUser.emailVerified
            return user;
        }
        return null;
    }

    updateUser(updatedUser: User): boolean {
        const auth = this.getAuth()
        if (auth && auth.currentUser) {
            updateProfile(auth.currentUser, {
                displayName: updatedUser.displayName,
            })
            return true;
        }
        return false;
    }

}