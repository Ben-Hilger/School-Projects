using SqlKata.Execution;
using api.Domain.DB;

namespace api.Domain.User;

public class UserService : IUserService
{
    private readonly UserRepository _userRepository;

    public UserService(IDbService dbService)
    {
        _userRepository = new UserRepository(dbService);
    }
    
    public User? GetById(string id)
    {
        return _userRepository.GetSelectQuery(id).First<User>();
    }

    public bool UserExists(string id)
    {
        return _userRepository.GetSelectQuery(id).Exists();
    }
    
    public User? UpdateUser(User user)
    {
        var affectedRows = _userRepository.UpdateByIdQuery(user.Id).Update(new {
            first_name = user.FirstName,
            last_name = user.LastName,
            email = user.Email
        });
        return affectedRows > 0 ? GetById(user.Id) : null;
    }

    public User? InsertUser(User user)
    {
        var affectedRows = _userRepository.GetBaseQuery().Insert(new
        {
            first_name = user.FirstName,
            last_name = user.LastName,
            email = user.Email,
            id = user.Id
        });
        return affectedRows > 0 ? GetById(user.Id) : null;
    }
    
    
    
}