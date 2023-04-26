namespace Dtos;

public class NotificationDto
{
    public string? Topic { get; set; }
    public Notification? Notification { get; set; }
    public Object? Data { get; set; }
    public Android? Android { get; set; }
}

// TODO: Not ready to use
class Apns
{
    public object? Headers { get; set; } = new { Priority = "apns-priority", };
}

public class Android
{
    public string? Priority { get; set; }
}

public class Notification
{
    public string? Body { get; set; }
    public string? Title { get; set; }
}
