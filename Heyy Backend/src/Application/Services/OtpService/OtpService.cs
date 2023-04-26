using System.Security.Cryptography;
using System.Text;
using Dtos;

namespace src.Application.Services.OtpService;

public class OtpService
{
    public OtpHash GeneratOTP()
    {
        Random random = new();
        var otp = random.Next(100000, 999999).ToString();

        return new OtpHash(otp, HashOtp(otp));
    }

    public string HashOtp(string otp)
    {
        SHA256 sha256 = SHA256.Create();
        byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(otp));

        var sb = new StringBuilder();
        for (int i = 0; i < bytes.Length; i++)
        {
            sb.Append(bytes[i].ToString("x2"));
        }

        return sb.ToString();
    }
}