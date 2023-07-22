using api.Domain;
using api.Domain.API;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers;

public class BaseController : ControllerBase
{
    protected string userUid;
    
    public BaseController()
    {
        object? value;
        HttpContext.Items.TryGetValue("uid", out value);
        if (value != null)
        {
            userUid = value as string ?? "";
        }
    }
    
    protected ApiResponse CreateApiResponse(int statusCode, Object? response)
    {
        ApiResponse apiResponse = new();
        apiResponse.StatusCode = statusCode;
        apiResponse.Result = response;
        Response.StatusCode = statusCode;
        return apiResponse;
    }
}