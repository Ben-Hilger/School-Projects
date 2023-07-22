
export default interface IAuthService {

    getAuthToken(): Promise<string>;

    isLoggedIn(): boolean;

    signInUser(email: string, password: string): Promise<string|null>;
        
}