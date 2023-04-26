using AutoMapper;
using Db;
using Domain;
using Dtos;
using Microsoft.AspNetCore.Mvc;

namespace src.Application.Endpoint.DeviceInfo;

public static class InsertDeviceInfo
{
    public static async Task<IResult> Handle([FromBody] DeviceInfoRequest request, AppDbContext dbContext)
    {
        var mappingConfig = new MapperConfiguration(cfg => cfg.CreateMap<DeviceInfoRequest, DeviceInfos>());
        var mapper = new Mapper(mappingConfig);

        dbContext.DeviceInfos.Add(mapper.Map<DeviceInfos>(request));
        var result = await dbContext.SaveChangesAsync();

        if (result == 0)
            return Results.BadRequest(new { errorcode = "400e", desc = "Cannot update device Info" });
        else
            return Results.Ok();
    }
}

// Error-Code | Description
// -----------+---------------
// 400a       | "OTP is Expired",
// 400b       | "Incorrect OTP",
// 400c       | "Email already exist",
// 400d       | "Request is null"
// 400e       | "Cannot update device Info"