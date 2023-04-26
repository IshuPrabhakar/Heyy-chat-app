using System.Threading.Tasks;
using Dtos;

namespace src.Application.Services.NotificationService;

public interface INotificationService
{
    Task<MessageDto> SendMessageNotification(MessageDto message);
}