using Db;
using src.Application.Endpoint.Authentication;
using src.Application.Endpoint.DeviceInfo;
using src.Application.Endpoint.Search;
using src.Application.Endpoint.UserInfo;
using src.Application.Hubs.RtcHubs;

public class Module : IModule
{
    public void MapEndpoints(WebApplication app)
    {
        // Authentication API's
        app.MapPost("/app/api/register", Register.Handle).WithTags("Authentication");
        app.MapPost("/app/api/verify", VerifyOtp.Handle).WithTags("Authentication");
        app.MapPost("/app/api/get-token", GetNewJwtToken.Handle).WithTags("Authentication");

        // Data access api
        app.MapPut("/app/api/user-info", UpdateUserInfo.Handle)
            .WithTags("UserInfo")
            .RequireAuthorization("user");

        app.MapGet("/app/api/user-info", GetUserInfo.Handle)
            .WithTags("UserInfo")
            .RequireAuthorization("user");

        app.MapGet("/app/api/user-info/photo", GetProfilePhoto.Handle)
            .WithTags("UserInfo")
            .RequireAuthorization("user");

        app.MapPost("/app/api/user-info/photo", UploadProfilePhoto.Handle)
            .WithTags("UserInfo")
            .RequireAuthorization("user");

        app.MapPost("/app/api/device-info", InsertDeviceInfo.Handle)
            .WithTags("DeviceInfo");

        app.MapPut("/app/api/device-info", UpdateDeviceInfo.Handle)
            .WithTags("DeviceInfo")
            .RequireAuthorization("user");

        // Search
        app.MapPost("/app/api/search", Search.Handle)
            .WithTags("Search");
        app.MapPost("/app/api/search-contacts", SearchContacts.Handle)
            .WithTags("Search");

        app.MapPost("/app/api/search-all", (AppDbContext dbContext) =>
        {
            return Results.Ok(dbContext.User.Select(x => x).ToList());
        })
           .WithTags("Search");


        // Hubs
        app.MapHub<MessageHub>("rtc/message")
        .WithTags("Hubs");
    }

}
