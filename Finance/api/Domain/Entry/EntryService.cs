namespace api.Domain.Entry;

using api.Domain.DB;

public class EntryService: IEntryService {

    private readonly EntryRepository _entryRepository;
    private readonly EntryTypeRepository _entryTypeRepository;
    
    public EntryService(IDbService dbService) {
        _entryRepository = new EntryRepository(dbService);
        _entryTypeRepository = new EntryTypeRepository(dbService);
    }

    public IEnumerable<Entry> GetAll(string uid) {
        return _entryRepository.GetAllForUser(uid);
    }

    public Entry? GetById(int id)
    {
        return _entryRepository.GetFirst(null, id);
    }

    public Entry? InsertInvestment(Entry investment) 
    {
        if (investment.UserId == null) {
            throw new ArgumentNullException("userId is null, value required");
        }
        return _entryRepository.Insert(investment);
    }

    public Entry? UpdateInvestment(Entry investment) 
    {
        if (_entryRepository.InvestmentExists(investment.UserId, investment.Id)) {
            return _entryRepository.Update(investment);
        }
        return null;
    }

    public IEnumerable<EntryType> GetAllEntryTypes()
    {
        return _entryTypeRepository.GetAll();
    }

}