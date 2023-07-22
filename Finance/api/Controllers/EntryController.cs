using api.Constants;
using api.Domain.API;
using api.Domain.Entry;
using Microsoft.AspNetCore.Mvc;
namespace api.Controllers;

[ApiController]
[Route("api/entry")]
public class EntryController : ControllerBase
{

    private readonly IEntryService _entryService;

    public EntryController(IEntryService entryService) {
        _entryService = entryService;
    }

    [HttpGet]
    public IEnumerable<Entry> GetAll()
    {
        var uid = UserConstants.GetUserID(HttpContext);
        var entries = _entryService.GetAll(uid);
        return entries;
    }

    [HttpPost]
    public Entry AddNewEntry([FromQuery(Name = "name")] string name, 
        [FromQuery(Name = "entryTypeId")] int entryTypeId, [FromQuery(Name = "amount")] float amount)
    {
        var uid = UserConstants.GetUserID(HttpContext);
        var entry = new Entry();
        entry.UserId = uid;
        entry.Amount = amount;
        entry.EntryTypeId = entryTypeId;
        entry.Name = name;
        var updatedEntry = _entryService.InsertInvestment(entry);
        return updatedEntry;
    }
    
    [HttpGet("types")]
    public IEnumerable<EntryType> GetAllEntryTypes()
    {
        return _entryService.GetAllEntryTypes();
    }

}