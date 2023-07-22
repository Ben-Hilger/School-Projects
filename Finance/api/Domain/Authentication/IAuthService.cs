using FirebaseAdmin.Auth;

namespace api.Domain.Authentication;

public interface IAuthService
{
    public abstract Task<string?> VerifyIdToken(string token);
}