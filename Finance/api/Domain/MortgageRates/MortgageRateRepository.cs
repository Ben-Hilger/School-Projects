using api.Domain.DB;
using SqlKata;
using SqlKata.Execution;

namespace api.Domain.MortgageRates;

internal class MortgageRateRepository
{ 
    private const string MortgageTypeNameColumn = "Mortgage.Name as MortgageTypeName";
    private const string MortgagePercentColumn = "MortgageInterest.InterestPercent";
    private const string IdColumn = "MortgageInterest.Id";
    private const string MortgageTypeIdColumn = "MortgageInterest.MortgageId";

    private const string DateAddedColumn = "MortgageInterest.DateAddedUtc";
    private const string DateModifiedColumn = "MortgageInterest.DateModifiedUtc";

    private readonly IDbService _dbService;

    public MortgageRateRepository(IDbService dbService) {
        _dbService = dbService;
    }

    private Query BasicSelect()
    {
        return _dbService.GetDbConnection().Query("MortgageInterest")
            .Select(MortgagePercentColumn, MortgageTypeNameColumn, IdColumn,
                DateAddedColumn, DateModifiedColumn)
            .Join("Mortgage", MortgageTypeIdColumn, "Mortgage.Id");
    }
    
    public MortgageRate GetByType(int type)
    {
        return BasicSelect().Where(MortgageTypeIdColumn, "=", type).OrderByDesc(DateAddedColumn).First<MortgageRate>();
    }
    
}