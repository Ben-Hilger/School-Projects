namespace api.Domain.Entry;

using DB;
using SqlKata;
using SqlKata.Execution;
internal class EntryRepository {

    private const string AmountColumn = "Entry.Amount";
    private const string EntryNameColumn = "Entry.Name";
    private const string EntryTypeIdColumn = "Entry.EntryTypeId";
    private const string EntryTypeNameColumn = "EntryType.Name as EntryTypeName";
    private const string UserIdColumn = "Entry.UserId";
    private const string IdColumn = "Entry.Id";

    private const string DateAddedColumn = "Entry.DateAddedUtc";
    private const string DateModifiedColumn = "Entry.DateModifiedUtc";

    private readonly IDbService _dbService;

    public EntryRepository(IDbService dbService) {
        _dbService = dbService;
    }

    private Query GetBaseQuery()
    {
        return _dbService.GetDbConnection().Query("Entry");
    }
 
    private Query GetBaseSelectSQL(string? userId = null, int? id = null) 
    {
        return GetBaseQuery()
            .Select(IdColumn, UserIdColumn, EntryTypeIdColumn, 
                AmountColumn, DateAddedColumn, DateModifiedColumn, EntryTypeNameColumn, 
                EntryNameColumn)
            .Join("EntryType", "Entry.EntryTypeId", "EntryType.Id")
            .When(userId != null, q => q.Where(UserIdColumn, "=", userId))
            .When(id != null, q => q.Where(IdColumn, "=", id));
    }

    public Query getUpdateByIdQuery(int id)
    {
        return GetBaseQuery().Where(IdColumn, "=", id);
    }

    public bool InvestmentExists(string? userId = null, int? id = null) 
    {
        return GetBaseSelectSQL(userId, id).Exists();
    }

    public IEnumerable<Entry>? GetAllForUser(string userId) {
        try
        {
            return GetBaseSelectSQL(userId, null).Get<Entry>();
        }
        catch
        {
            return Array.Empty<Entry>();
        }
    }

    public Entry? GetFirst(string? userId = null, int? id = null) 
    {
        try
        {
            return GetBaseSelectSQL(userId, id).First<Entry>();
        }
        catch
        {
            return null;
        }
    }

    public Entry? Insert(Entry investment) 
    {
        var id = GetBaseQuery().InsertGetId<int>(new
        {
            Amount = investment.Amount,
            EntryTypeId = investment.EntryTypeId,
            UserId = investment.UserId,
            Name = investment.Name
        });
        return GetFirst(investment.UserId, id);
    }

    public Entry? Update(Entry investment) 
    {
        var affected = GetBaseQuery().Update(new 
        {
            Id = investment.Id,
            Amount = investment.Amount,
            EntryTypeId = investment.EntryTypeId,
            UserId = investment.UserId,
            Name = investment.Name
        });
        return affected > 0 ? GetFirst(investment.UserId, investment.Id) : null;
    }


}