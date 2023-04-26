using Dtos;

namespace src.Application.Services.JwtService;

public interface IJwtService
{
    string CreateJwt(string email, string role);
    RefreshToken CreateRefreshToken(string uuid);
}