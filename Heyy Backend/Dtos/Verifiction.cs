namespace Dtos;


public class VerificationRequest
{
    public string? Hash { get; set; }

    public string? Email { get; set; }

    public string? Otp { get; set; }

    public DateTime? OtpSentTime { get; set; }
}