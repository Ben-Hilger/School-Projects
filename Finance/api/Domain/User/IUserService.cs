namespace api.Domain.User;

public interface IUserService
{
    public User? GetById(string id);

    public bool UserExists(string id);

    public User? UpdateUser(User user);
    
    public User? InsertUser(User user);
}