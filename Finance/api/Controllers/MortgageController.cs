using api.Domain.MortgageRates;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers;

[ApiController]
[Route("api/mortgage")]
public class MortgageController
{

    private readonly IMortgageRateService _mortgageRateService;

    public MortgageController(IMortgageRateService mortgageRateService) {
        _mortgageRateService = mortgageRateService;
    }

    
    [HttpGet("rates")]
    public MortgageRate getByType([FromQuery(Name = "type")] int type)
    {
        return _mortgageRateService.GetRecentForType(type);
    }  
}