using api.Domain.API;
using api.Domain.User;
using Microsoft.AspNetCore.Mvc;
using api.Constants;
namespace api.Controllers;

[ApiController]
[Route("user")]
public class UserController : BaseController
{

    private readonly IUserService _userService;

    public UserController(IUserService userService)
    {
        _userService = userService;
    }
    
    [HttpGet]
    public ApiResponse GetUser()
    {
        var uid = UserConstants.GetUserID(HttpContext);
        var user = _userService.GetById(uid);
        return CreateApiResponse(200, user);
    }

    [HttpPost]
    public ApiResponse CreateUser(string uid, string email, string firstName, string? lastName)
    {
        if (_userService.UserExists(uid))
        {
            return CreateApiResponse(200, "User already exists");
        }
        var newUser = new User(uid, firstName, lastName, email);
        newUser = _userService.InsertUser(newUser);
        return CreateApiResponse(200, newUser);
    }

    [HttpPut]
    public ApiResponse UpdateUser(string uid, string email, string firstName, string? lastName)
    {
        if (!_userService.UserExists(uid))
        {
            return CreateApiResponse(200, "User doesn't exist, unable to update");
        }

        var updatedUser = new User(uid, firstName, lastName, email);
        updatedUser = _userService.UpdateUser(updatedUser);
        return CreateApiResponse(200, updatedUser);
    }
}