namespace Dtos;

class ChatRequestNotification
{
    public string? name { get; set; }
    public string? senderUserId { get; set; }
    public string? recieverUserId { get; set; }
    public string? deviceId { get; set; }
    public string? chatroomId { get; set; } // sender room id
    public string? profilePic { get; set; }
    public string? rtcData { get; set; }
    public string? bio { get; set; }
    public string? profession { get; set; }
    public string? mobile { get; set; }
    public string? message { get; set; }
}