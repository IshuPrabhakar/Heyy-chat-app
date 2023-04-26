using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class User
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int UserId { get; set; }
    public string? Name { get; set; }
    public string? Profession { get; set; }
    public string? Email { get; set; }
    public string? Mobile { get; set; }
    public string? UUID { get; set; }
    public string? Bio { get; set; }
    public string? ProfilePhotoUrl { get; set; }
    public string? RefreshToken { get; set; }
    public string? DeviceId { get; set; }

    // connections
}