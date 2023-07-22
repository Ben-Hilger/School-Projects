using SqlKata.Execution;

namespace api.Domain.DB;

public interface IDbService
{
    public QueryFactory GetDbConnection();

}