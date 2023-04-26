using Db;
using Microsoft.AspNetCore.Mvc;

namespace src.Application.Endpoint.UserInfo;

public static class GetProfilePhoto
{
    /// <summary>
    /// Returns user
    /// </summary>
    /// <param name="uuid"></param>
    /// <param name="dbContext"></param>
    /// <returns></returns>
    [ProducesResponseType(StatusCodes.Status200OK)]
    public static IResult Handle(HttpContext context, AppDbContext dbContext)
    {
        string uuid = string.Empty;
        if (context is not null && !String.IsNullOrEmpty(context.Request.Cookies["userid"]))
            uuid = context.Request.Cookies["userid"]!;
        else
            return Results.BadRequest("Cookies not found.");

        var url = dbContext.User.Where(u => u.UUID == uuid).Select(x => x.ProfilePhotoUrl).FirstOrDefault();

        if (!String.IsNullOrEmpty(url) && (File.Exists(url)))
        {
            var mimeType = "image/png";
            return Results.File(url, contentType: mimeType);
        }
        else
            return Results.NotFound();
    }
}