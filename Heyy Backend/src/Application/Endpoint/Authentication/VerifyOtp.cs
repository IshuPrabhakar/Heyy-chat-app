using AutoMapper;
using Db;
using Dtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Serilog;
using src.Application.Services.JwtService;
using src.Application.Services.OtpService;

namespace src.Application.Endpoint.Authentication;

public static class VerifyOtp
{
    /// <summary>
    /// Verifies otp
    /// </summary>
    /// <param name="request"></param>
    /// <param name="dbContext"></param>
    /// <param name="jwtService"></param>
    /// <returns></returns>
    public static async Task<IResult> Handle([FromBody] VerificationRequest request, AppDbContext dbContext, IJwtService jwtService)
    {
        // Perform validation
        if (request is not null)
        {
            // var diff = DateTime.Now - request.OtpSentTime;
            // if (diff != null && diff.Value.Minutes > 1)
            //     return Results.BadRequest( new { errorcode = "400a", desc = "OTP is expired"});

            var otpHash = new OtpService().HashOtp(request.Otp!);
            if (String.Compare(otpHash, request.Hash) == 0)
            {
                // for new user
                var user = dbContext.User.Where(u => u.Email == request.Email).Select(x => x).FirstOrDefault();

                if (user is null)
                {
                    // generate jwt
                    var newUserjwtToken = jwtService.CreateJwt(request.Email!, "user");
                    string UUID = Guid.NewGuid().ToString();
                    var newUserRefreshToken = jwtService.CreateRefreshToken(UUID);

                    await dbContext.User.AddAsync(new User()
                    {
                        Email = request.Email,
                        UUID = UUID,
                        RefreshToken = newUserRefreshToken.Token,
                    });
                    await dbContext.SaveChangesAsync();

                    return Results.Ok(new { Token = newUserjwtToken, exp = 7, refreshToken = newUserRefreshToken });
                }

                // for existing user
                var jwtToken = jwtService.CreateJwt(user.Email!, "user");
                var refreshToken = jwtService.CreateRefreshToken(user.UUID!);
                return Results.Ok(new { Token = jwtToken, exp = 7, refreshToken = refreshToken });
            }

            return Results.BadRequest(new { errorcode = "400b", desc = "Incorrect OTP" });
        }

        return Results.BadRequest(new { errorcode = "400d", desc = "Request is null" });
    }
}

// Error-Code | Description
// -----------+---------------
// 400a       | "OTP is Expired",
// 400b       | "Incorrect OTP",
// 400c       | "Email already exist",
// 400d       | "Request is null"