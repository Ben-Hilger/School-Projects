namespace api.Constants;

public abstract class UserConstants
{
    public static string GetUserID(HttpContext context)
    {
        object? value;
        context.Items.TryGetValue("uid", out value);
        if (value != null)
        {
           return value as string ?? "";
        }
        return null;
    }
}