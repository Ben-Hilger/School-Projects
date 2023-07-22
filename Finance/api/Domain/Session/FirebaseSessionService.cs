namespace api.Domain.Session;
using FirebaseAdmin.Auth;

public class FirebaseSessionService : ISessionService 
{
    public async Task<string?> CreateSessionCookie(string token, SessionCookieOptions options)
    {
        var sessionCookie = await FirebaseAuth.DefaultInstance.CreateSessionCookieAsync(token, options);
        return sessionCookie;
    }

    public CookieOptions GetSessionCookieOptions(TimeSpan expires)
    {
        return new CookieOptions()
        {
            Expires = DateTimeOffset.UtcNow.Add(expires),
            HttpOnly = true,
            Secure = true
        };
    }
} 