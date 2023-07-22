using api.Domain.DB;
using SqlKata;
using SqlKata.Execution;

namespace api.Domain.Entry;


public class EntryTypeRepository
{
    private const string IdColumn = "EntryType.Id";
    private const string NameColumn = "EntryType.Name";
    
    private readonly IDbService _dbService;

    public EntryTypeRepository(IDbService dbService) {
        _dbService = dbService;
    }

    private Query GetBaseQuery()
    {
        return _dbService.GetDbConnection().Query("EntryType");
    }

    public IEnumerable<EntryType> GetAll()
    {
        try
        {
            return GetBaseQuery().Select(IdColumn, NameColumn).Get<EntryType>();
        }
        catch
        {
            return Array.Empty<EntryType>();
        }
    }
}