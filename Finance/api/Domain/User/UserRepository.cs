using api.Domain.DB;
using SqlKata;

namespace api.Domain.User;

internal class UserRepository
{
    private const string FirstNameColumn = "first_name";
    private const string LastNameColumn = "last_name";
    private const string EmailColumn = "email";
    private const string IdColumn = "id";

    private readonly IDbService _dbService;

    public UserRepository(IDbService dbService) {
        _dbService  = dbService;
    }

    public Query GetBaseQuery() 
    {
        return _dbService.GetDbConnection().Query("User");
    }
    
    public Query GetSelectQuery(string? id)
    {
        return GetBaseQuery()
            .Select(FirstNameColumn, LastNameColumn, EmailColumn, IdColumn)
            .When(id != null, q => q.Where(IdColumn, id));
    }

    public Query UpdateByIdQuery(string id)
    {
        if (id == null) throw new ArgumentNullException(nameof(id));
        return GetBaseQuery().Where(IdColumn, id);
    }
    
}