using System.ComponentModel.DataAnnotations;

public class Connection
{
    [Key]
    public int ConnectionId { get; set; }
    public string? From { get; set; }
    public string? To { get; set; }
}