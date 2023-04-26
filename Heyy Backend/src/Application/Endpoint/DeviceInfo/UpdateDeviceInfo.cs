using AutoMapper;
using Db;
using Domain;
using Dtos;
using Microsoft.AspNetCore.Mvc;
using Services.Mapper;

namespace src.Application.Endpoint.DeviceInfo;

public static class UpdateDeviceInfo
{
    public static async Task<IResult> Handle([FromBody] DeviceInfoRequest request, AppDbContext dbContext, HttpContext context)
    {
        // validate
        string uuid = string.Empty;
        if (context is not null && !String.IsNullOrEmpty(context.Request.Cookies["userid"]))
            uuid = context.Request.Cookies["userid"]!;
        else
            return Results.BadRequest("Cookies not found.");

        // validate user info
        var dbObj = dbContext.DeviceInfos.Where(u => u.UUID == uuid).Select(x => x).FirstOrDefault();

        if (request is not null && dbObj is not null)
        {
            var UpdatedUser = ObjectMapper<DeviceInfoRequest, DeviceInfos>.Map(request, dbObj);
            dbContext.Entry(dbObj).CurrentValues.SetValues(UpdatedUser);
            var result = await dbContext.SaveChangesAsync();

            if (result == 0)
                return Results.BadRequest("Cannot update.");
            else
                return Results.Ok();
        }

        return Results.BadRequest();
    }
}