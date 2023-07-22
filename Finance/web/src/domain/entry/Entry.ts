
export default class Entry {
    
    public id: number|null = null;
    
    public name: string|null = null;

    public amount: number|null = null;

    public userId: string|null = null;

    public entryTypeId: number|null = null;
    public entryTypeName: string|null = null;

    public dateAddedUtc: Date|null = null;

    public dateModifiedUtc: Date|null = null;
   
}


export class EntryType {

    public id: number|undefined = undefined;

    public name: string|undefined = undefined;
}