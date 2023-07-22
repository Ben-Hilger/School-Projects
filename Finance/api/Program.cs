using api.Domain.Authentication;
using api.Domain.User;
using api.Domain.Entry;
using api.Domain.DB;
using api.Domain.Secret;
using api.Domain.Session;
using FirebaseAdmin;
using FirebaseAdmin.Auth;
using Google.Apis.Auth.OAuth2;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IAuthService, AuthService>();
builder.Services.AddTransient<IEntryService, EntryService>();
builder.Services.AddTransient<ISessionService, FirebaseSessionService>();
builder.Services.AddTransient<ISecretService, GoogleSecretService>();

builder.Services.AddScoped<IDbService, DbService>();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
// builder.Services.AddEndpointsApiExplorer();
// builder.Services.AddSwaggerGen();

builder.Services.AddCors();

var app = builder.Build();

FirebaseApp.Create(new AppOptions()
{
    Credential = GoogleCredential.GetApplicationDefault()
});

// Configure the HTTP request pipeline.
// if (app.Environment.IsDevelopment())
// {
//     app.UseSwagger();
//     app.UseSwaggerUI();
// }

app.UseCors(corsBuilder =>
{
    corsBuilder
        .AllowAnyOrigin()
        .AllowAnyMethod()
        .AllowAnyHeader();
});

// app.UseHttpsRedirection();
//
// app.UseAuthorization();

app.Use(async (context, next) =>
{
    if (context.Request.Path.Equals("/api/session"))
    {
        await next(context);
        return;
    }
    try
    {
        var sessionCookie = context.Request.Cookies["session"];
        if (string.IsNullOrEmpty(sessionCookie))
        {
            throw new Exception("No session found");
        }
        
        var decodedToken = await FirebaseAuth.DefaultInstance.VerifySessionCookieAsync(
            sessionCookie, true);
        context.Items.Add("uid", decodedToken.Uid);
        await next(context);
    }
    catch (Exception)
    {
        context.Response.StatusCode = 401;
        await context.Response.CompleteAsync();
    }
});

app.MapControllers();

app.Run();
