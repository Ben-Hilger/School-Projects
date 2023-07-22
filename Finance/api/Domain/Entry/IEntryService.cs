namespace api.Domain.Entry;

public interface IEntryService {


    public Entry? GetById(int id);

    public Entry? InsertInvestment(Entry investment);

    public Entry? UpdateInvestment(Entry investment);
    
    IEnumerable<Entry> GetAll(string uid);

    IEnumerable<EntryType> GetAllEntryTypes();
}