
export default interface IApiService {
    
    get<T>(endpoint: string, id: number): Promise<T>;

    getAll<T>(endpoint: string): Promise<Array<T>>;

    post<T>(endpoint: string, payload: T): Promise<T>;

    
}