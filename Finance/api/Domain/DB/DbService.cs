using MySql.Data.MySqlClient;
using SqlKata.Compilers;
using SqlKata.Execution;

namespace api.Domain.DB;

public class DbService : IDbService
{
    private readonly IConfiguration _configuration; 

    public DbService(IConfiguration configuration) {
        _configuration = configuration;
    }


    public QueryFactory GetDbConnection()
    {
        string? connectionString = _configuration.GetConnectionString("db");
        if (connectionString == null) {
            throw new Exception("No connection string is specified for this environment");
        }
        var connection = new MySqlConnection();
        connection.ConnectionString = connectionString;
        var db = new QueryFactory(connection, new MySqlCompiler());
        return db;
    }

}