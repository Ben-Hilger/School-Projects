import type { ApiVersion } from "@/service/api/AxiosApiService";

export default interface IBaseDomain {

    getClassName(): string;

    getApiVersion(): ApiVersion;

}