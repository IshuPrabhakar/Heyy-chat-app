using CorePush;
using Db;
using Dtos;
using Microsoft.Extensions.Options;
using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace src.Application.Services.NotificationService;


public class NotificationService : INotificationService
{
    private readonly AppSettings _config;
    private readonly AppDbContext _dbContext;
    public NotificationService(IOptions<AppSettings> settings, AppDbContext dbContext)
    {
        _config = settings.Value;
        _dbContext = dbContext;
    }

    public Task<MessageDto> SendMessageNotification(MessageDto message)
    {
        throw new NotImplementedException();
    }

    // public async Task<ResponseModel> SendNotification(NotificationModel notificationModel)
    // {
    //     ResponseModel response = new ResponseModel();
    //     try
    //     {
    //         if (notificationModel.IsAndroiodDevice)
    //         {

    //             /* FCM Sender (Android Device) */
    //             FcmSettings settings = new FcmSettings()
    //             {
    //                 SenderId = _fcmNotificationSetting.SenderId,
    //                 ServerKey = _fcmNotificationSetting.ServerKey
    //             };
    //             HttpClient httpClient = new HttpClient();

    //             string authorizationKey = string.Format("keyy={0}", settings.ServerKey);
    //             string deviceToken = notificationModel.DeviceId;

    //             httpClient.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", authorizationKey);
    //             httpClient.DefaultRequestHeaders.Accept
    //                     .Add(new MediaTypeWithQualityHeaderValue("application/json"));

    //             DataPayload dataPayload = new DataPayload();
    //             dataPayload.Title = notificationModel.Title;
    //             dataPayload.Body = notificationModel.Body;

    //             GoogleNotification notification = new GoogleNotification();
    //             notification.Data = dataPayload;
    //             notification.Notification = dataPayload;

    //             var fcm = new FcmSender(settings, httpClient);
    //             var fcmSendResponse = await fcm.SendAsync(deviceToken, notification);

    //             if (fcmSendResponse.IsSuccess())
    //             {
    //                 response.IsSuccess = true;
    //                 response.Message = "Notification sent successfully";
    //                 return response;
    //             }
    //             else
    //             {
    //                 response.IsSuccess = false;
    //                 response.Message = fcmSendResponse.Results[0].Error;
    //                 return response;
    //             }
    //         }
    //         else
    //         {
    //             /* Code here for APN Sender (iOS Device) */
    //             //var apn = new ApnSender(apnSettings, httpClient);
    //             //await apn.SendAsync(notification, deviceToken);
    //         }
    //         return response;
    //     }
    //     catch (Exception ex)
    //     {
    //         response.IsSuccess = false;
    //         response.Message = "Something went wrong";
    //         return response;
    //     }
    // }

    // public Task<MessageDto> SendMessageNotification(MessageDto message)
    // {
    //     var OS = _dbContext.DeviceInfos.Where(d => d.UUID == message.UserId).Select(c => c.OS).ToList().FirstOrDefault();

    //     try
    //     {
    //         HttpClient httpClient = new HttpClient();

    //         string authorizationKey = string.Format("keyy={0}", _config.FcmConfig!.SenderKey);

    //         httpClient.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", authorizationKey);
    //         httpClient.DefaultRequestHeaders.Accept
    //                 .Add(new MediaTypeWithQualityHeaderValue("application/json"));

    //         // Preparing payload
    //     }
    //     catch (System.Exception)
    //     {

    //         throw;
    //     }

    //     return message;
    // }
}