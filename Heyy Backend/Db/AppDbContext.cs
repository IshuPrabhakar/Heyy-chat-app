using Microsoft.EntityFrameworkCore;
using Domain;

namespace Db;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions options) : base(options)
    {
    }

    public DbSet<User> User { get; set; }
    public DbSet<Connection> Connection { get; set; }
    public DbSet<DeviceInfos> DeviceInfos { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<User>().HasKey(u => u.UserId);
    }
}