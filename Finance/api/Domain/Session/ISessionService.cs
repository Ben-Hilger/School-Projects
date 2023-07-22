using FirebaseAdmin.Auth;

namespace api.Domain.Session;

public interface ISessionService
{

    public Task<string?> CreateSessionCookie(string token, SessionCookieOptions options);

    public CookieOptions GetSessionCookieOptions(TimeSpan expires);
    
}