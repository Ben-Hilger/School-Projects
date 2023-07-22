using FirebaseAdmin.Auth;

namespace api.Domain.Authentication;

public class AuthService : IAuthService
{
    public async Task<string?> VerifyIdToken(string token)
    {
        try
        {
            var decodedToken = await FirebaseAuth.DefaultInstance.VerifyIdTokenAsync(token);
            return decodedToken.Uid;
        }
        catch (Exception)
        {
            return null;
        }
        
    }
}