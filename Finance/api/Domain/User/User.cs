namespace api.Domain.User;

public class User
{

    public User(string id, string? firstName = null, 
        string? lastName = null, string? email = null)
    {
        Id = id;
        FirstName = firstName;
        LastName = lastName;
        Email = email;
    }
    
    public string Id { get; set; }
    
    public string? FirstName { get; set; }
    
    public string? Email { get; set; }
    
    public string? LastName { get; set; }
    
    public string FullName => FirstName + " " + LastName;

}