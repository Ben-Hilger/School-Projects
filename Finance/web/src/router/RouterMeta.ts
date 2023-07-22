
export default class RouterMeta {

    requiresAuthentication: boolean
    
    constructor(requiresAuthentication: boolean) {
        this.requiresAuthentication = requiresAuthentication;
    }

}