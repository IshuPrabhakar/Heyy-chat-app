namespace Dtos;

public class UserInfoRequest
{
    public string? Name { get; set; }
    public string? Profession { get; set; }
    public string? Mobile { get; set; }
    public string? Bio { get; set; }
    public string? DeviceId { get; set; }
}

public class UserInfoResponse
{
    public string? Name { get; set; }
    public string? Profession { get; set; }
    public string? Mobile { get; set; }
    public string? Bio { get; set; }
    public string? Email { get; set; }
    public string? ProfilePhotoUrl { get; set; }
}