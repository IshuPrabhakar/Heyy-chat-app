using AutoMapper;
using Db;
using Dtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Serilog;
using Services.Mapper;

namespace src.Application.Endpoint.UserInfo;

public static class UpdateUserInfo
{
    public static async Task<IResult> Handle([FromBody] UserInfoRequest request, AppDbContext dbContext, HttpContext context)
    {
        string uuid = string.Empty;
        if (context is not null && !String.IsNullOrEmpty(context.Request.Cookies["userid"]))
            uuid = context.Request.Cookies["userid"]!;
        else
            return Results.BadRequest("Cookies not found.");

        // validate user info
        var dbObj = dbContext.User.Where(u => u.UUID == uuid).Select(x => x).FirstOrDefault();

        if (request is not null && dbObj is not null)
        {
            var UpdatedUser = ObjectMapper<UserInfoRequest, User>.Map(request, dbObj);
            dbContext.Entry(dbObj).CurrentValues.SetValues(UpdatedUser);
            var result = await dbContext.SaveChangesAsync();
            dbContext.Entry(dbObj).State = EntityState.Modified;

            return Results.Ok();
        }

        return Results.BadRequest();
    }
}