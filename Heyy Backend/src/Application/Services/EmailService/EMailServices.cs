using Dtos;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Options;
using MimeKit;
using MimeKit.Text;
using Serilog;

namespace src.Application.Services.EmailService
{
    public class EmailService : IEmailService
    {
        private readonly AppSettings _config;

        public EmailService(IOptions<AppSettings> config)
        {
            _config = config.Value;
        }

        public void SendEmail(EmailDto request)
        {
            try
            {
                var email = new MimeMessage();
                email.From.Add(MailboxAddress.Parse(_config.EmailSetting!.Username));
                email.To.Add(MailboxAddress.Parse(request.To));
                email.Subject = request.Subject;
                email.Body = new TextPart(TextFormat.Html) { Text = $"<div style=\"font-family: Helvetica,Arial,sans-serif;min-width:1000px;overflow:auto;line-height:2\"> <div style=\"margin:50px auto;width:70%;padding:20px 0\"> <div style=\"border-bottom:1px solid #eee\"> <a href=\"\" style=\"font-size:1.4em;color: #00466a;text-decoration:none;font-weight:600\">Heyy</a> </div> <p style=\"font-size:1.1em\">Hi,</p> <p>Thank you for choosing us. Use the following OTP to complete your Sign Up procedures. OTP is valid for 1 minutes</p><h2 style=\"background: #00466a;margin: 0 auto;width: max-content;padding: 0 10px;color: #fff;border-radius: 4px;\"> {request.Otp} </h2><p style=\"font-size:0.9em;\">Regards,<br />Team Heyy,</p><hr style=\"border:none;border-top:1px solid #eee\" /> <div style=\"float:right;padding:8px 0;color:#aaa;font-size:0.8em;line-height:1;font-weight:300\"></div></div></div>" };

                using var smtp = new SmtpClient();
                smtp.Connect(_config.EmailSetting!.Host, 587, SecureSocketOptions.StartTls);
                smtp.Authenticate(_config.EmailSetting!.Username, _config.EmailSetting!.Password);
                smtp.Send(email);
                smtp.Disconnect(true);
            }
            catch (System.Exception e)
            {
                Log.Information(e.ToString());
            }
        }
    }
}