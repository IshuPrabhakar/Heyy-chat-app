namespace Dtos;

public class RegistrationRequest
{
    public string? Email { get; set; }
}

public class RegistrationResponse
{
    public string? Hash { get; set; }

    public string? OtpSentTime { get; set; }
}