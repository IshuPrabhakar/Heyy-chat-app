using Dtos;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace src.Application.Services.JwtService;

public class JwtService : IJwtService
{
    private readonly AppSettings _appSettings;

    public JwtService(IOptions<AppSettings> settings)
    {
        _appSettings = settings.Value;
    }

    public string CreateJwt(string email, string role)
    {
        SecurityTokenDescriptor descriptor = new SecurityTokenDescriptor()
        {
            Subject = new ClaimsIdentity(new[] {
                new Claim(JwtRegisteredClaimNames.Email, email),
                new Claim("role", role),
            }),
            Expires = DateTime.UtcNow.AddDays(7),
            Issuer = _appSettings.JWT!.Issuer,
            Audience = _appSettings.JWT!.Audience,
            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_appSettings.EncyptKey!)), SecurityAlgorithms.HmacSha256)
        };

        var tokenHandler = new JwtSecurityTokenHandler();
        var token = tokenHandler.CreateToken(descriptor);
        var jwtToken = tokenHandler.WriteToken(token);

        return jwtToken;
    }

    public RefreshToken CreateRefreshToken(string uuid)
    {
        var refreshToken = new RefreshToken()
        {
            Token = Convert.ToBase64String(RandomNumberGenerator.GetBytes(128)),
            CreatedAt = DateTime.Now,
            UUID = uuid,
        };

        return refreshToken;
    }
}