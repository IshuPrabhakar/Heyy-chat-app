using Dtos;

namespace src.Application.Services.EmailService;

public interface IEmailService
{
    void SendEmail(EmailDto request);
}