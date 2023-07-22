
namespace api.Domain.Entry;

public class Entry {

    public int? Id { get; set; }
    
    public double Amount { get; set; }
    
    public string? Name { get; set; }

    public string? UserId { get; set; }

    public int EntryTypeId { get; set; }
    
    public string EntryTypeName { get; set; }

    
    public DateTime DateAddedUtc { get; set; }

    public DateTime DateModifiedUtc { get; set; }
    
    

}