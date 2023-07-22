import { ApiVersion } from "@/service/api/AxiosApiService";
import type IBaseDomain from "../base/IBaseDomain";

export default abstract class BaseDomain implements IBaseDomain {

    abstract getClassName(): string;

    getApiVersion(): ApiVersion {
        return ApiVersion.V1
    }
    
}