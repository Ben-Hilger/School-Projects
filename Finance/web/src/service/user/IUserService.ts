import type User from "@/domain/user/User";

export default interface IUserService {

    getUser(): User|null;

    updateUser(updatedUser: User): boolean
    
}