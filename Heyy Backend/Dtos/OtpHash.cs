namespace Dtos;

public class OtpHash
{
    public OtpHash(string Otp, string Hash)
    {
        OTP = Otp;
        OTPHash = Hash;
    }

    public string OTP { get; set; }
    public string OTPHash { get; set; }
}