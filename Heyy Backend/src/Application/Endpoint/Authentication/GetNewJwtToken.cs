using Db;
using src.Application.Services.JwtService;

namespace src.Application.Endpoint.Authentication;

public static class GetNewJwtToken
{
    public static IResult Handle(HttpContext context, AppDbContext dbContext, IJwtService jwtService)
    {
        string refreshToken = string.Empty;
        if (context is not null && !String.IsNullOrEmpty(context.Request.Cookies["refreshToken"]))
            refreshToken = context.Request.Cookies["refreshToken"]!;
        else
            return Results.BadRequest("Cookies not found.");

        var user = dbContext.User.Where(u => u.RefreshToken == refreshToken).Select(x => x).FirstOrDefault();

        if (user is not null)
        {
            var newJwtToken = jwtService.CreateJwt(user.Email!, "user");
            return Results.Ok(new { Token = newJwtToken, exp = 7 });
        }
        else
            return Results.BadRequest("Invalid Token");
    }
}