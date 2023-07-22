using api.Domain.DB;

namespace api.Domain.MortgageRates;

public class MortgageRateService : IMortgageRateService
{

    private readonly MortgageRateRepository _mortgageRateRepository;
    
    public MortgageRateService(IDbService dbService) {
        _mortgageRateRepository = new MortgageRateRepository(dbService);
    }
    
    public MortgageRate GetRecentForType(int mortgageType)
    {
        return _mortgageRateRepository.GetByType(mortgageType);
    }
}