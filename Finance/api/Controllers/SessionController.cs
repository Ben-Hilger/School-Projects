using api.Domain.Session;
using FirebaseAdmin.Auth;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers;

[ApiController]
[Route("api/session")]
public class SessionController : ControllerBase
{
    
    private readonly ISessionService _sessionService;

    public SessionController(ISessionService entryService) {
        _sessionService = entryService;
    }

    [HttpPost]
    public Session Login([FromQuery(Name = "idToken")] string idToken)
    {
        Session session = new();
        session.idToken = idToken;
        
        var options = new SessionCookieOptions()
        {
            ExpiresIn = TimeSpan.FromHours(24),
        };

        try
        {
            var sessionCookie = _sessionService.CreateSessionCookie(idToken, options).Result;
            var cookieOptions = _sessionService.GetSessionCookieOptions(options.ExpiresIn);
            Response.Cookies.Append("session", sessionCookie, cookieOptions);
            return session;
        }
        catch (Exception)
        {
            return session;
        }
    }
    
}