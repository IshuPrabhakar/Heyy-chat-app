namespace Dtos;

public class DeviceInfoRequest
{
    public string? Manufacturer { get; set; }
    public string? Model { get; set; }
    public string? Brand { get; set; }
    public string? OS { get; set; }
    public string? OSVersion { get; set; }
    public string? SecurityPatch { get; set; }
    public string? UUID { get; set; }
}