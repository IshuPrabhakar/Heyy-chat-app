using Db;
using Dtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using src.Application.Services.EmailService;
using src.Application.Services.OtpService;

namespace src.Application.Endpoint.Authentication;

public static class Register
{
    /// <summary>
    /// Registers an user
    /// </summary>
    /// <param name="Email"></param>
    /// <param name="config"></param>
    /// <param name="dbContext"></param>
    /// <returns></returns>
    [ProducesResponseType(typeof(RegistrationResponse), StatusCodes.Status200OK)]
    public static IResult Handle([FromBody] RegistrationRequest request, IEmailService emailService, AppDbContext dbContext)
    {
        // to add validation here
        // var result = dbContext.User.Where(u => u.Email == request.Email).Select(x => x).FirstOrDefault();
        // if(result is not null)
        //     return Results.BadRequest( new { errorcode = "400c", desc = "Email already exist" } );

        // Send verification email
        OtpService otpService = new();
        OtpHash otpHash = otpService.GeneratOTP();

        emailService.SendEmail(
            new EmailDto()
            {
                To = request.Email!,
                Subject = "Verification",
                Otp = otpHash.OTP,
            }
        );

        return Results.Ok(new RegistrationResponse() { OtpSentTime = DateTime.UtcNow.ToString("o"), Hash = otpHash.OTPHash });
    }
}

// Error-Code | Description
// -----------+---------------
// 400a       | "OTP is Expired",
// 400b       | "Incorrect OTP",
// 400c       | "Email already exist",
// 400d       | "Request is null"