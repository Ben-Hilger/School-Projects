namespace api.Domain.MortgageRates;

public interface IMortgageRateService
{

    public MortgageRate GetRecentForType(int mortgageType);

}