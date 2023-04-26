using AutoMapper;
using Db;
using Dtos;
using Microsoft.AspNetCore.Mvc;

namespace src.Application.Endpoint.UserInfo;

public static class GetUserInfo
{
    /// <summary>
    /// Returns user
    /// </summary>
    /// <param name="uuid"></param>
    /// <param name="dbContext"></param>
    /// <returns></returns>
    [ProducesResponseType(typeof(UserInfoResponse), StatusCodes.Status200OK)]
    public static IResult Handle(HttpContext context, AppDbContext dbContext)
    {
        string uuid = string.Empty;
        if (context is not null && !String.IsNullOrEmpty(context.Request.Cookies["userid"]))
            uuid = context.Request.Cookies["userid"]!;
        else
            return Results.BadRequest("Cookies not found.");

        var user = dbContext.User.Where(u => u.UUID == uuid).Select(x => x).FirstOrDefault();

        // mapping
        var mapingConfig = new MapperConfiguration(cfg => cfg.CreateMap<User, UserInfoResponse>());
        var mapper = new Mapper(mapingConfig);
        var response = mapper.Map<UserInfoResponse>(user);

        if (user is not null)
            return Results.Ok(response);
        else
            return Results.NotFound();
    }
}