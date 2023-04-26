using System.ComponentModel.DataAnnotations;

namespace Domain;

public class DeviceInfos
{
    [Key]
    public int DeviceInfoId { get; set; }
    public string? Manufacturer { get; set; }
    public string? Model { get; set; }
    public string? Brand { get; set; }
    public string? OS { get; set; }
    public string? OSVersion { get; set; }
    public string? SecurityPatch { get; set; }
    public string? UUID { get; set; }
}